const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// INSERT Carrito
router.post('/carrito', (req, res) => {
    const { idPacientes, idMedicamentos, cantidad } = req.body;
    const query = `insert into carrito(idPacientes, idMedicamentos, cantidad) values (?,?,?)`;
    mysqlConnection.query(query, [idPacientes, idMedicamentos, cantidad], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idPacientes,
                idMedicamentos,
                cantidad
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET carrito de un paciente
router.get('/pacientes/:idPacientes/carrito', (req, res) => {
    const { idPacientes } = req.params;
    mysqlConnection.query('select idPacientes, idMedicamentos, sum(cantidad) cantidad, m.id, m.nombre, m.descripcion, m.foto, m.costo from carrito c join medicamentos m on c.idMedicamentos = m.id where idPacientes = ? group by idMedicamentos,idPacientes;    ', [idPacientes], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Carrito not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE carrito de un paciente
router.delete('/pacientes/:idPacientes/carrito', (req, res) => {
    const { idPacientes } = req.params;
    mysqlConnection.query('delete from carrito where idPacientes = ? ', [idPacientes], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send({
                    status: 'delete',
                })
            else
                res.status(404).send({ message: 'Carrito not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET medicamento carrito de un paciente
router.get('/pacientes/:idPacientes/carrito/:idMedicamentos', (req, res) => {
    const { idPacientes, idMedicamentos } = req.params;
    mysqlConnection.query('select c.cantidad, m.id, m.nombre, m.descripcion, m.descripcion, m.foto from carrito c join medicamentos m on c.idMedicamentos = m.id where c.idPacientes = ? and c.idMedicamentos = ?', [idPacientes, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Carrito not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT Carrito
router.post('/pacientes/:idPacientes/carrito/:idMedicamentos', (req, res) => {
    const { idPacientes, idMedicamentos } = req.params
    const { cantidad } = req.body;
    const query = `insert into carrito(idPacientes, idMedicamentos, cantidad) values (?,?,?)`;
    mysqlConnection.query(query, [idPacientes, idMedicamentos, cantidad], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idPacientes,
                idMedicamentos,
                cantidad
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// UPDATE medicamento del carrito
router.put('/pacientes/:idPacientes/carrito/:idMedicamentos', (req, res) => {
    const { idPacientes, idMedicamentos } = req.params
    const { cantidad } = req.body;
    const query = `update carrito set cantidad = ? where idPacientes = ? and idMedicamentos = ?`;
    mysqlConnection.query(query, [cantidad, idPacientes, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Updated',
                idPacientes,
                idMedicamentos,
                cantidad
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE medicamento del carrito
router.delete('/pacientes/:idPacientes/carrito/:idMedicamentos', (req, res) => {
    const { idPacientes, idMedicamentos } = req.params
    const query = `delete from carrito where idPacientes = ? and idMedicamentos = ?`;
    mysqlConnection.query(query, [idPacientes, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' deleted',
                idPacientes,
                idMedicamentos
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;