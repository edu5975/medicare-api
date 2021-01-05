const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

// GET medicamentos de una receta
router.get('/recetas/:id/medicamentos', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select id, nombre, descripcion, costo, foto from recetas_medicamentos rc join medicamentos m on m.id = rc.idMedicamentos where rc.idRecetas = ? ', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Recetas o medicamentos not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//GET medicamento especifico de una receta
router.get('/recetas/:idRecetas/medicamentos/:idMedicamentos', (req, res) => {
    const { idRecetas, idMedicamentos } = req.params;
    mysqlConnection.query('select id, nombre, descripcion, costo, foto from recetas_medicamentos rc join medicamentos m on m.id = rc.idMedicamentos where rc.idRecetas = ? and rc.idMedicamentos = ?', [idRecetas, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows[0])
            else
                res.status(404).send({ message: 'Medicamentos o recetas not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// DELETE un medicamento de un receta
router.delete('/recetas/:idRecetas/medicamentos/:idMedicamentos', (req, res) => {
    const { idRecetas, idMedicamentos } = req.params;
    mysqlConnection.query('delete  from recetas_medicamentos where idRecetas = ? and idMedicamentos = ?', [idRecetas, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Receta ' + idRecetas + ' se borro el medicamento ' + idRecetas });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT una alergias a un paciente
router.post('/recetas/:idRecetas/medicamentos/:idMedicamentos', (req, res) => {
    const { idRecetas, idMedicamentos } = req.params;
    const query = `insert into recetas_medicamentos(idRecetas, idMedicamentos) values (?,?)`;
    mysqlConnection.query(query, [idRecetas, idMedicamentos], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                recetas_medicamentos: {
                    idRecetas,
                    idMedicamentos
                }
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;