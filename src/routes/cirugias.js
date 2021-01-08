const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET todas las cirugias
router.get('/cirugias', (req, res) => {
    mysqlConnection.query('SELECT * FROM cirugias', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Cirugias not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una cirugias
router.get('/cirugias/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM cirugias WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Cirugia not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una cirugias
router.delete('/cirugias/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM cirugias WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Cirugia Deleted' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una cirugia
router.post('/cirugias', (req, res) => {
    const { descripcion } = req.body;
    const query = `
    insert into cirugias(descripcion) values (?);
  `;
    mysqlConnection.query(query, [descripcion], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Cirugia Saved',
                id: rows.insertId,
                descripcion
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una cirugias
router.put('/cirugias/:id', (req, res) => {
    const { descripcion } = req.body;
    const { id } = req.params;
    const query = `
    update cirugias set descripcion = ? where id = ?;
  `;
    mysqlConnection.query(query, [descripcion, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Cirugia Updated',
                    id,
                    descripcion
                });
            else
                res.status(404).send({ message: 'Cirugia not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;