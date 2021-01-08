const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET servicios de un medico
router.get('/medicos/:id/servicios', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select id,descripcion,costo from servicios_medicos sm join servicios s on sm.idServicios = s.id where idMedicos = ? ', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Medico or servicios not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//GET medico y servicio especifica
router.get('/medicos/:idMedicos/servicios/:idServicios', (req, res) => {
    const { idMedicos, idServicios } = req.params;
    mysqlConnection.query('select id,descripcion,costo from servicios_medicos sm join servicios s on sm.idServicios = s.id where idMedicos = ? and idServicios = ?', [idMedicos, idServicios], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Medico or servicios  not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE un servicio de un medico
router.delete('/medicos/:idMedicos/servicios/:idServicios', (req, res) => {
    const { idMedicos, idServicios } = req.params;
    mysqlConnection.query('delete from servicios_medicos where idMedicos = ? and idServicios = ?', [idMedicos, idServicios], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Medico ' + idMedicos + ' se borro el servicio ' + idServicios });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT un servicio a un medico
router.post('/medicos/:idMedicos/servicios/:idServicios', (req, res) => {
    const { idMedicos, idServicios } = req.params;
    const { costo } = req.body;
    const query = `insert into servicios_medicos(idMedicos, idServicios,costo) values (?,?,?)`;
    mysqlConnection.query(query, [idMedicos, idServicios, costo], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idMedicos,
                idServicios,
                costo
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;