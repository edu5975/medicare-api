const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

router.get('/medicos/:id/consultas', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select * from medicos_consultas mc join medicos m on mc.idConsultas = m.id where idMedicos = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//GET medico y consulta especifica
router.get('/medicos/:idMedicos/consultas/:idConsultas', (req, res) => {
    const { idMedicos, idConsultas } = req.params;
    mysqlConnection.query('select * from medicos_consultas mc join medicos m on mc.idConsultas = m.id where idMedicos = ? and idConsultas = ?;', [idMedicos, idConsultas], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE medico consulta
router.delete('/medicos/:idMedicos/consultas/:idConsultas', (req, res) => {
    const { idMedicos, idConsultas } = req.params;
    mysqlConnection.query('delete from medicos_consultas where idMedicos = ? and idConsultas = ?', [idMedicos, idConsultas], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'deleted' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT medico consulta
router.post('/medicos/:idMedicos/consultas/:idConsultas', (req, res) => {
    const { idMedicos, idConsultas } = req.params;
    const query = `insert into medicos_consultas(idMedicos, idConsultas) values (?,?)`;
    mysqlConnection.query(query, [idMedicos, idConsultas], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idMedicos,
                idConsultas
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;