const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

//ALERGIAS ----------------------------------------------------------------------
// GET enfermedades de un alergias
router.get('/pacientes/:id/alergias', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select id,descripcion from pacientes_alergias pa join alergias a on pa.idAlergias = a.id where idPacientes = ? ', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Paciente or alergias not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//GET paciente y alergia especifica
router.get('/pacientes/:idPacientes/alergias/:idAlergias', (req, res) => {
    const { idPacientes, idAlergias } = req.params;
    mysqlConnection.query('select id,descripcion from pacientes_alergias pe join alergias e on e.id = idAlergias WHERE pe.idPacientes = ? and id = ?', [idPacientes, idAlergias], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Paciente or alergia not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una alergias de un paciente
router.delete('/pacientes/:idPacientes/alergias/:idAlergias', (req, res) => {
    const { idPacientes, idAlergias } = req.params;
    mysqlConnection.query('delete from pacientes_alergias where idPacientes = ? and idAlergias = ?', [idPacientes, idAlergias], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Paciente ' + idPacientes + ' se borro la enfermedad ' + idAlergias });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una alergias a un paciente
router.post('/pacientes/:idPacientes/alergias/:idAlergias', (req, res) => {
    const { idPacientes, idAlergias } = req.params;
    const query = `insert into pacientes_alergias(idPacientes, idAlergias) values (?,?)`;
    mysqlConnection.query(query, [idPacientes, idAlergias], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                pacientes_enfermedad: {
                    idPacientes,
                    idAlergias
                }
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;