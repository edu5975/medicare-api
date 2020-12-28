DROP DATABASE IF EXISTS company;

CREATE DATABASE IF NOT EXISTS company;

USE company;

/*YA TIENE INSERT*/
create table especialidades(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

/*YA TIENE INSERT*/
create table alergias(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

/*YA TIENE INSERT*/
create table enfermedades(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

/*YA TIENE INSERT*/
create table cirugias(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

/*YA TIENE INSERT*/
create table servicios(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

create table pacientes(
  id integer auto_increment primary key,
  nombres varchar(30),
  apellidoPaterno varchar(15),
  apellidoMaterno varchar(15),
  direccion varchar(60),
  municipio varchar(20),
  estado varchar(20),
  pais varchar(20),
  nacimiento date,
  telefono varchar(13),
  email varchar(40),
  user varchar(20),
  password varchar(40)
);

create table pacientes_alergias(
    idPacientes integer,
    idAlergias integer,
    constraint primary key (idAlergias,idPacientes),
    constraint foreign key (idAlergias) references alergias(id),
    constraint foreign key (idPacientes) references pacientes(id)
);

create table pacientes_enfermedades(
    idPacientes integer,
    idEnfermedades integer,
    constraint primary key (idEnfermedades,idPacientes),
    constraint foreign key (idEnfermedades) references enfermedades(id),
    constraint foreign key (idPacientes) references pacientes(id)
);

create table pacientes_cirugias(
    idPacientes integer,
    idCirugias integer,
    constraint primary key (idCirugias,idPacientes),
    constraint foreign key (idCirugias) references cirugias(id),
    constraint foreign key (idPacientes) references pacientes(id)
);

create table medicos(
  id integer auto_increment primary key,
  nombres varchar(30),
  apellidoPaterno varchar(15),
  apellidoMaterno varchar(15),
  cedula varchar(20),
  direccion varchar(60),
  municipio varchar(20),
  estado varchar(20),
  pais varchar(20),
  telefono varchar(13),
  email varchar(40),
  user varchar(20),
  password varchar(40),
  idEspecialidades integer,
  constraint foreign key (idEspecialidades) references especialidades(id)
);

create table servicios_medicos(
    idMedicos integer,
    idServicios integer,
    costo decimal(10,2),
    constraint primary key (idServicios,idMedicos),
    constraint foreign key (idServicios) references servicios(id),
    constraint foreign key (idMedicos) references medicos(id)
);

create table covid(
    id integer auto_increment primary key,
    idPaciente integer,
    idMedico integer,
    estado varchar(20),
    fecha date,
    constraint foreign key (idPaciente) references pacientes(id),
    constraint foreign key (idMedico) references medicos(id)
);

create table consultas(
    id integer auto_increment primary key,
    idPaciente integer,
    idEspecialidad integer,
    sintomas text,
    fotosvideos varchar(100),
    estado varchar(20),
    constraint foreign key (idPaciente) references pacientes(id),
    constraint foreign key (idEspecialidad) references especialidades(id)
);

create table recetas(
    id integer auto_increment primary key,
    idConsulta integer,
    idMedico integer,
    descripcion text,
    pdf varchar(20),
    constraint foreign key (idConsulta) references consultas(id),
    constraint foreign key (idMedico) references medicos(id)
);

insert into alergias(descripcion) values ('Polen'),('Polvo'),('Moho'),('Latex'),('Pasto'),('Nuez'),('Cacahuate'),('Fresa'),
('Sol'),('Pelo de perro'),('Pelo de gato'),('Mascotas'),('Frutos secos'),('Soja'),('Abejas'),('Mariscos'),('Huevo'),('Leche');

insert into especialidades(descripcion) values
('Alergología'),('Anestesiología '),('Reanimación'),('Cardiología'),('Endocrinología'),('Gastroenterología'),('Geriatría'),('Hematología'),
('Hemoterapia'),('Infectología'),('Medicina aeroespacial'),('Medicina del deporte'),('Medicina del trabajo'),('Medicina de urgencias'),
('Medicina familiar y comunitaria'),('Medicina fisiatría'),('Medicina intensiva'),('Medicina interna'),('Medicina legal y forense'),
('Medicina preventiva y salud pública'),('Medicina veterinaria'),('Nefrología'),('Neumología'),('Neurología'),('Nutriología'),('Oftalmología'),
('Oncología médica'),('Oncología radioterápica'),('Pediatría'),('Psiquiatría'),('Toxicología'),('Cirugía cardiovascular'),('Cirugía general y del aparato digestivo'),
('Cirugía ortopédica y traumatología'),('Cirugía pediátrica'),('Cirugía torácica'),('Neurocirugía'),('Angiología y cirugía vascular'),
('Dermatología'),('Odontología'),('Ginecología '),('Obstetricia '),('Tocología'),('Otorrinolaringología'),('Urología'),('Traumatología'),
('Análisis clínicos'),('Bioquímica clínica'),('Farmacología clínica'),('Genética médica'),('Inmunología'),('Medicina nuclear'),
('Microbiología '),('Parasitología'),('Neurofisiología clínica');

insert into enfermedades(descripcion) values
('Enfermedades cardiovasculares'),('Cáncer'),('Enfermedad Pulmonar Obstructiva Crónica'),('Diabetes'),('Parkinson'),('Alzheimer'),
('Esclerosis múltiple'),('Hipertensión'),('Lumbalgia'),('Colesterol'),('Depresión'),('Ansiedad'),('Tiroides'),('Osteoporosis'),
('Artritis'),('Enfermedad de Crohn'),('Trastorno bipolar'),('Epilepsia'),('Demencia'),('VIH / SIDA'),('Apnea del sueño');

insert into cirugias(descripcion) values
('Apendicectomía'),('Biopsia de mama'),('Endoarteriectomía de la carótida'),('Cirugía de cataratas'),('Cesárea'),('Colecistectomía'),
('Bypass de arteria coronaria'),('Desbridamiento de heridas'),('Desbridamiento de quemaduras '),('Desbridamiento de infecciones'),
('Dilatación y legrado '),('Injerto libre de piel'),('Hemorroidectomía'),('Histerectomía'),('Histeroscopia'),('Reparación de hernia inguinal'),
('Cirugía para la lumbalgia '),('Mastectomía'),('Colectomía parcial'),('Prostatectomía'),('Amigdalectomí');

insert into pacientes(nombres, apellidoPaterno, apellidoMaterno, direccion, municipio, estado, pais, nacimiento, telefono, email, user, password)
values
('Eduardo Daniel','Rico','Gómez','Prol. Jacarandas 1010','Celaya','Guanajuato','Mexico','2020/07/23','4611842703','edu.dan68@gmail.com','edu5975','edu5975'),
('Julio César','García','Escoto','Arboledas 404','Salamanca','Guanajuato','Mexico','2020/05/10','4645793708','zeth@gmail.com','zeth','zeth');

insert into pacientes_alergias(idPacientes, idAlergias) values (1,1),(1,2),(1,3);
insert into pacientes_enfermedades(idPacientes, idEnfermedades) values (1,1),(1,2),(1,3);
insert into pacientes_cirugias(idPacientes, idCirugias) values (1,1),(1,2),(1,3);

insert into servicios(descripcion) values
('Otorrinolaringología'),('Oftalmología'),('Hematología'),('Urología'),('Nefrología'),('Ortopedia'),('Cirugía Plástica'),('Dermatología'),
('Geriatría'),('Oncología'),('Gineco-Obstetricia'),('Clínica del Dolor'),('Laboratorio'),('Radiología e Imagenología'),('Medicina Interna'),
('Consulta Externa'),('Medicina Preventiva'),('Urgencias'),('Banco de Sangre'),('Neurología y Neurocirugía'),('Reumatología'),
('Estomatología'),('Endocrinología'),('Salud Mental'),('Infectología'),('Cirugía Experimental'),('Pediatría'),('Farmacología Clínica'),
('Cámara Hiperbárica'),('Nutrición Clínica'),('Anestesiología'),('Cirugía General'),('Transplantes de Órganos'),('Gastroenterología'),
('Terapia Médica Intensiva'),('Quirófano'),('Anatomía Patológica'),('Genómica'),('Genética'),('Cardiología y Cirugía Cardiotorácica'),
('Angiología y Cirugía Vascular'),('Neumología y Cirugía de Tórax'),('Medicina Física y Rehabilitación'),('Audiología y Foniatría'),
('Alergia e Inmunología');

insert into medicos(nombres, apellidoPaterno, apellidoMaterno, cedula, direccion, municipio, estado, pais, telefono, email, user, password, idEspecialidades)
values
('Meryee','Pacheco','Pulido','1234567890','En mi corazón','Celaya','Guanajuato','Mexico','4612328663','meryee@gmail.com','mery','mery',1),
('Juan','Velasco','Franco','1234567891','Laureles #301','Celaya','Guanajuato','Mexico','4612328664','juan.velasco@gmail.com','juanv','juanv',2);

insert into servicios_medicos(idMedicos,idServicios,costo) values (1,3,1000),(1,1,3200),(1,20,200),(1,45,400);

insert into consultas(idPaciente, idEspecialidad, sintomas, fotosvideos, estado) values
(1,1,'Me siento mal','url de la foto o video','Sin responder'),
(1,2,'Me siento mal','url de la foto o video','Sin responder'),
(1,3,'Me siento mal','url de la foto o video','Sin responder');

insert into covid(idPaciente, idMedico, estado, fecha) values
(1,1,'Sospechoso',current_date),
(1,2,'Confirmado',current_date),
(1,1,'Curado',current_date);

select c.id, c.idPaciente, c.idMedico, c.estado, c.fecha
from covid c
join medicos m on c.idMedico = m.id