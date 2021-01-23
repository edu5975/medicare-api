const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');
const axiosController = require('../controller/axiosController');
const config = require('../config.js')

// GET todas las consultas
router.get('/consultas', (req, res) => {
    mysqlConnection.query("select c.id,c.idPaciente,concat(p.nombres,' ',p.apellidoPaterno,' ',p.apellidoMaterno) paciente,c.idEspecialidad,e.descripcion,c.sintomas,c.estado,c.fecha from consultas c join especialidades e on e.id = c.idEspecialidad join pacientes p on p.id = c.idPaciente;", (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Consultas not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una consulta
router.post('/consultas', (req, res) => {
    const { idPaciente, idEspecialidad, sintomas } = req.body;
    const estado = "Sin responder"
    const query = `
    insert into consultas(idPaciente, idEspecialidad, sintomas, estado, fecha) values
    (?,?,?,?,current_timestamp())
  `;
    fecha = Date.now();
    mysqlConnection.query(query, [idPaciente, idEspecialidad, sintomas, estado], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Consulta Saved',
                id: rows.insertId,
                idPaciente,
                idEspecialidad,
                sintomas,
                estado,
                fecha
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


// GET una consulta
router.get('/consultas/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM consultas WHERE id = ?', [id], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                var especialidades = await axiosController.getAxios(config.host + '/especialidades/' + rows[0].idEspecialidad);
                if (especialidades.id) {
                    rows[0].especialidades = especialidades;
                }
                var consultas_media = await axiosController.getAxios(config.host + '/consultas/' + rows[0].id + '/media');
                if (consultas_media.length) {
                    rows[0].consultas_media = consultas_media;
                }
                var recetas = await axiosController.getAxios(config.host + '/recetas/' + rows[0].id);
                if (recetas.idConsulta) {
                    rows[0].recetas = recetas;
                }
                var pacientes = await axiosController.getAxios(config.host + '/pacientes/' + rows[0].idPaciente);
                if (pacientes.id) {
                    rows[0].pacientes = pacientes;
                }
                res.status(200).send(rows[0])
            } else
                res.status(404).send({ message: 'Consulta not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una consulta
router.put('/consultas/:id', (req, res) => {
    const { idEspecialidad, sintomas, estado } = req.body;
    const { id } = req.params;
    const query = `    
    update consultas set idEspecialidad = ?, sintomas =?,estado=? where id = ?;
    `;
    mysqlConnection.query(query, [idEspecialidad, sintomas, estado, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Consultas Updated',
                    id,
                    idEspecialidad,
                    sintomas,
                    estado
                });
            else
                res.status(404).send({ message: 'Consulta not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET consultas de un paciente
router.get('/pacientes/:idPacientes/consultas', (req, res) => {
    const { idPacientes } = req.params;
    const query = `
    select * from consultas where idPaciente = ?;
  `;
    mysqlConnection.query(query, [idPacientes], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                res.status(200).send(rows);
            } else
                res.status(404).send({ message: 'Consulta not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una consulta
router.get('/pacientes/:idPacientes/consultas/:idConsultas', (req, res) => {
    const { idPacientes, idConsultas } = req.params;
    const query = `
    select * from consultas where idPaciente = ? and id=?;
  `;
    mysqlConnection.query(query, [idPacientes, idConsultas], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                res.status(200).send(rows[0]);
            } else
                res.status(404).send({ message: 'Consulta not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE una consulta
router.delete('/consultas/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM consultas WHERE id = ?', [id], (err, rows, fields) => {

        console.log(rows);
        if (!err) {
            res.status(200).send({ status: 'Consulta Deleted: ' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;