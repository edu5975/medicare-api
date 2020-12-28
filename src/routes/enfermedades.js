const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET todas las enfermedades
router.get('/enfermedades', (req, res) => {
    mysqlConnection.query('SELECT * FROM enfermedades', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'enfermedades not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una enfermedad
router.get('/enfermedades/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM enfermedades WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Enfermedad not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una enfermedad
router.delete('/enfermedades/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM enfermedades WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Enfermedad Deleted' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una enfermedad
router.post('/enfermedades', (req, res) => {
    const { descripcion } = req.body;
    const query = `
    insert into enfermedades(descripcion) values (?);
  `;
    mysqlConnection.query(query, [descripcion], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Enfermedad Saved',
                enfermedades: {
                    id: rows.insertId,
                    descripcion
                }
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una enfermedad
router.put('/enfermedades/:id', (req, res) => {
    const { descripcion } = req.body;
    const { id } = req.params;
    const query = `
    update enfermedades set descripcion = ? where id = ?;
  `;
    mysqlConnection.query(query, [descripcion, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Enfermedad Updated',
                    enfermedades: {
                        id,
                        descripcion
                    }
                });
            else
                res.status(404).send({ message: 'Enfermedad not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;