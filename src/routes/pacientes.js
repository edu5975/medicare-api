const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');
const axiosController = require('../controller/axiosController');
const config = require('../config.js')

// GET todas las pacientes
router.get('/pacientes', (req, res) => {
    mysqlConnection.query('SELECT * FROM pacientes', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Pacientes not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET un paciente
router.get('/pacientes/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM pacientes WHERE id = ?', [id], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                var enfermedades = await axiosController.getAxios(config.host + '/pacientes/' + id + '/enfermedades');
                if (enfermedades.length) {
                    rows[0].enfermedades = enfermedades;
                }
                var alergias = await axiosController.getAxios(config.host + '/pacientes/' + id + '/alergias');
                if (alergias.length) {
                    rows[0].alergias = alergias;
                }
                var cirugias = await axiosController.getAxios(config.host + '/pacientes/' + id + '/cirugias');
                if (cirugias.length) {
                    rows[0].cirugias = cirugias;
                }
                var consultas = await axiosController.getAxios(config.host + '/pacientes/' + id + '/consultas');
                if (consultas.length) {
                    rows[0].consultas = consultas;
                }
                var covid = await axiosController.getAxios(config.host + '/pacientes/' + id + '/covid');
                if (covid.length) {
                    rows[0].covid = covid;
                }
                res.status(200).send(rows[0])
            } else
                res.status(404).send({ message: 'Paciente not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE un paciente
router.delete('/pacientes/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM pacientes WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Paciente Deleted: ' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT un paciente
router.post('/pacientes', (req, res) => {
    const { nombres, apellidoPaterno, apellidoMaterno, direccion, municipio, estado, pais, nacimiento, telefono, email, user, password, enfermedades, cirugias, alergias } = req.body;
    const query = `
    insert into pacientes(nombres, apellidoPaterno, apellidoMaterno, direccion, 
        municipio, estado, pais, nacimiento, telefono, email, user, password)
    values (?,?,?,?,?,?,?,?,?,?,?,?);
  `;
    mysqlConnection.query(query, [nombres, apellidoPaterno, apellidoMaterno, direccion, municipio, estado, pais, nacimiento, telefono, email, user, password], (err, rows, fields) => {
        if (!err) {
            if (enfermedades !== undefined)
                enfermedades.forEach(async reg => {
                    await axiosController.postAxios(config.host + '/pacientes/' + rows.insertId + '/enfermedades/' + reg.id);
                });
            if (alergias !== undefined)
                alergias.forEach(async reg => {
                    await axiosController.postAxios(config.host + '/pacientes/' + rows.insertId + '/alergias/' + reg.id);
                });
            if (cirugias !== undefined)
                cirugias.forEach(async reg => {
                    await axiosController.postAxios(config.host + '/pacientes/' + rows.insertId + '/cirugias/' + reg.id);
                });
            res.status(200).send({
                status: 'Paciente Saved',
                id: rows.insertId,
                nombres,
                apellidoPaterno,
                apellidoMaterno,
                direccion,
                municipio,
                estado,
                pais,
                nacimiento,
                telefono,
                email,
                user,
                password,
                enfermedades,
                alergias,
                cirugias

            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE un paciente
router.put('/pacientes/:id', (req, res) => {
    const { nombres, apellidoPaterno, apellidoMaterno, direccion, municipio, estado, pais, nacimiento, telefono, email, user, password } = req.body;
    const { id } = req.params;
    const query = `
    update pacientes set
    nombres = ?,
        apellidoPaterno = ?,
        apellidoMaterno = ?,
        direccion = ?,
        municipio = ?,
        estado = ?,
        pais = ?,
        nacimiento = ?,
        telefono = ?,
        email = ?,
        user = ?
    where id = ?
  `;
    mysqlConnection.query(query, [nombres, apellidoPaterno, apellidoMaterno, direccion, municipio, estado, pais, nacimiento, telefono, email, user, id], (err, rows, fields) => {
        if (!err) {
            if (1)
                res.status(200).send({
                    status: 'Paciente Updated',
                    id,
                    nombres,
                    apellidoPaterno,
                    apellidoMaterno,
                    direccion,
                    municipio,
                    estado,
                    pais,
                    nacimiento,
                    telefono,
                    email,
                    user
                });
            else
                res.status(404).send({ message: 'Paciente not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;