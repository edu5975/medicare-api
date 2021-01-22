const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');
const axiosController = require('../controller/axiosController');
const config = require('../config.js');

// GET todas los medicos
router.get('/medicos', (req, res) => {
    const query = `
    select m.id, m.nombres, m.apellidoPaterno, m.apellidoMaterno, cedula, 
       direccion, municipio, estado, pais, telefono, email, user,password,
       idEspecialidades,descripcion 
from medicos m join especialidades e on e.id = m.idEspecialidades
  `;
    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Medicos not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// POST busqueda de medicos
router.post('/medicos/busqueda', (req, res) => {
    const { idEspecialidades, pais, estado, servicios } = req.body;
    var query = `
    select *
    from medicos
    `;
    if (Object.keys(req.body).length !== 0) {
        query += " where "
        if (idEspecialidades) {
            query += " idEspecialidades = " + idEspecialidades + " "
            if (pais || estado || servicios)
                query += " or "
        }
        if (pais) {
            query += " pais = '" + pais + "' "
            if (estado || servicios)
                query += " or "
        }
        if (estado) {
            query += " estado = '" + estado + "' "
            if (servicios)
                query += " or "
        }
        if (servicios)
            query += " " + servicios + " in (select idMedicos from servicios_medicos where idMedicos = id)"
    }
    console.log(query)

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Medicos not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET un medico
router.get('/medicos/:id', (req, res) => {
    const { id } = req.params;
    const query = `
    select m.id, m.nombres, m.apellidoPaterno, m.apellidoMaterno, cedula, 
       direccion, municipio, estado, pais, telefono, email, user,password,
       idEspecialidades,descripcion 
        from medicos m join especialidades e on e.id = m.idEspecialidades 
    where m.id = ?
  `;
    mysqlConnection.query((query), [id], async(err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                var servicios = await axiosController.getAxios(config.host + '/medicos/' + id + '/servicios');
                if (servicios.length) {
                    rows[0].servicios = servicios;
                }
                res.status(200).send(rows[0])
            } else
                res.status(404).send({ message: 'Medico not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE un medico
router.delete('/medicos/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM medicos WHERE id = ?', [id], (err, rows, fields) => {

        console.log(rows);
        if (!err) {
            res.status(200).send({ status: 'Medico Deleted: ' + id });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT un medico
router.post('/medicos', (req, res) => {
    const { nombres, apellidoPaterno, apellidoMaterno, cedula, direccion, municipio, estado, pais, telefono, email, user, password, idEspecialidades, servicios } = req.body;
    const query = `
    insert into medicos(nombres, apellidoPaterno, apellidoMaterno, cedula, direccion, municipio, 
        estado, pais, telefono, email, user, password, idEspecialidades)    values
    (?,?,?,?,?,?,?,?,?,?,?,?,?) 
  `;
    mysqlConnection.query(query, [nombres, apellidoPaterno, apellidoMaterno, cedula, direccion, municipio, estado, pais, telefono, email, user, password, idEspecialidades], (err, rows, fields) => {
        if (!err) {
            if (servicios !== undefined)
                servicios.forEach(async reg => {
                    await axiosController.postAxios(config.host + '/medicos/' + rows.insertId + '/servicios/' + reg.id, { costo: reg.costo });
                });
            res.status(200).send({
                status: 'Medicos Saved',
                id: rows.insertId,
                nombres,
                apellidoPaterno,
                apellidoMaterno,
                cedula,
                direccion,
                municipio,
                estado,
                pais,
                telefono,
                email,
                user,
                password,
                idEspecialidades,
                servicios
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//UPDATE un medico
router.put('/medicos/:id', (req, res) => {
    const { nombres, apellidoPaterno, apellidoMaterno, cedula, direccion, municipio, estado, pais, telefono, email, user, password, idEspecialidades } = req.body;
    const { id } = req.params;
    const query = `
    update medicos set nombres = ?, apellidoPaterno = ?, apellidoMaterno = ?, cedula = ?,
direccion = ?, municipio = ?, estado = ?, pais = ?, telefono = ?, email = ?, user = ?, password = ?, idEspecialidades =?
where id = ?;;
  `;
    mysqlConnection.query(query, [nombres, apellidoPaterno, apellidoMaterno, cedula, direccion, municipio, estado, pais, telefono, email, user, password, idEspecialidades, id], (err, rows, fields) => {
        if (!err) {
            if (rows.changedRows != 0)
                res.status(200).send({
                    status: 'Medicos Updated',
                    id,
                    nombres,
                    apellidoPaterno,
                    apellidoMaterno,
                    cedula,
                    direccion,
                    municipio,
                    estado,
                    pais,
                    telefono,
                    email,
                    user,
                    password,
                    idEspecialidades
                });
            else
                res.status(404).send({ message: 'Medico not found' });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

module.exports = router;