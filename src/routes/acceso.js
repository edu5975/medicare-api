const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// VERIFICAR ACCESO
router.post('/login', (req, res) => {
    const { user, password } = req.body;
    const query = `select id from pacientes where user = ? and password = ?;`;
    mysqlConnection.query(query, [user, password], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send({
                    status: 'Correct',
                    id: rows[0].id,
                    role: 0
                })
            else {
                const query2 = `select id from medicos where user = ? and password = ?;`;
                mysqlConnection.query(query2, [user, password], (err, rows, fields) => {
                    if (!err) {
                        if (rows.length != 0)
                            res.status(200).send({
                                status: 'Correct',
                                id: rows[0].id,
                                role: 1
                            })
                        else
                            res.status(404).send({
                                message: 'Not found',
                                status: 'Error'
                            })
                    } else {
                        res.status(500).send({
                            message: err,
                            status: 'Error'
                        })
                    }
                });
            }
        } else {
            res.status(500).send({
                message: err,
                status: 'Error'
            })
        }
    });
});

router.get('/login2', (req, res) => {
    res.status(200).send({
        status: 'Correct',
        id: 1,
        role: 0
    })
});

module.exports = router;