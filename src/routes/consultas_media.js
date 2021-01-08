const express = require('express');
const router = express.Router();
const upload = require('../controller/multerController.js');

const mysqlConnection = require('../database.js');

// GET media de una consulta
router.get('/consultas/:id/media', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select cm.id, cm.idConsulta, cm.media from consultas c join consultas_media cm on c.id = cm.idConsulta where cm.idConsulta = ?', [id], (err, rows, fields) => {
        if (!err) {
            if (rows.length != 0)
                res.status(200).send(rows)
            else
                res.status(404).send({ message: 'Consulta o media not found' })
        } else {
            res.status(500).send({ message: err })
        }
    });
});

//GET media especifica de una consulta
router.get('/consultas/:idConsulta/media/:idMedia', (req, res) => {
    const { idConsulta, idMedia } = req.params;
    mysqlConnection.query('select cm.id, cm.idConsulta, cm.media from consultas c join consultas_media cm on c.id = cm.idConsulta where cm.idConsulta = ? and cm.id = ?', [idConsulta, idMedia], (err, rows, fields) => {
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

// DELETE media de una consulta
router.delete('/consultas/:idConsulta/media/:idMedia', (req, res) => {
    const { idConsulta, idMedia } = req.params;
    mysqlConnection.query('delete from consultas_media where idConsulta = ? and id = ?', [idConsulta, idMedia], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({ status: 'Consulta ' + idConsulta + ' se borro la media ' + idMedia });
        } else {
            res.status(500).send({ message: err })
        }
    });
});

// INSERT media de una consulta
router.post('/consultas/:idConsulta/media', (req, res) => {
    const { idConsulta } = req.params;

    upload.single('media');
    media = upload.url;

    const query = `insert into consultas_media(idConsulta, media) values (?,?)`;
    mysqlConnection.query(query, [idConsulta, media], (err, rows, fields) => {
        if (!err) {
            res.status(200).send({
                status: ' Saved',
                idConsulta,
                media
            });
        } else {
            res.status(500).send({ message: err })
        }
    });
});


module.exports = router;