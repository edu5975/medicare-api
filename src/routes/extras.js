const express = require('express');
const router = express.Router();
const upload = require('../controller/multerController');
const axiosController = require('../controller/axiosController');
var nodemailer = require('nodemailer');



// GET imagen
router.get('/images/:nombre', (req, res) => {
    const { nombre } = req.params;
    res.sendFile('src/images/' + nombre, { root: '.' });
});

// POST imagen
router.post('/images', (req, res) => {
    upload.single('image');
    res.status(200).send({
        message: "Save",
        url: upload.url
    })
});

//POST email
router.post('/email', (req, res) => {
    const { email, titulo, contenido } = req.body;
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: '17030434@itcelaya.edu.mx',
            pass: 'masteredu5975'
        }
    });

    var mailOptions = {
        from: '17030434@itcelaya.edu.mx',
        to: email,
        subject: titulo,
        html: contenido
    };

    transporter.sendMail(mailOptions, function(error, info) {
        if (error) {
            console.log(error);
            res.status(404).send({ error })
        } else {
            res.status(200).send({
                status: "success",
                info
            })
        }
    });
});

//NADA
router.get('*', (req, res) => {
    res.status(404).send({ message: "Route not found" })
});



module.exports = router;