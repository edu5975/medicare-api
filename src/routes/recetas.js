const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');
const axiosController = require('../controller/axiosController');
const config = require('../config.js')

// GET todas las recetas
router.get('/recetas', (req, res) => {
    mysqlConnection.query('SELECT * FROM recetas', (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Recetas not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una receta
router.get('/recetas/:idConsulta', (req, res) => {
    const { idConsulta } = req.params;
    mysqlConnection.query('SELECT * FROM recetas WHERE idConsulta = ?', [idConsulta], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                var medicos = await axiosController.getAxios(config.host + '/medicos/' + rows[0].idMedico);
                if (medicos.id) {
                    rows[0].medicos = medicos;
                }
                var medicamentos = await axiosController.getAxios(config.host + '/recetas/' + rows[0].idConsulta + '/medicamentos');
                if (medicamentos.length) {
                    rows[0].medicamentos = medicamentos;
                }
                res.status(200).send(rows[0])
            } else
                res.status(404).send({ message: 'Receta not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una receta
router.post('/consultas/:idConsulta/recetas', (req, res) => {
    const { idConsulta } = req.params;
    const { idMedico, descripcion, pdf } = req.body;
    const query = `
    insert into recetas(idConsulta, idMedico, descripcion,pdf) values
    (?,?,?,?)
  `;
    mysqlConnection.query(query, [idConsulta, idMedico, descripcion, pdf], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Receta Saved',
                idConsulta,
                idMedico,
                descripcion,
                pdf
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una receta
router.delete('/recetas/:idConsulta', (req, res) => {
    const { idConsulta } = req.params;
    mysqlConnection.query('DELETE FROM recetas WHERE idConsulta = ?', [idConsulta], (err, rows, fields) => {

        console.log(rows);
        if (!err) {
            res.status(200).send({ status: 'Receta Deleted: ' + idConsulta });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una consulta
router.put('/consultas/:idConsulta/recetas', (req, res) => {
    const { idMedico, descripcion, pdf } = req.body;
    const { idConsulta } = req.params;
    const query = `    
    update recetas
    set idMedico = ?,
        descripcion = ?,
        pdf = ?
    where idConsulta = ?;
  `;
    mysqlConnection.query(query, [idMedico, descripcion, pdf, idConsulta], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Recetas Updated',
                    idConsulta,
                    idMedico,
                    descripcion,
                    pdf
                });
            else
                res.status(404).send({ message: 'Recetas not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;