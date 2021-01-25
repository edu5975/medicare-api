const express = require('express');
const { query } = require('../database.js');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET paises
router.get('/mundo', (req, res) => {
    mysqlConnection.query('select distinct pais, pais as string from pacientes', [], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Pais not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET estados de pais
router.get('/mundo/:pais', (req, res) => {
    const { pais } = req.params;
    mysqlConnection.query('select distinct estado, estado as string from pacientes where pais = ?', [pais], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Estados not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET municipios de estado de un pais
router.get('/mundo/:pais/:estado', (req, res) => {
    const { pais, estado } = req.params;
    mysqlConnection.query('select distinct municipio, municipio as string from pacientes where pais = ? and estado = ?;', [pais, estado], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Municipios not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET paises
router.get('/covide', (req, res) => {
    const query = `
    select p.pais as string, p.pais,count(*) as total,
    SUM(IF(c.estado = 'Curado', 1, 0)) curados,
    SUM(IF(c.estado = 'Sospechoso', 1, 0)) sospechosos,
    SUM(IF(c.estado = 'Confirmado', 1, 0)) confirmados
    from pacientes p
    join covid c on p.id = c.idPaciente
    group by p.pais;`;
    mysqlConnection.query(query, [], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                res.status(200).send(rows)
            } else
                res.status(404).send({ message: 'Paises not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET paises
router.get('/covide/:pais', (req, res) => {
    const { pais } = req.params;
    const query = `
    select p.estado as string, p.pais,p.estado,count(*) as total,
    SUM(IF(c.estado = 'Curado', 1, 0)) curados,
    SUM(IF(c.estado = 'Sospechoso', 1, 0)) sospechosos,
    SUM(IF(c.estado = 'Confirmado', 1, 0)) confirmados
    from pacientes p
    join covid c on p.id = c.idPaciente
    where p.pais = ?
    group by p.pais,p.estado;`;
    mysqlConnection.query(query, [pais], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                res.status(200).send(rows)
            } else
                res.status(404).send({ message: 'Paises not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET paises
router.get('/covide/:pais/:estado', (req, res) => {
    const { pais, estado } = req.params;
    const query = `
    select p.municipio as string, p.pais,p.estado,p.municipio,count(*) as total,
    SUM(IF(c.estado = 'Curado', 1, 0)) curados,
    SUM(IF(c.estado = 'Sospechoso', 1, 0)) sospechosos,
    SUM(IF(c.estado = 'Confirmado', 1, 0)) confirmados
    from pacientes p
    join covid c on p.id = c.idPaciente
    where p.pais = ? and p.estado = ?
    group by p.pais,p.estado,p.municipio;`;
    mysqlConnection.query(query, [pais, estado], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                res.status(200).send(rows)
            } else
                res.status(404).send({ message: 'Paises not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET paises
router.get('/covide/:pais/:estado/:municipio', (req, res) => {
    const { pais, estado, municipio } = req.params;
    const query = `
    select p.municipio as string, p.pais,p.estado,p.municipio,count(*) as total,
    SUM(IF(c.estado = 'Curado', 1, 0)) curados,
    SUM(IF(c.estado = 'Sospechoso', 1, 0)) sospechosos,
    SUM(IF(c.estado = 'Confirmado', 1, 0)) confirmados
    from pacientes p
    join covid c on p.id = c.idPaciente
    where p.pais = ? and p.estado = ? and p.municipio = ?
    group by p.pais,p.estado,p.municipio;`;
    mysqlConnection.query(query, [pais, estado, municipio], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0) {
                res.status(200).send(rows)
            } else
                res.status(404).send({ message: 'Paises not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// GET todos covid
router.get('/covid', (req, res) => {
    mysqlConnection.query("select c.id, c.idPaciente, c.idMedico, c.estado, c.fecha, concat(p.nombres,' ',p.apellidoPaterno,' ', p.apellidoMaterno) paciente, concat(m.nombres,' ',m.apellidoPaterno,' ', m.apellidoMaterno) medico from covid c join medicos m on m.id = c.idMedico join pacientes p on c.idPaciente = p.id", (err, rows, fields) => {
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
    mysqlConnection.query("select c.id, c.idPaciente, c.idMedico, c.estado, c.fecha, concat(p.nombres,' ',p.apellidoPaterno,' ', p.apellidoMaterno) paciente, concat(m.nombres,' ',m.apellidoPaterno,' ', m.apellidoMaterno) medico from covid c join medicos m on m.id = c.idMedico join pacientes p on c.idPaciente = p.id where c.id = ?", [id], (err, rows, fields) => {
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
    (?,?,?,current_timestamp());
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