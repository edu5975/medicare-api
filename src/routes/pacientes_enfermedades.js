const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

//ENFERMEDADES ----------------------------------------------------------------------
// GET enfermedades de un paciente
router.get('/pacientes/:id/enfermedades', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select id,descripcion from pacientes_enfermedades pe join enfermedades e on e.id = idEnfermedades WHERE pe.idPacientes = ? ', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Paciente or enfermedades not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//GET paciente y enfermedad especifica
router.get('/pacientes/:idPacientes/enfermedades/:idEnfermedades', (req, res) => {
    const { idPacientes, idEnfermedades } = req.params;
    mysqlConnection.query('select id,descripcion from pacientes_enfermedades pe join enfermedades e on e.id = idEnfermedades WHERE pe.idPacientes = ? and id = ?', [idPacientes, idEnfermedades], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Paciente or enfermedades not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una enfermedad de un paciente
router.delete('/pacientes/:idPacientes/enfermedades/:idEnfermedades', (req, res) => {
    const { idPacientes, idEnfermedades } = req.params;
    mysqlConnection.query('delete from pacientes_enfermedades where idPacientes = ? and idEnfermedades = ?', [idPacientes, idEnfermedades], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Paciente ' + idPacientes + ' se borro la enfermedad ' + idEnfermedades });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una enfermedad a un paciente
router.post('/pacientes/:idPacientes/enfermedades/:idEnfermedades', (req, res) => {
    const { idPacientes, idEnfermedades } = req.params;
    const query = `insert into pacientes_enfermedades(idPacientes, idEnfermedades) values (?,?)`;
    mysqlConnection.query(query, [idPacientes, idEnfermedades], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idPacientes,
                idEnfermedades
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;