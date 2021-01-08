const express = require('express');
const upload = require('../controller/multerController.js');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET todas las medicamentos
router.get('/medicamentos', (req, res) => {
    mysqlConnection.query('SELECT * FROM medicamentos', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'medicamentos not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una medicamento
router.get('/medicamentos/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM medicamentos WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'medicamento not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una medicamento
router.delete('/medicamentos/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM medicamentos WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Medicamentos Deleted' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una medicamentos
router.post('/medicamentos', (req, res) => {
    upload.single('foto');
    foto = upload.url;

    const { nombre, descripcion, costo } = req.body;
    const query = `
    insert into medicamentos(nombre, descripcion, costo, foto ) values (?,?,?,?);
  `;
    mysqlConnection.query(query, [nombre, descripcion, costo, foto], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Medicamentos Saved',
                medicamentos: {
                    id: rows.insertId,
                    nombre,
                    descripcion,
                    costo,
                    foto
                }
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una medicamentos
router.put('/medicamentos/:id', (req, res) => {
    const { nombre, descripcion, costo, foto } = req.body;
    const { id } = req.params;
    const query = `
    update medicamentos set nombre = ?, descripcion = ?, costo =?, foto = ? where id = ?;
  `;
    mysqlConnection.query(query, [nombre, descripcion, costo, foto, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'medicamento Updated',
                    medicamentos: {
                        id,
                        nombre,
                        descripcion,
                        costo,
                        foto
                    }
                });
            else
                res.status(404).send({ message: 'medicamentos not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;