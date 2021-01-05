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
    fecha date,
    constraint foreign key (idPaciente) references pacientes(id),
    constraint foreign key (idEspecialidad) references especialidades(id)
);

create table recetas(
    idConsulta integer primary key ,
    idMedico integer,
    descripcion text,
    pdf varchar(20),
    constraint foreign key (idConsulta) references consultas(id),
    constraint foreign key (idMedico) references medicos(id)
);

create table medicamentos(
    id integer auto_increment primary key,
    nombre varchar(30),
    descripcion text,
    costo decimal(10,2),
    foto varchar(40)
);

create table recetas_medicamentos(
    idRecetas integer,
    idMedicamentos integer,
    constraint primary key (idRecetas,idMedicamentos),
    constraint foreign key (idRecetas) references recetas(idConsulta),
    constraint foreign key (idMedicamentos) references medicamentos(id)
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

insert into consultas(idPaciente, idEspecialidad, sintomas, fotosvideos, estado,fecha) values
(1,1,'Me siento mal 1','url de la foto o video','Con respuesta',curdate()),
(1,2,'Me siento mal 2','url de la foto o video','Con respuesta',curdate()),
(1,3,'Me siento mal 3','url de la foto o video','Sin responder',curdate()),
(2,1,'Me siento mal 4','url de la foto o video','Sin responder',curdate()),
(2,2,'Me siento mal 5','url de la foto o video','Sin responder',curdate()),
(2,3,'Me siento mal 6','url de la foto o video','Sin responder',curdate());

insert into covid(idPaciente, idMedico, estado, fecha) values
(1,1,'Sospechoso',curdate()),
(1,2,'Confirmado',curdate()),
(1,1,'Curado',curdate());

insert into recetas(idConsulta, idMedico, descripcion,pdf) values
(1,1,'Debes hacer esto','url del pdf'),
(2,1,'Debes hacer esto','url del pdf');

insert into medicamentos(nombre, descripcion, costo, foto) values
('Simvastatina','Se emplea para reducir el colesterol y los triglicéridos (tipo de grasa) en la sangre. Descubierta y desarrollada por Merck, se trata del primer medicamento con estatina que evidenció una disminución de la enfermedad cardiovascular y mortalidad.'
,300,'url'),
('Aspirina','También conocida como ácido acetil-salicílico (ASA), reduce las sustancias en el cuerpo que producen dolor, fiebre e inflamación. Es el medicamento más usado en todo el mundo y se calcula que cada año se consumen unas 40.000 toneladas. A veces incluso se usa como tratamiento o prevención de infartos de miocardio, derrames cerebrales y dolores en el pecho, y también puede ser efectiva en la prevención de ciertos tipos de cáncer, en particular, el cáncer colorectal. '
,100,'url'),
('Omeprazol','Para la acidez de estómago inhibe la bomba de protones (IBPS)y disminuye la producción de ácido al bloquear la enzima de la pared del estómago que se encarga de producir esta sustancia. Este efecto reviene las úlceras y tiene un resultadocu rativo sobre las úlceras existentes en el esófago, estómago y duodeno. La OMS lo incluye como medicamento básico.'
,50,'url'),
('Lexotiroxina sódica','Se encarga de sustituir una hormona que se suele producir en nuestra glándula tiroidea para regular la energía y el metabolismo del cuerpo. Es una versión artificial de la hormona tiroxina, responsable de aumentar la tasa metabólica de las células de todos los tejidos del organismo y ayuda a mantener la función cerebral, la absorción de los alimentos y la temperatura corporal, entre otros efectos. '
,75,'url'),
('Ramipril','Para la hipertensión, trata la presión arterial alta (hipertensión) o la insuficiencia cardíaca congestiva. También mejora la supervivencia después de un infarto de miocardio y previene la insuficiencia renal por presión alterial alta y diabetes.'
,122,'url'),
('Amlodipina','Para la hipertensión y la angina, es un bloqueador de los canales de calcio. Ensancha los vasos sanguíneos y mejora el flujo de la sangre, por lo que se usa para reducir la presión arterial y tratar la hipertensión. Ralentizan el latido cardíaco y, al bloquear la señal de calcio en las células de la corteza adrenal, disminuyen la presión arterial.'
,34,'url'),
('Paracetamol','Para aliviar el dolor, es un medicamento ampliamente empleado para reducir la fiebre, aunque a día de hoy aún se desconoce su mecanismo de acción exacto. Se usa para tratar diversas dolencias como fiebres, dolor de cabeza, dolores musculares, artritis, dolor de espalda o resfriados. Aunque es seguro si se siguen las dosis recomendadas, sobredosis pequeñas pueden causar hasta la muerte. El paracetamol es más tóxico en sobredosis que otros medicamentos pero menos cuando su toma se realiza de forma crónica a pequeñas dosis.'
,30,'url'),
('Atorvastatina','Para controlar el colesterol, disminuye la cantidad de colesterol que fabrica el hígado. Sirve para reducir los niveles de trigliricéridos en sangre y colesterol ''malo'', al tiempo que aumenta los niveles de colesterol bueno. Se suele emplear junto a una dieta saludable para tratar el colesterol y disminuir el riesgo de derrame cerebral o infarto de miocardio.'
,72,'url'),
('Salbutamol','Para el asma. Popularmente conocido como Ventolin, se usa como prevención de broncoespasmos en pacientes con asma, bronquitis, enfisema y otras enfermedades del pulmón. Alivia la tos, la falta de aire y la respiración dificultosa al aumentar el flujo de aire que pasa a través de los tubos bronquiales.'
,90,'url'),
('Lansoprazol','Para controlar el ácido del estómago, se encarga también de disminuir la cantidad de ácido producido en el estómago y se usa para tratar y prevenir las úlceras en este órgano y en el intestino y para controlar el ardor.'
,88,'url');

insert into recetas_medicamentos(idRecetas, idMedicamentos) values
(1,1),(1,2),(1,3),(1,4),(2,5),(2,6),(2,7),(2,8);











