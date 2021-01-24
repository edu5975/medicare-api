const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

router.get('/medicos/:id/consultas', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query("select idMedicos, idConsultas, concat(p.nombres,' ',p.apellidoMaterno,' ',p.apellidoPaterno) paciente, c.sintomas from medicos_consultas mc join medicos m on mc.idMedicos = m.id join consultas c on c.id = mc.idConsultas join pacientes p on c.idPaciente = p.id where idMedicos = ?    ", [id], (err, rows, fields) => {
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

router.get('/pacientes/consultas/:id/medicos', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query("select idMedicos, idConsultas, concat(m.nombres,' ',m.apellidoMaterno,' ',m.apellidoPaterno), m.telefono, m.email, m.pais, m.estado, m.municipio medico from medicos_consultas mc join medicos m on mc.idMedicos = m.id join consultas c on c.id = mc.idConsultas join pacientes p on c.idPaciente = p.id where idConsultas = ?    ", [id], (err, rows, fields) => {
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