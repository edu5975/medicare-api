const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');
const axiosController = require('../controller/axiosController');
const config = require('../config.js')

// INSERT venta
router.post('/ventas', (req, res) => {
    const { idPacientes, total } = req.body;
    fecha = Date.now();
    const query = `insert into ventas(idPacientes, total, fecha) values (?,?,curdate());`;
    mysqlConnection.query(query, [idPacientes, total], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',                
id: rows.insertId,
                idPacientes,
                total,
                fecha
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET ventas
router.get('/ventas', (req, res) => {
    const query = `select * from ventas`;
    mysqlConnection.query(query, [], (err, rows, fields) => {
        if (!err) {
            res.status(200).send(rows);
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET ventas especifica
router.get('/ventas/:idVenta', (req, res) => {
    const { idVenta } = req.params;
    const query = `select * from ventas where id = ?`;
    mysqlConnection.query(query, [idVenta], async(err, rows, fields) => {
        if (!err) {
            var ventas_medicamentos = await axiosController.getAxios(config.host + '/ventas/' + idVenta + '/medicamentos');
            if (ventas_medicamentos.length) {
                rows[0].ventas_medicamentos = ventas_medicamentos;
            }
            res.status(200).send(rows[0]);
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// UPDATE ventas especifica
router.put('/ventas/:idVenta', (req, res) => {
    const { total } = req.body;
    const { idVenta } = req.params;
    const query = `update ventas set total = ? where id = ?;`;
    mysqlConnection.query(query, [total, idVenta], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Updated',
                idVenta
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETA ventas especifica
router.delete('/ventas/:idVenta', (req, res) => {
    const { idVenta } = req.params;
    const query = `delete from ventas where id = ?`;
    mysqlConnection.query(query, [idVenta], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Deleted',
                idVenta
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET compras de un paciente
router.get('/pacientes/:idPacientes/ventas', (req, res) => {
    const { idPacientes } = req.params;
    mysqlConnection.query('select v.id, v.total, v.fecha from ventas v join pacientes p on v.idPacientes = p.id where v.idPacientes = ? ', [idPacientes], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'No hay compras' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;