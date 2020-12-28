const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET todas las alergias
router.get('/alergias', (req, res) => {
    mysqlConnection.query('SELECT * FROM alergias', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Alergias not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una alergia
router.get('/alergias/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM alergias WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Alergia not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una alergia
router.delete('/alergias/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM alergias WHERE id = ?', [id], (err, rows, fields) => {

        console.log(rows);
        if (!err) {
            res.status(200).send({ status: 'Alergia Deleted: ' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una alergia
router.post('/alergias', (req, res) => {
    const { descripcion } = req.body;
    const query = `
    insert into alergias(descripcion) values (?);
  `;
    mysqlConnection.query(query, [descripcion], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Alergias Saved',
                alergias: {
                    id: rows.insertId,
                    descripcion
                }
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una alergia
router.put('/alergias/:id', (req, res) => {
    const { descripcion } = req.body;
    const { id } = req.params;
    const query = `
    update alergias set descripcion = ? where id = ?;
  `;
    mysqlConnection.query(query, [descripcion, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Alergias Updated',
                    alergias: {
                        id,
                        descripcion
                    }
                });
            else
                res.status(404).send({ message: 'Alergia not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;