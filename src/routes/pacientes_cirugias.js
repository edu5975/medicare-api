const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

//CIRUGIAS ----------------------------------------------------------------------
// GET cirugias de un paciente
router.get('/pacientes/:id/cirugias', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select id,descripcion from pacientes_cirugias pc join cirugias c on pc.idCirugias = c.id where idPacientes = ? ', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Paciente or cirugias not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//GET paciente y cirugia especifica
router.get('/pacientes/:idPacientes/cirugias/:idCirugias', (req, res) => {
    const { idPacientes, idCirugias } = req.params;
    mysqlConnection.query('select id,descripcion from pacientes_cirugias pe join cirugias e on e.id = idCirugias WHERE pe.idPacientes = ? and id = ?', [idPacientes, idCirugias], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Paciente or cirugias not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una cirugias de un paciente
router.delete('/pacientes/:idPacientes/cirugias/:idCirugias', (req, res) => {
    const { idPacientes, idCirugias } = req.params;
    mysqlConnection.query('delete from pacientes_cirugias where idPacientes = ? and idCirugias = ?', [idPacientes, idCirugias], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Paciente ' + idPacientes + ' se borro la enfermedad ' + idCirugias });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE todas las cirugias de un paciente
router.delete('/pacientes/:idPacientes/cirugias', (req, res) => {
    const { idPacientes } = req.params;
    mysqlConnection.query('delete from pacientes_cirugias where idPacientes = ?', [idPacientes], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Paciente ' + idPacientes + ' se borro las cirugias ' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una cirugia a un paciente
router.post('/pacientes/:idPacientes/cirugias/:idCirugias', (req, res) => {
    const { idPacientes, idCirugias } = req.params;
    const query = `insert into pacientes_cirugias(idPacientes, idCirugias) values (?,?)`;
    mysqlConnection.query(query, [idPacientes, idCirugias], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idPacientes,
                idCirugias
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;