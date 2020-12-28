const express = require('express');
const router = express.Router();

const axiosController = require('../controller/axiosController');

router.get('/prueba', async(req, res) => {
    var especialidades = await axiosController.getAxios('http://localhost:3000/especialidades');
    var alergias = await axiosController.getAxios('http://localhost:3000/alergias');
    var enfermedades = await axiosController.getAxios('http://localhost:3000/enfermedades');
    var cirugias = await axiosController.getAxios('http://localhost:3000/cirugias');

    /*res.status(200).send({
        especialidades,
        alergias,
        enfermedades,
        cirugias
    });*/
    res.status(200).send(cirugias)
});

router.get('/prueba2', async(req, res) => {
    var prueba = await axiosController.postAxios('http://localhost:3000/pacientes/1/enfermedades/4')
    res.status(200).send(prueba)
});


module.exports = router;