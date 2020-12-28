const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET todas las especialidades
router.get('/especialidades', (req, res) => {
    mysqlConnection.query('SELECT * FROM especialidades', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Especialidades not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una especialidad
router.get('/especialidades/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM especialidades WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Especialidad not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una especialidad
router.delete('/especialidades/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM especialidades WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Especialidad Deleted' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una especialidad
router.post('/especialidades', (req, res) => {
    const { descripcion } = req.body;
    const query = `
    insert into especialidades(descripcion) values (?);
  `;
    mysqlConnection.query(query, [descripcion], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Especialidad Saved',
                especialidades: {
                    id: rows.insertId,
                    descripcion
                }
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una especialidad
router.put('/especialidades/:id', (req, res) => {
    const { descripcion } = req.body;
    const { id } = req.params;
    const query = `
    update especialidades set descripcion = ? where id = ?;
  `;
    mysqlConnection.query(query, [descripcion, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Especialidad Updated',
                    especialidades: {
                        id,
                        descripcion
                    }
                });
            else
                res.status(404).send({ message: 'Especialidad not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;