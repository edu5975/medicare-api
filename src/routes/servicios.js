const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET todas las servicios
router.get('/servicios', (req, res) => {
    mysqlConnection.query('SELECT * FROM servicios', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Servicios not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET un servicio
router.get('/servicios/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM servicios WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Servicio not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE un servicio
router.delete('/servicios/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM servicios WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Servicio Deleted ' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT un servicio
router.post('/servicios', (req, res) => {
    const { descripcion } = req.body;
    const query = `
    insert into servicios(descripcion) values (?);
  `;
    mysqlConnection.query(query, [descripcion], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Servicio Saved',
                id: rows.insertId,
                descripcion
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE un servicio
router.put('/servicios/:id', (req, res) => {
    const { descripcion } = req.body;
    const { id } = req.params;
    const query = `
    update servicios set descripcion = ? where id = ?;
  `;
    mysqlConnection.query(query, [descripcion, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Servicio Updated',
                    id,
                    descripcion
                });
            else
                res.status(404).send({ message: 'Servicio not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;