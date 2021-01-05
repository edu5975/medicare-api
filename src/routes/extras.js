const express = require('express');
const router = express.Router();
const upload = require('../controller/multerController');
const axiosController = require('../controller/axiosController');


// GET imagen
router.get('/images/:nombre', (req, res) => {
    const { nombre } = req.params;
    res.sendFile('src/images/' + nombre, { root: '.' });
});

// POST imagen
router.post('/images', upload.single('image'), (req, res) => {
    res.status(200).send({ message: "Save" })
});

//NADA
router.get('*', (req, res) => {
    res.status(404).send({ message: "Route not found" })
});



module.exports = router;