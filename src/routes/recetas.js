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
router.get('/recetas/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM recetas WHERE id = ?', [id], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                var consultas = await axiosController.getAxios(config.host + '/consultas/' + rows[0].idConsulta);
                if (consultas.id) {
                    rows[0].consultas = consultas;
                }
                var medicos = await axiosController.getAxios(config.host + '/medicos/' + rows[0].idMedico);
                if (medicos.id) {
                    rows[0].medicos = medicos;
                }
                res.status(200).send(rows[0])
            } else
                res.status(404).send({ message: 'Receta not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET recetas de pacientes
router.get('/pacientes/:idPacientes/recetas', (req, res) => {
    const { idPacientes } = req.params;
    const query = `
    select r.id, r.idConsulta, r.descripcion, r.pdf 
    from recetas r 
    join consultas c on r.idConsulta = c.id
    join pacientes p on c.idPaciente = p.id
    where p.id = ?
  `;
    mysqlConnection.query(query, [idPacientes], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                res.status(200).send(rows);
            } else
                res.status(404).send({ message: 'Recetas not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una receta
router.get('/pacientes/:idPacientes/recetas/:idRecetas', (req, res) => {
    const { idPacientes, idRecetas } = req.params;
    const query = `
    select r.id, r.idConsulta, r.descripcion, r.pdf
    from recetas r
    join consultas c on r.idConsulta = c.id
    join pacientes p on c.idPaciente = p.id
    where p.id = ? and r.id = ?
  `;
    mysqlConnection.query(query, [idPacientes, idRecetas], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                var consultas = await axiosController.getAxios(config.host + '/consultas/' + rows[0].idConsulta);
                if (consultas.id) {
                    rows[0].consultas = consultas;
                }
                var medicos = await axiosController.getAxios(config.host + '/medicos/' + rows[0].idMedico);
                if (medicos.id) {
                    rows[0].medicos = medicos;
                }
                res.status(200).send(rows[0]);
            } else
                res.status(404).send({ message: 'Recetas not found' })
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
                recetas: {
                    id: rows.insertId,
                    idConsulta,
                    idMedico,
                    descripcion,
                    pdf
                }
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una receta
router.delete('/recetas/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM recetas WHERE id = ?', [id], (err, rows, fields) => {

        console.log(rows);
        if (!err) {
            res.status(200).send({ status: 'Receta Deleted: ' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una receta
router.delete('/consultas/:idConsulta/recetas/:idRecetas', (req, res) => {
    const { idConsulta, idRecetas } = req.params;
    mysqlConnection.query('delete from recetas where idConsulta = ? and id = ?', [idConsulta, idRecetas], (err, rows, fields) => {

        console.log(rows);
        if (!err) {
            res.status(200).send({ status: 'Recetas Deleted: ' + idRecetas });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una consulta
router.put('/consultas/:idConsulta/recetas/:idRecetas', (req, res) => {
    const { idMedico, descripcion, pdf } = req.body;
    const { idConsulta, idRecetas } = req.params;
    const query = `    
    update recetas
    set idMedico = ?,
        descripcion = ?,
        pdf = ?
    where idConsulta = ? and id = ?;
  `;
    mysqlConnection.query(query, [idMedico, descripcion, pdf, idConsulta, idRecetas], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Recetas Updated',
                    recetas: {
                        idRecetas,
                        idConsulta,
                        idMedico,
                        descripcion,
                        pdf
                    }
                });
            else
                res.status(404).send({ message: 'Recetas not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;