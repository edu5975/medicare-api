const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');
const axiosController = require('../controller/axiosController');
const config = require('../config.js')

// GET todas las consultas
router.get('/consultas', (req, res) => {
    mysqlConnection.query('SELECT * FROM consultas', (err, rows, fields) => {
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

// GET una consulta
router.get('/consultas/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM consultas WHERE id = ?', [id], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                var pacientes = await axiosController.getAxios(config.host + '/pacientes/' + rows[0].idPaciente);
                if (pacientes.id) {
                    rows[0].pacientes = pacientes;
                }
                var especialidades = await axiosController.getAxios(config.host + '/especialidades/' + rows[0].idEspecialidad);
                if (especialidades.id) {
                    rows[0].especialidades = especialidades;
                }
                res.status(200).send(rows[0])
            } else
                res.status(404).send({ message: 'Consulta not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET una consulta
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

// INSERT una consulta
router.post('/pacientes/:idPacientes/consultas', (req, res) => {
    const { idPaciente } = req.params;
    const { idEspecialidad, sintomas, fotosvideos, estado } = req.body;
    const query = `
    insert into consultas(idPaciente, idEspecialidad, sintomas, fotosvideos, estado, fecha) values
    (?,?,?,?,?,current_date)
  `;
    mysqlConnection.query(query, [idPaciente, idEspecialidad, sintomas, fotosvideos, estado], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: 'Consulta Saved',
                consultas: {
                    id: rows.insertId,
                    idPaciente,
                    idEspecialidad,
                    sintomas,
                    fotosvideos,
                    estado
                }
            });
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

// DELETE una consulta
router.delete('/pacientes/:idPacientes/consultas/:idConsultas', (req, res) => {
    const { idPacientes, idConsultas } = req.params;
    mysqlConnection.query('delete from consultas where idPaciente = ? and id = ?', [idPacientes, idConsultas], (err, rows, fields) => {

        console.log(rows);
        if (!err) {
            res.status(200).send({ status: 'Consulta Deleted: ' + idConsultas });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE una consulta
router.put('/pacientes/:idPacientes/consultas/:idConsultas', (req, res) => {
    const { idEspecialidad, sintomas, fotosvideos, estado } = req.body;
    const { idPacientes, idConsultas } = req.params;
    const query = `    
update consultas set idEspecialidad = ?, sintomas =?, fotosvideos=?,estado=? where idPaciente = ? and id = ?;
  `;
    mysqlConnection.query(query, [idEspecialidad, sintomas, fotosvideos, estado, idPacientes, idConsultas], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Consultas Updated',
                    consultas: {
                        idConsultas,
                        idPacientes,
                        idEspecialidad,
                        sintomas,
                        fotosvideos,
                        estado
                    }
                });
            else
                res.status(404).send({ message: 'Consulta not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;