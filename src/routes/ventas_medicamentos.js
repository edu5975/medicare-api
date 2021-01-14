const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET medicamentos de una venta
router.get('/ventas/:idVenta/medicamentos', (req, res) => {
    const { idVenta } = req.params;
    mysqlConnection.query('select m.id, m.nombre, m.foto, vm.cantidad,vm.total from ventas_medicamentos vm join medicamentos m on vm.idMedicamentos = m.id where vm.idVentas = ? ', [idVenta], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET medicamentos especifico de una venta
router.get('/ventas/:idVenta/medicamentos/:idMedicamentos', (req, res) => {
    const { idVenta, idMedicamentos } = req.params;
    mysqlConnection.query('select m.id, m.nombre, m.foto, vm.cantidad,vm.total from ventas_medicamentos vm join medicamentos m on vm.idMedicamentos = m.id where vm.idVentas = ? and m.id = ?', [idVenta, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT ventas_medicamentos
router.post('/ventas/:idVentas/medicamentos/:idMedicamentos', (req, res) => {
    const { idVentas, idMedicamentos } = req.params;
    const { cantidad, total } = req.body;
    const query = `insert into ventas_medicamentos(idVentas, idMedicamentos, cantidad, total) values (?,?,?,?)`;
    mysqlConnection.query(query, [idVentas, idMedicamentos, cantidad, total], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idVentas,
                idMedicamentos,
                cantidad,
                total
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// UPDATE medicamento del carrito
router.put('/ventas/:idVentas/medicamentos/:idMedicamentos', (req, res) => {
    const { idVentas, idMedicamentos } = req.params;
    const { cantidad, total } = req.body;
    const query = `update ventas_medicamentos set cantidad = ?, total = ? where idVentas = ? and idMedicamentos = ?`;
    mysqlConnection.query(query, [cantidad, total, idVentas, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Updated',
                idVentas,
                idMedicamentos,
                cantidad,
                total
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE medicamento del carrito
router.delete('/ventas/:idVentas/medicamentos/:idMedicamentos', (req, res) => {
    const { idVentas, idMedicamentos } = req.params;
    const query = `delete from ventas_medicamentos where idVentas = ? and idMedicamentos = ?`;
    mysqlConnection.query(query, [idVentas, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' deleted',
                idVentas,
                idMedicamentos
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;