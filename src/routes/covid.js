const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET todos covid
router.get('/covid', (req, res) => {
    mysqlConnection.query('SELECT * FROM covid', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Covid not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET un covid
router.get('/covid/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM covid WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Covid not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE un covid
router.delete('/covid/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM covid WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Covid Deleted' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT un covid
router.post('/covid', (req, res) => {
    const { idPaciente, idMedico, estado } = req.body;
    const query = `
    insert into covid(idPaciente, idMedico, estado, fecha) values
    (?,?,?,current_date);
  `;
    mysqlConnection.query(query, [idPaciente, idMedico, estado], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Covid Saved',
                id: rows.insertId,
                idPaciente,
                idMedico,
                estado,
                fecha: Date.now()
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET estados de un paciente
router.get('/pacientes/:id/covid', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select c.id, c.idPaciente, c.idMedico, c.estado, c.fecha from covid c join pacientes p on c.idPaciente = p.id WHERE c.idPaciente = ? ', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Covid not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET dicho de un medico
router.get('/medicos/:id/covid', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select c.id, c.idPaciente, c.idMedico, c.estado, c.fecha from covid c join medicos m on c.idMedico = m.id WHERE c.idMedico = ? ', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Covid not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;