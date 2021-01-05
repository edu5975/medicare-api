const express = require('express');
const router = require('./routes/');
const body_parser = require('body-parser');
const cors = require('cors')
const upload = require('./controller/multerController');
const app = express();


// Settings
app.set('port', process.env.PORT || 3000);

// Middlewares
app.use(cors());
app.use(body_parser.json());
app.use(body_parser.urlencoded({ extended: true }));
app.use(upload.any());
app.use(express.static('public'));
app.use(express.static('images'));

// Routes
app.use(require('./routes/alergias'));
app.use(require('./routes/especialidades'));
app.use(require('./routes/enfermedades'));
app.use(require('./routes/cirugias'));
app.use(require('./routes/pacientes'));
app.use(require('./routes/pacientes_enfermedades'));
app.use(require('./routes/pacientes_alergias'));
app.use(require('./routes/pacientes_cirugias'));
app.use(require('./routes/servicios'));
app.use(require('./routes/medicos'));
app.use(require('./routes/servicios_medicos'));
app.use(require('./routes/consultas'));
app.use(require('./routes/covid'));
app.use(require('./routes/recetas'));
app.use(require('./routes/acceso'));

app.use(require('./routes/extras'));



// Starting the server
app.listen(app.get('port'), () => {
    console.log(`Server on port ${app.get('port')}`);
});