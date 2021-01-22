/*DROP DATABASE IF EXISTS company;

CREATE DATABASE IF NOT EXISTS company;

USE company;*/

drop table if exists servicios_medicos;
drop table if exists pacientes_enfermedades;
drop table if exists recetas_medicamentos;
drop table if exists pacientes_cirugias;
drop table if exists ventas_medicamentos;
drop table if exists consultas_media;
drop table if exists carrito;
drop table if exists pacientes_alergias;
drop table if exists recetas;
drop table if exists medicamentos;
drop table if exists covid;
drop table if exists consultas;
drop table if exists ventas;
drop table if exists pacientes;
drop table if exists enfermedades;
drop table if exists alergias;
drop table if exists cirugias;
drop table if exists medicos_consultas;
drop table if exists medicos;
drop table if exists especialidades;
drop table if exists servicios;

create table especialidades(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

create table alergias(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

create table enfermedades(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

create table cirugias(
    id integer auto_increment primary key,
    descripcion varchar(60)
);

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
  municipio varchar(40),
  estado varchar(40),
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
    constraint foreign key (idAlergias) references alergias(id) on delete cascade,
    constraint foreign key (idPacientes) references pacientes(id) on delete cascade
);

create table pacientes_enfermedades(
    idPacientes integer,
    idEnfermedades integer,
    constraint primary key (idEnfermedades,idPacientes),
    constraint foreign key (idEnfermedades) references enfermedades(id) on delete cascade,
    constraint foreign key (idPacientes) references pacientes(id) on delete cascade
);

create table pacientes_cirugias(
    idPacientes integer,
    idCirugias integer,
    constraint primary key (idCirugias,idPacientes),
    constraint foreign key (idCirugias) references cirugias(id) on delete cascade,
    constraint foreign key (idPacientes) references pacientes(id) on delete cascade
);

create table medicos(
  id integer auto_increment primary key,
  nombres varchar(30),
  apellidoPaterno varchar(15),
  apellidoMaterno varchar(15),
  cedula varchar(20),
  direccion varchar(60),
  municipio varchar(40),
  estado varchar(40),
  pais varchar(20),
  telefono varchar(13),
  email varchar(40),
  user varchar(20),
  password varchar(40),
  idEspecialidades integer,
  constraint foreign key (idEspecialidades) references especialidades(id) on delete cascade
);

create table servicios_medicos(
    idMedicos integer,
    idServicios integer,
    costo decimal(10,2),
    constraint primary key (idServicios,idMedicos),
    constraint foreign key (idServicios) references servicios(id) on delete cascade,
    constraint foreign key (idMedicos) references medicos(id) on delete cascade
);

create table covid(
    id integer auto_increment primary key,
    idPaciente integer,
    idMedico integer,
    estado varchar(20),
    fecha datetime,
    constraint foreign key (idPaciente) references pacientes(id) on delete cascade,
    constraint foreign key (idMedico) references medicos(id) on delete cascade
);

create table consultas(
    id integer auto_increment primary key,
    idPaciente integer,
    idEspecialidad integer,
    sintomas text,
    estado varchar(20),
    fecha datetime,
    constraint foreign key (idPaciente) references pacientes(id) on delete cascade,
    constraint foreign key (idEspecialidad) references especialidades(id) on delete cascade
);

create table recetas(
    idConsulta integer primary key ,
    idMedico integer,
    descripcion text,
    constraint foreign key (idConsulta) references consultas(id) on delete cascade,
    constraint foreign key (idMedico) references medicos(id) on delete cascade
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
    constraint foreign key (idRecetas) references recetas(idConsulta) on delete cascade,
    constraint foreign key (idMedicamentos) references medicamentos(id) on delete cascade
);

create table consultas_media(
    id integer auto_increment primary key,
    idConsulta integer,
    media varchar(40),
    constraint foreign key (idConsulta) references consultas(id) on delete cascade
);

create table carrito(
    idPacientes integer,
    idMedicamentos integer,
    cantidad integer,
    constraint primary key (idMedicamentos,idPacientes),
    constraint foreign key (idPacientes) references pacientes(id) on delete cascade,
    constraint foreign key (idMedicamentos) references medicamentos(id) on delete cascade
);

create table ventas(
    id integer primary key auto_increment,
    idPacientes integer,
    total decimal(10,2),
    fecha datetime,
    constraint foreign key (idPacientes) references pacientes(id) on delete cascade
);

create table ventas_medicamentos(
    idVentas integer,
    idMedicamentos integer,
    cantidad integer,
    precio decimal(10,2),
    total decimal(10,2),
    constraint primary key (idMedicamentos,idVentas),
    constraint foreign key (idVentas) references ventas(id) on delete cascade,
    constraint foreign key (idMedicamentos) references medicamentos(id) on delete cascade
);

create table medicos_consultas(
    idMedicos integer,
    idConsultas integer,
    constraint primary key (idMedicos,idConsultas),
    constraint foreign key (idMedicos) references medicos(id) on delete cascade,
    constraint foreign key (idConsultas) references medicos(id) on delete cascade
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
('Eduardo Daniel','Rico','Gómez','Prol. Jacarandas 1010','Celaya','Guanajuato','Mexico','1999/07/23','4611842703','edu.dan68@gmail.com','edu5975','edu5975'),
('Julio César','García','Escoto','Arboledas 404','Salamanca','Guanajuato','Mexico','1999/05/10','4645793708','zeth@gmail.com','zeth','zeth');

insert into pacientes(nombres, apellidoPaterno, apellidoMaterno, direccion, municipio, estado, pais, nacimiento, telefono, email, user, password) values
('Maria Ines','Abadie','Fossatti','Dirección 453','Celaya','Guanajuato','Mexico','1974/03/17','3707292173','maria.ines183@medicare.com','maria.ines183','maria.ines183'),
('Raquel Elizabet','Abal','Nicolari','Dirección 454','Acambaro','Guanajuato','Mexico','1999/04/08','7355259549','raquel.elizabet448@medicare.com','raquel.elizabet448','raquel.elizabet448'),
('María Rosario','Abalde','Martinez','Dirección 455','Salamanca','Guanajuato','Mexico','1991/01/22','7255543346','maría.rosario234@medicare.com','maría.rosario234','maría.rosario234'),
('Alberto Oscar','Abalos','Rochon','Dirección 456','Irapuato','Guanajuato','Mexico','1968/12/23','5434752069','alberto.oscar478@medicare.com','alberto.oscar478','alberto.oscar478'),
('Ariel','Abarno','Silva','Dirección 457','Leon','Guanajuato','Mexico','2005/03/18','1566421499','ariel245@medicare.com','ariel245','ariel245'),
('Winston Franklin','Abascal','Beloqui','Dirección 458','Santiago de Querétaro','Querétaro','Mexico','1983/03/01','5429854469','winston.franklin15@medicare.com','winston.franklin15','winston.franklin15'),
('Pablo Daniel','Abdala','Schwarz','Dirección 459','Celaya','Guanajuato','Mexico','1973/08/20','465671613','pablo.daniel139@medicare.com','pablo.daniel139','pablo.daniel139'),
('Mercedes Maria','Abdala','Sosa','Dirección 460','Acambaro','Guanajuato','Mexico','1976/03/18','8051190165','mercedes.maria395@medicare.com','mercedes.maria395','mercedes.maria395'),
('Jorge Maria','Abin','De Maria','Dirección 461','Salamanca','Guanajuato','Mexico','1955/11/04','8544991982','jorge.maria60@medicare.com','jorge.maria60','jorge.maria60'),
('Alcides','Abreu','Hernandez','Dirección 462','Irapuato','Guanajuato','Mexico','1962/10/04','4792963272','alcides496@medicare.com','alcides496','alcides496'),
('Mirta Graciela','Abreu','Nuñez','Dirección 463','Leon','Guanajuato','Mexico','2003/08/05','2342369828','mirta.graciela461@medicare.com','mirta.graciela461','mirta.graciela461'),
('Sergio','Abreu','Bonilla','Dirección 464','Santiago de Querétaro','Querétaro','Mexico','1978/07/21','6335423658','sergio97@medicare.com','sergio97','sergio97'),
('Dorita','Abuchalja','Seade','Dirección 465','Celaya','Guanajuato','Mexico','1958/12/14','5031469691','dorita214@medicare.com','dorita214','dorita214'),
('Hugo Jose','Achugar','Ferrari','Dirección 466','Acambaro','Guanajuato','Mexico','1996/12/19','4420312258','hugo.jose60@medicare.com','hugo.jose60','hugo.jose60'),
('Jose Bartolome','Acosta','Madera','Dirección 467','Salamanca','Guanajuato','Mexico','1970/06/10','8301776512','jose.bartolome30@medicare.com','jose.bartolome30','jose.bartolome30'),
('Nelson Eduardo','Acosta','Martinez','Dirección 468','Irapuato','Guanajuato','Mexico','1972/09/15','5401360555','nelson.eduardo195@medicare.com','nelson.eduardo195','nelson.eduardo195'),
('Juan Carlos','Acosta','Perez','Dirección 469','Leon','Guanajuato','Mexico','1973/08/23','8530765614','juan.carlos117@medicare.com','juan.carlos117','juan.carlos117'),
('Martha Vanda','Acosta','Pereira','Dirección 470','Santiago de Querétaro','Querétaro','Mexico','1990/07/16','2589230406','martha.vanda176@medicare.com','martha.vanda176','martha.vanda176'),
('Mabel','Acosta','Sosa','Dirección 471','Celaya','Guanajuato','Mexico','1955/09/18','726882481','mabel135@medicare.com','mabel135','mabel135'),
('Efrain Andres','Acuña','Cabrera','Dirección 472','Acambaro','Guanajuato','Mexico','1984/02/28','1178649041','efrain.andres250@medicare.com','efrain.andres250','efrain.andres250'),
('Victor Esteban','Acuña','Gutierrez','Dirección 473','Salamanca','Guanajuato','Mexico','1999/06/09','2186236827','victor.esteban139@medicare.com','victor.esteban139','victor.esteban139'),
('Gerardo','Addiego','Prospero','Dirección 474','Irapuato','Guanajuato','Mexico','1995/04/20','5354692784','gerardo60@medicare.com','gerardo60','gerardo60'),
('Ernesto','Agazzi','Sarasola','Dirección 475','Leon','Guanajuato','Mexico','1979/11/06','6250264437','ernesto62@medicare.com','ernesto62','ernesto62'),
('Stella Serrana','Aguerre','Pereiro','Dirección 476','Santiago de Querétaro','Querétaro','Mexico','1985/01/08','1374067723','stella.serrana126@medicare.com','stella.serrana126','stella.serrana126'),
('Tabare','Aguerre','Lombardo','Dirección 477','Celaya','Guanajuato','Mexico','1993/11/13','7787055442','tabare40@medicare.com','tabare40','tabare40'),
('Silvia','Aguiar','','Dirección 478','Acambaro','Guanajuato','Mexico','1984/03/19','297730492','silvia40@medicare.com','silvia40','silvia40'),
('Claudio Martin','Aguilar','Pais','Dirección 479','Salamanca','Guanajuato','Mexico','1985/05/19','7693466884','claudio.martin412@medicare.com','claudio.martin412','claudio.martin412'),
('Victor Hugo','Aguilar','Aguilar','Dirección 480','Irapuato','Guanajuato','Mexico','2000/05/21','6162707977','victor.hugo208@medicare.com','victor.hugo208','victor.hugo208'),
('Jose Eduardo','Aguiñaga','Corbo','Dirección 481','Leon','Guanajuato','Mexico','1955/01/20','7590549727','jose.eduardo426@medicare.com','jose.eduardo426','jose.eduardo426'),
('Jose Maria','Aguirre','','Dirección 482','Santiago de Querétaro','Querétaro','Mexico','1956/02/20','2199777243','jose.maria189@medicare.com','jose.maria189','jose.maria189'),
('María Rosa','Aguirre','Sepilov','Dirección 483','Celaya','Guanajuato','Mexico','1970/04/28','611318035','maría.rosa424@medicare.com','maría.rosa424','maría.rosa424'),
('Carlos Waldemar','Aguirre','Daniele','Dirección 484','Acambaro','Guanajuato','Mexico','1967/10/08','2616699342','carlos.waldemar44@medicare.com','carlos.waldemar44','carlos.waldemar44'),
('Esteban Raul','Agustoni','Rijo','Dirección 485','Salamanca','Guanajuato','Mexico','1989/10/16','3121845285','esteban.raul123@medicare.com','esteban.raul123','esteban.raul123'),
('Roberto','Airaldi','Gomez','Dirección 486','Irapuato','Guanajuato','Mexico','1993/04/14','721535197','roberto263@medicare.com','roberto263','roberto263'),
('Edgardo Ramon','Aizcorbe','Barcia','Dirección 487','Leon','Guanajuato','Mexico','1998/08/13','440484638','edgardo.ramon370@medicare.com','edgardo.ramon370','edgardo.ramon370'),
('Denise Haifa','Akiki','Berhquet','Dirección 488','Santiago de Querétaro','Querétaro','Mexico','2002/08/05','5060599189','denise.haifa223@medicare.com','denise.haifa223','denise.haifa223'),
('Miguel Angel','Alaniz','Echeverry','Dirección 489','Celaya','Guanajuato','Mexico','1950/04/07','143662343','miguel.angel8@medicare.com','miguel.angel8','miguel.angel8'),
('Carlos','Albisu','','Dirección 490','Acambaro','Guanajuato','Mexico','1997/02/03','9427991766','carlos439@medicare.com','carlos439','carlos439'),
('Manuel Narciso','Albisu','Britos','Dirección 491','Salamanca','Guanajuato','Mexico','1995/02/16','3733651542','manuel.narciso476@medicare.com','manuel.narciso476','manuel.narciso476'),
('Ruben Dario','Alboa','','Dirección 492','Irapuato','Guanajuato','Mexico','1984/10/10','8535870259','ruben.dario430@medicare.com','ruben.dario430','ruben.dario430'),
('Mario Bernabe','Albornoz','De Mello','Dirección 493','Leon','Guanajuato','Mexico','2003/02/11','8757834518','mario.bernabe169@medicare.com','mario.bernabe169','mario.bernabe169'),
('Yamandu','Alcantara','Sanchez','Dirección 494','Santiago de Querétaro','Querétaro','Mexico','1990/08/20','4180344513','yamandu42@medicare.com','yamandu42','yamandu42'),
('Nilson Angel','Alcarraz','Barrio','Dirección 495','Celaya','Guanajuato','Mexico','1969/07/11','5892818777','nilson.angel385@medicare.com','nilson.angel385','nilson.angel385'),
('Asucena','Alcina','Peña','Dirección 496','Acambaro','Guanajuato','Mexico','1979/12/20','3546098823','asucena301@medicare.com','asucena301','asucena301'),
('Luis','Aldabe','Dini','Dirección 497','Salamanca','Guanajuato','Mexico','1965/04/10','1335787092','luis18@medicare.com','luis18','luis18'),
('Ricardo','Aldabe','Dini','Dirección 498','Irapuato','Guanajuato','Mexico','1974/03/01','8570358001','ricardo311@medicare.com','ricardo311','ricardo311'),
('Daniel','Aldecosea','Pedrozza','Dirección 499','Leon','Guanajuato','Mexico','1960/09/23','5864647958','daniel119@medicare.com','daniel119','daniel119'),
('Miguel','Alegretti','Cammarano','Dirección 500','Santiago de Querétaro','Querétaro','Mexico','1967/05/03','8407206595','miguel441@medicare.com','miguel441','miguel441'),
('Jose Antonio','Alem','Deaces','Dirección 501','Celaya','Guanajuato','Mexico','1969/05/27','6531342507','jose.antonio444@medicare.com','jose.antonio444','jose.antonio444'),
('Humberto Ramàn','Alfaro','Mendoza','Dirección 502','Acambaro','Guanajuato','Mexico','1992/03/23','6201907835','humberto.ramàn4@medicare.com','humberto.ramàn4','humberto.ramàn4'),
('Juan Carlos','Alfaro','Chiappa','Dirección 503','Salamanca','Guanajuato','Mexico','1956/03/25','3354904500','juan.carlos447@medicare.com','juan.carlos447','juan.carlos447'),
('Maria Gabriela','Algorta','Rusiñol','Dirección 504','Irapuato','Guanajuato','Mexico','1978/11/15','4249490137','maria.gabriela214@medicare.com','maria.gabriela214','maria.gabriela214'),
('Felipe Jose','Algorta','Brit','Dirección 505','Leon','Guanajuato','Mexico','1986/06/27','4935618142','felipe.jose148@medicare.com','felipe.jose148','felipe.jose148'),
('Veronica','Alles','Vedain','Dirección 506','Santiago de Querétaro','Querétaro','Mexico','2000/07/13','740101215','veronica451@medicare.com','veronica451','veronica451'),
('María Luisa','Almada','Blengio','Dirección 507','Celaya','Guanajuato','Mexico','1962/01/19','6595519354','maría.luisa250@medicare.com','maría.luisa250','maría.luisa250'),
('Nestor Daniel','Almada','Montans','Dirección 508','Acambaro','Guanajuato','Mexico','1982/07/02','8980805055','nestor.daniel124@medicare.com','nestor.daniel124','nestor.daniel124'),
('Luis Leonardo','Almagro','Lemes','Dirección 509','Salamanca','Guanajuato','Mexico','2001/01/03','600722378','luis.leonardo156@medicare.com','luis.leonardo156','luis.leonardo156'),
('Maria Graciela','Almanza','De Los Santos','Dirección 510','Irapuato','Guanajuato','Mexico','1983/04/15','6458383802','maria.graciela244@medicare.com','maria.graciela244','maria.graciela244'),
('Silvana Jacquline','Almeda','Moreira','Dirección 511','Leon','Guanajuato','Mexico','1992/05/13','8259864454','silvana.jacquline423@medicare.com','silvana.jacquline423','silvana.jacquline423'),
('Gerardo','Almeida','Berdiñas','Dirección 512','Santiago de Querétaro','Querétaro','Mexico','1998/12/06','5587724521','gerardo440@medicare.com','gerardo440','gerardo440'),
('Gabriela','Almirati','Saibene','Dirección 513','Celaya','Guanajuato','Mexico','1993/11/16','7935325594','gabriela472@medicare.com','gabriela472','gabriela472'),
('Alejandro Andres','Almiron','Belen','Dirección 514','Acambaro','Guanajuato','Mexico','1955/05/03','5362707212','alejandro.andres169@medicare.com','alejandro.andres169','alejandro.andres169'),
('Jose Luis','Almiron','Fredes','Dirección 515','Salamanca','Guanajuato','Mexico','1986/01/21','53515713','jose.luis475@medicare.com','jose.luis475','jose.luis475'),
('Leonardo Gustavo','Alonso','Chiappara','Dirección 516','Irapuato','Guanajuato','Mexico','1974/11/20','5897447823','leonardo.gustavo108@medicare.com','leonardo.gustavo108','leonardo.gustavo108'),
('Veronica Maria','Alonso','Montaño','Dirección 517','Leon','Guanajuato','Mexico','1980/11/06','8699421602','veronica.maria362@medicare.com','veronica.maria362','veronica.maria362'),
('Gonzalo','Alonso','May','Dirección 518','Santiago de Querétaro','Querétaro','Mexico','1994/12/20','6528190466','gonzalo33@medicare.com','gonzalo33','gonzalo33'),
('Noemi Lydia','Alonso','Firpi','Dirección 519','Celaya','Guanajuato','Mexico','1986/02/12','6361153572','noemi.lydia28@medicare.com','noemi.lydia28','noemi.lydia28'),
('Maria Del Carmen','Alonso','Rodriguez','Dirección 520','Acambaro','Guanajuato','Mexico','1979/12/10','7260330507','maria.del.carmen283@medicare.com','maria.del.carmen283','maria.del.carmen283'),
('Maria Jimena','Alonso','Hauw','Dirección 521','Salamanca','Guanajuato','Mexico','1978/06/24','2622678295','maria.jimena417@medicare.com','maria.jimena417','maria.jimena417'),
('Mary Cristina','Alonso','Flumini','Dirección 522','Irapuato','Guanajuato','Mexico','1999/12/18','6682940267','mary.cristina229@medicare.com','mary.cristina229','mary.cristina229'),
('Rosa M','Alpuy','Casas','Dirección 523','Leon','Guanajuato','Mexico','1979/06/11','2785845658','rosa.m394@medicare.com','rosa.m394','rosa.m394'),
('Ramiro','Alvarez','De La Fuente','Dirección 524','Santiago de Querétaro','Querétaro','Mexico','1951/05/01','8195015582','ramiro11@medicare.com','ramiro11','ramiro11'),
('Luis','Alvarez','Fernandez','Dirección 525','Celaya','Guanajuato','Mexico','1960/10/14','6500536289','luis456@medicare.com','luis456','luis456'),
('Jorge Antonio','Alvarez','Rodriguez','Dirección 526','Acambaro','Guanajuato','Mexico','1974/05/04','6491057986','jorge.antonio233@medicare.com','jorge.antonio233','jorge.antonio233'),
('Pablo Emiliano','Alvarez','Lopez','Dirección 527','Salamanca','Guanajuato','Mexico','1961/07/03','8200758065','pablo.emiliano196@medicare.com','pablo.emiliano196','pablo.emiliano196'),
('Juan Martin','Alvarez','Mauvezin','Dirección 528','Irapuato','Guanajuato','Mexico','1989/04/16','7611349256','juan.martin276@medicare.com','juan.martin276','juan.martin276'),
('Analia','Alvarez','Corral','Dirección 529','Leon','Guanajuato','Mexico','1993/01/06','4780479087','analia273@medicare.com','analia273','analia273'),
('Alvaro Bolivar','Alvarez','Fernandez','Dirección 530','Santiago de Querétaro','Querétaro','Mexico','1952/07/04','9704611179','alvaro.bolivar140@medicare.com','alvaro.bolivar140','alvaro.bolivar140'),
('Alfredo','Alvarez','Bogliolo','Dirección 531','Celaya','Guanajuato','Mexico','1993/03/24','8013938512','alfredo152@medicare.com','alfredo152','alfredo152'),
('Alejandro','Alvarez','Izetta','Dirección 532','Acambaro','Guanajuato','Mexico','1993/05/11','9387295024','alejandro86@medicare.com','alejandro86','alejandro86'),
('Fernando Tomas','Alvarez','Alonzo','Dirección 533','Salamanca','Guanajuato','Mexico','1966/10/16','3934152030','fernando.tomas36@medicare.com','fernando.tomas36','fernando.tomas36'),
('Hugo','Alvarez','Saldias','Dirección 534','Irapuato','Guanajuato','Mexico','1986/06/23','4408269599','hugo7@medicare.com','hugo7','hugo7'),
('Alicia Teresita','Alvarez','Martinez','Dirección 535','Leon','Guanajuato','Mexico','2002/05/17','8617219792','alicia.teresita249@medicare.com','alicia.teresita249','alicia.teresita249'),
('Gerardo Javier','Alvarez','Escursell','Dirección 536','Santiago de Querétaro','Querétaro','Mexico','1963/10/24','3788992006','gerardo.javier406@medicare.com','gerardo.javier406','gerardo.javier406'),
('Huberto Nilson','Alvarez','Samudio','Dirección 537','Celaya','Guanajuato','Mexico','1965/06/10','1477427315','huberto.nilson181@medicare.com','huberto.nilson181','huberto.nilson181'),
('Antonio','Alvarez','','Dirección 538','Acambaro','Guanajuato','Mexico','1972/04/20','2324304677','antonio315@medicare.com','antonio315','antonio315'),
('Miguel Angel','Alves','Ortiz','Dirección 539','Salamanca','Guanajuato','Mexico','1969/12/15','6636836487','miguel.angel349@medicare.com','miguel.angel349','miguel.angel349'),
('Martha Elizabeth','Alves De Simas','Grimon','Dirección 540','Irapuato','Guanajuato','Mexico','1977/09/07','5538279872','martha.elizabeth46@medicare.com','martha.elizabeth46','martha.elizabeth46'),
('Victor Ricardo','Alvez','Izquierdo','Dirección 541','Leon','Guanajuato','Mexico','1970/10/26','651119855','victor.ricardo295@medicare.com','victor.ricardo295','victor.ricardo295'),
('Ruben Ari','Alvez','Viera','Dirección 542','Santiago de Querétaro','Querétaro','Mexico','1988/07/20','8142891586','ruben.ari350@medicare.com','ruben.ari350','ruben.ari350'),
('Roque Gaston','Alvez','Viera','Dirección 543','Celaya','Guanajuato','Mexico','1999/12/28','2430427648','roque.gaston100@medicare.com','roque.gaston100','roque.gaston100'),
('Americo','Alvez','','Dirección 544','Acambaro','Guanajuato','Mexico','1957/05/01','42937596','americo298@medicare.com','americo298','americo298'),
('Ana Carolina','Alvez','Hourcade','Dirección 545','Salamanca','Guanajuato','Mexico','1992/05/25','3852911623','ana.carolina448@medicare.com','ana.carolina448','ana.carolina448'),
('Eva Myrian','Alvez','Vila','Dirección 546','Irapuato','Guanajuato','Mexico','1982/11/05','6359124054','eva.myrian138@medicare.com','eva.myrian138','eva.myrian138'),
('Alvaro Martin','Alza','Sastre','Dirección 547','Leon','Guanajuato','Mexico','1963/09/12','604453037','alvaro.martin200@medicare.com','alvaro.martin200','alvaro.martin200'),
('Marisa Daniela','Alza','Fiorelli','Dirección 548','Santiago de Querétaro','Querétaro','Mexico','1979/06/13','8980052469','marisa.daniela479@medicare.com','marisa.daniela479','marisa.daniela479'),
('Juan Pablo','Alzugaray','Saralegui','Dirección 549','Celaya','Guanajuato','Mexico','1989/08/12','2894200701','juan.pablo70@medicare.com','juan.pablo70','juan.pablo70'),
('Fernando','Amado','Fernandez','Dirección 550','Acambaro','Guanajuato','Mexico','2003/07/21','1587980678','fernando19@medicare.com','fernando19','fernando19'),
('Sylvia','Amado','Aparicio','Dirección 551','Salamanca','Guanajuato','Mexico','1977/10/09','6972218191','sylvia272@medicare.com','sylvia272','sylvia272');

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

insert into medicos(nombres, apellidoPaterno, apellidoMaterno, cedula, direccion, municipio, estado, pais, telefono, email, user, password, idEspecialidades) values
('Marcelo','Amado','Chalela','52.710.695','Medico 100','Irapuato','Guanajuato','Mexico','9639600841','marcelo39@medicare.com','marcelo39','marcelo39',(select id from especialidades order by rand() limit 1)),
('Hugo Ariel','Amaral','Rocca','51.738.984','Medico 101','Leon','Guanajuato','Mexico','938745211','hugo.ariel324@medicare.com','hugo.ariel324','hugo.ariel324',(select id from especialidades order by rand() limit 1)),
('Gerardo Andres','Amarilla','De Nicola','52.355.290','Medico 102','Santiago de Querétaro','Querétaro','Mexico','938300065','gerardo.andres382@medicare.com','gerardo.andres382','gerardo.andres382',(select id from especialidades order by rand() limit 1)),
('Juan Justo','Amaro','Cedres','79962291','Medico 103','Celaya','Guanajuato','Mexico','938208674','juan.justo494@medicare.com','juan.justo494','juan.justo494',(select id from especialidades order by rand() limit 1)),
('Ruben Jose','Amaro','Machado','41547273','Medico 104','Acambaro','Guanajuato','Mexico','930214054','ruben.jose215@medicare.com','ruben.jose215','ruben.jose215',(select id from especialidades order by rand() limit 1)),
('Ruben Williams','Amato','Lusararian','51899077','Medico 105','Salamanca','Guanajuato','Mexico','936521404','ruben.williams96@medicare.com','ruben.williams96','ruben.williams96',(select id from especialidades order by rand() limit 1)),
('Elder Diego','Amendola','Mazzula','39.568.175','Medico 106','Irapuato','Guanajuato','Mexico','938350593','elder.diego182@medicare.com','elder.diego182','elder.diego182',(select id from especialidades order by rand() limit 1)),
('Fernando','Amestoy','Rosso','52.755.672','Medico 107','Leon','Guanajuato','Mexico','939962045','fernando375@medicare.com','fernando375','fernando375',(select id from especialidades order by rand() limit 1)),
('Luis','Amil','Lopez','52.817.196','Medico 108','Santiago de Querétaro','Querétaro','Mexico','938755603','luis500@medicare.com','luis500','luis500',(select id from especialidades order by rand() limit 1)),
('Irle Maider','Amir','Amy','52960227','Medico 109','Celaya','Guanajuato','Mexico','938305524','irle.maider394@medicare.com','irle.maider394','irle.maider394',(select id from especialidades order by rand() limit 1)),
('Francisco Javier','Amorena','Fernandez','52329187','Medico 110','Acambaro','Guanajuato','Mexico','936571974','francisco.javier426@medicare.com','francisco.javier426','francisco.javier426',(select id from especialidades order by rand() limit 1)),
('Jose Gerardo','Amorin','Batlle','52.494.004','Medico 111','Salamanca','Guanajuato','Mexico','938300036','jose.gerardo303@medicare.com','jose.gerardo303','jose.gerardo303',(select id from especialidades order by rand() limit 1)),
('Jose Antonio','Amy','Tejera','52.705.875','Medico 112','Irapuato','Guanajuato','Mexico','936505455','jose.antonio319@medicare.com','jose.antonio319','jose.antonio319',(select id from especialidades order by rand() limit 1)),
('Luis Hector','Anastasia','Correa','52.987.453','Medico 113','Leon','Guanajuato','Mexico','936587454','luis.hector451@medicare.com','luis.hector451','luis.hector451',(select id from especialidades order by rand() limit 1)),
('Niria','Anastasia','Suarez','52.880.406','Medico 114','Santiago de Querétaro','Querétaro','Mexico','938725845','niria153@medicare.com','niria153','niria153',(select id from especialidades order by rand() limit 1)),
('Hector Daniel','Ancheta','Franca','39.559.801','Medico 115','Celaya','Guanajuato','Mexico','938205730','hector.daniel59@medicare.com','hector.daniel59','hector.daniel59',(select id from especialidades order by rand() limit 1)),
('Javier Zenon','Andrade','Duhalde','52.453.801','Medico 116','Acambaro','Guanajuato','Mexico','936828258','javier.zenon204@medicare.com','javier.zenon204','javier.zenon204',(select id from especialidades order by rand() limit 1)),
('Luis Alberto','Andrade','Defelipo','19442527','Medico 117','Salamanca','Guanajuato','Mexico','938300045','luis.alberto77@medicare.com','luis.alberto77','luis.alberto77',(select id from especialidades order by rand() limit 1)),
('Rafael','Andrade','Benoit','52.198.296','Medico 118','Irapuato','Guanajuato','Mexico','936521452','rafael193@medicare.com','rafael193','rafael193',(select id from especialidades order by rand() limit 1)),
('Alberto Fabian','Andrade','Valdez','52807753','Medico 119','Leon','Guanajuato','Mexico','938725885','alberto.fabian216@medicare.com','alberto.fabian216','alberto.fabian216',(select id from especialidades order by rand() limit 1)),
('Maria Isabel','Andreoni','Da Maria','51650895','Medico 120','Santiago de Querétaro','Querétaro','Mexico','938208303','maria.isabel315@medicare.com','maria.isabel315','maria.isabel315',(select id from especialidades order by rand() limit 1)),
('Sebastian','Andujar','Alvarez De Ron','80.235.960','Medico 121','Celaya','Guanajuato','Mexico','938360213','sebastian283@medicare.com','sebastian283','sebastian283',(select id from especialidades order by rand() limit 1)),
('Ana Monica','Angelini','Iguini','30.396.689','Medico 122','Acambaro','Guanajuato','Mexico','938320537','ana.monica278@medicare.com','ana.monica278','ana.monica278',(select id from especialidades order by rand() limit 1)),
('Nora Alicia','Annunziatto','Martino','79998342','Medico 123','Celaya','Guanajuato','Mexico','3796598158','nora.alicia152@medicare.com','nora.alicia152','nora.alicia152',(select id from especialidades order by rand() limit 1)),
('Waldemar Hebert','Annunziatto','Martino','52265956','Medico 124','Acambaro','Guanajuato','Mexico','1571904816','waldemar.hebert294@medicare.com','waldemar.hebert294','waldemar.hebert294',(select id from especialidades order by rand() limit 1)),
('Maria Mercedes','Antia','Beherens','52428220','Medico 125','Salamanca','Guanajuato','Mexico','2027384807','maria.mercedes252@medicare.com','maria.mercedes252','maria.mercedes252',(select id from especialidades order by rand() limit 1)),
('Enrique Andres','Antia','Behrens','52.962.491','Medico 126','Irapuato','Guanajuato','Mexico','9419224165','enrique.andres274@medicare.com','enrique.andres274','enrique.andres274',(select id from especialidades order by rand() limit 1)),
('Fernando','Antia','Behrens','52.517.450','Medico 127','Leon','Guanajuato','Mexico','4764155778','fernando474@medicare.com','fernando474','fernando474',(select id from especialidades order by rand() limit 1)),
('Alejandro','Antonelli','Corbi','52427093','Medico 128','Santiago de Querétaro','Querétaro','Mexico','628109958','alejandro310@medicare.com','alejandro310','alejandro310',(select id from especialidades order by rand() limit 1)),
('Olivera','Antonio','Albino','39.625.110','Medico 129','Celaya','Guanajuato','Mexico','6869286840','olivera435@medicare.com','olivera435','olivera435',(select id from especialidades order by rand() limit 1)),
('Fredis','Antunez','Martinez','51.963.634','Medico 130','Acambaro','Guanajuato','Mexico','1576153034','fredis416@medicare.com','fredis416','fredis416',(select id from especialidades order by rand() limit 1)),
('Mario','Anza','Leon','52.329.575','Medico 131','Celaya','Guanajuato','Mexico','5285171018','mario130@medicare.com','mario130','mario130',(select id from especialidades order by rand() limit 1)),
('Pablo','Anzalone','Cantoni','51.553.923','Medico 132','Acambaro','Guanajuato','Mexico','8816401452','pablo16@medicare.com','pablo16','pablo16',(select id from especialidades order by rand() limit 1)),
('Daniel','Apatia','Santini','52.835.436','Medico 133','Salamanca','Guanajuato','Mexico','3918312787','daniel342@medicare.com','daniel342','daniel342',(select id from especialidades order by rand() limit 1)),
('Pedro Roque','Apezteguia','Setelich','35.353.993','Medico 134','Irapuato','Guanajuato','Mexico','6314526314','pedro.roque100@medicare.com','pedro.roque100','pedro.roque100',(select id from especialidades order by rand() limit 1)),
('Gabriel','Apolo','Goyoaga','52146038','Medico 135','Leon','Guanajuato','Mexico','2162218511','gabriel414@medicare.com','gabriel414','gabriel414',(select id from especialidades order by rand() limit 1)),
('Ramon Francisco','Appratto','Lorenzo','30.402.976','Medico 136','Santiago de Querétaro','Querétaro','Mexico','2984152959','ramon.francisco77@medicare.com','ramon.francisco77','ramon.francisco77',(select id from especialidades order by rand() limit 1)),
('Laura','Aquino','Dominguez','52771781','Medico 137','Celaya','Guanajuato','Mexico','7389010433','laura292@medicare.com','laura292','laura292',(select id from especialidades order by rand() limit 1)),
('Miriam Amelia','Arada','Mier','52252464','Medico 138','Acambaro','Guanajuato','Mexico','9690442594','miriam.amelia271@medicare.com','miriam.amelia271','miriam.amelia271',(select id from especialidades order by rand() limit 1)),
('Roque Daniel','Arambula','Leal','79800914','Medico 139','Celaya','Guanajuato','Mexico','7973278105','roque.daniel383@medicare.com','roque.daniel383','roque.daniel383',(select id from especialidades order by rand() limit 1)),
('Ignacio','Aramburu','','28685434','Medico 140','Acambaro','Guanajuato','Mexico','8450503862','ignacio323@medicare.com','ignacio323','ignacio323',(select id from especialidades order by rand() limit 1)),
('Jose Luis','Aramburu','De La Rosa','39.548.021','Medico 141','Salamanca','Guanajuato','Mexico','5390559017','jose.luis413@medicare.com','jose.luis413','jose.luis413',(select id from especialidades order by rand() limit 1)),
('Daniel Hugo','Arancio','Romano','60263649','Medico 142','Irapuato','Guanajuato','Mexico','9026936495','daniel.hugo185@medicare.com','daniel.hugo185','daniel.hugo185',(select id from especialidades order by rand() limit 1)),
('Mary Beatriz','Araujo','Duarte','78703533','Medico 143','Leon','Guanajuato','Mexico','4555842197','mary.beatriz72@medicare.com','mary.beatriz72','mary.beatriz72',(select id from especialidades order by rand() limit 1)),
('Lidia','Araujo','Serron','52021541','Medico 144','Santiago de Querétaro','Querétaro','Mexico','8803815514','lidia323@medicare.com','lidia323','lidia323',(select id from especialidades order by rand() limit 1)),
('Hugo Roman','Araujo','Mena','52.477.124','Medico 145','Celaya','Guanajuato','Mexico','3057706391','hugo.roman367@medicare.com','hugo.roman367','hugo.roman367',(select id from especialidades order by rand() limit 1)),
('Gabriela ---','Araujo','Nicolini','52.357.419','Medico 146','Acambaro','Guanajuato','Mexico','4678897646','gabriela.---417@medicare.com','gabriela.---417','gabriela.---417',(select id from especialidades order by rand() limit 1)),
('Alicia','Araujo','Refresquini','80.525.886','Medico 147','Celaya','Guanajuato','Mexico','5036587940','alicia326@medicare.com','alicia326','alicia326',(select id from especialidades order by rand() limit 1)),
('Hubert','Arbildi','Lopez','52.556.028','Medico 148','Acambaro','Guanajuato','Mexico','880420605','hubert84@medicare.com','hubert84','hubert84',(select id from especialidades order by rand() limit 1)),
('Gualberto','Arbiza','','3983136','Medico 149','Salamanca','Guanajuato','Mexico','8328192837','gualberto435@medicare.com','gualberto435','gualberto435',(select id from especialidades order by rand() limit 1)),
('Eduardo','Arbulo','','52.982.828','Medico 150','Irapuato','Guanajuato','Mexico','6435130241','eduardo117@medicare.com','eduardo117','eduardo117',(select id from especialidades order by rand() limit 1)),
('Mateo Daniel','Arbulo','Ferreira','40.777.577','Medico 151','Leon','Guanajuato','Mexico','3155126655','mateo.daniel10@medicare.com','mateo.daniel10','mateo.daniel10',(select id from especialidades order by rand() limit 1)),
('Divar Daniel','Arcieri','Rodriguez','28.892.971','Medico 152','Santiago de Querétaro','Querétaro','Mexico','7326600497','divar.daniel196@medicare.com','divar.daniel196','divar.daniel196',(select id from especialidades order by rand() limit 1)),
('Jose Sebastian','Arellano','Ayala','41.781.216','Medico 153','Celaya','Guanajuato','Mexico','3307331545','jose.sebastian380@medicare.com','jose.sebastian380','jose.sebastian380',(select id from especialidades order by rand() limit 1)),
('Adriana Raquel','Arenas','Barreiro','51.562.804','Medico 154','Acambaro','Guanajuato','Mexico','9082757265','adriana.raquel394@medicare.com','adriana.raquel394','adriana.raquel394',(select id from especialidades order by rand() limit 1)),
('Miriam Guiomar','Areosa','Cazajous','41.598.716','Medico 155','Celaya','Guanajuato','Mexico','8119258041','miriam.guiomar445@medicare.com','miriam.guiomar445','miriam.guiomar445',(select id from especialidades order by rand() limit 1)),
('Carlos Valerio','Arezo','Posada','39.687.248','Medico 156','Acambaro','Guanajuato','Mexico','4877022592','carlos.valerio403@medicare.com','carlos.valerio403','carlos.valerio403',(select id from especialidades order by rand() limit 1)),
('Enrique','Arezo','Nande','52.539.108','Medico 157','Salamanca','Guanajuato','Mexico','7432158617','enrique458@medicare.com','enrique458','enrique458',(select id from especialidades order by rand() limit 1)),
('Ismael','Arguello','Rodriguez','19.393.136','Medico 158','Irapuato','Guanajuato','Mexico','2718512747','ismael162@medicare.com','ismael162','ismael162',(select id from especialidades order by rand() limit 1)),
('Maria Elida','Arguello','Wetherall','13541790','Medico 159','Leon','Guanajuato','Mexico','2574733991','maria.elida139@medicare.com','maria.elida139','maria.elida139',(select id from especialidades order by rand() limit 1)),
('Manuel Ernesto','Arias','Pichon','79.514.499','Medico 160','Santiago de Querétaro','Querétaro','Mexico','3458329002','manuel.ernesto362@medicare.com','manuel.ernesto362','manuel.ernesto362',(select id from especialidades order by rand() limit 1)),
('Rivera','Arias','Morales','52.504.235','Medico 161','Celaya','Guanajuato','Mexico','1133317180','rivera11@medicare.com','rivera11','rivera11',(select id from especialidades order by rand() limit 1)),
('Ricardo','Arigon','Bachini','52.334.827','Medico 162','Acambaro','Guanajuato','Mexico','5448838971','ricardo293@medicare.com','ricardo293','ricardo293',(select id from especialidades order by rand() limit 1)),
('Rodrigo Miguel','Arim','Ihlenfeld','41365113','Medico 163','Celaya','Guanajuato','Mexico','3075986268','rodrigo.miguel305@medicare.com','rodrigo.miguel305','rodrigo.miguel305',(select id from especialidades order by rand() limit 1)),
('Juan Carlos','Arismendes','Martinez','19273241','Medico 164','Acambaro','Guanajuato','Mexico','171989955','juan.carlos347@medicare.com','juan.carlos347','juan.carlos347',(select id from especialidades order by rand() limit 1)),
('Carlos Domingo','Arismendi','Cesar','52324374','Medico 165','Salamanca','Guanajuato','Mexico','9423221364','carlos.domingo121@medicare.com','carlos.domingo121','carlos.domingo121',(select id from especialidades order by rand() limit 1)),
('Jose Andres','Arocena','Argul','51937530','Medico 166','Irapuato','Guanajuato','Mexico','3942668408','jose.andres73@medicare.com','jose.andres73','jose.andres73',(select id from especialidades order by rand() limit 1)),
('Rodrigo','Arocena','Linn','1979784','Medico 167','Leon','Guanajuato','Mexico','7046031570','rodrigo44@medicare.com','rodrigo44','rodrigo44',(select id from especialidades order by rand() limit 1)),
('Oscar','Arrambide','Monce','52.386.987','Medico 168','Santiago de Querétaro','Querétaro','Mexico','412559993','oscar406@medicare.com','oscar406','oscar406',(select id from especialidades order by rand() limit 1)),
('Roque Edison','Arregui','Marsano','19.296.439','Medico 169','Celaya','Guanajuato','Mexico','3550300257','roque.edison433@medicare.com','roque.edison433','roque.edison433',(select id from especialidades order by rand() limit 1)),
('Claudia','Arriaga','Villamil','79.055.667','Medico 170','Acambaro','Guanajuato','Mexico','424582672','claudia377@medicare.com','claudia377','claudia377',(select id from especialidades order by rand() limit 1)),
('Elizabeth','Arrieta','Lucchetti','79.503.076','Medico 171','Celaya','Guanajuato','Mexico','9564454858','elizabeth303@medicare.com','elizabeth303','elizabeth303',(select id from especialidades order by rand() limit 1)),
('Sergio Raul','Arrigoni','Beraza','52.848.172','Medico 172','Acambaro','Guanajuato','Mexico','1871896627','sergio.raul347@medicare.com','sergio.raul347','sergio.raul347',(select id from especialidades order by rand() limit 1)),
('Jose Pablo','Arroyal','Rodriguez','45.761.623','Medico 173','Salamanca','Guanajuato','Mexico','5163321630','jose.pablo440@medicare.com','jose.pablo440','jose.pablo440',(select id from especialidades order by rand() limit 1)),
('Silvia','Arroyo','Ferreiro','54255464','Medico 174','Irapuato','Guanajuato','Mexico','9565941772','silvia220@medicare.com','silvia220','silvia220',(select id from especialidades order by rand() limit 1)),
('Sergio','Artazu','D`Apolito','52113219','Medico 175','Leon','Guanajuato','Mexico','5355017723','sergio255@medicare.com','sergio255','sergio255',(select id from especialidades order by rand() limit 1)),
('Maria Teresa','Artecona','Gulla','52419858','Medico 176','Santiago de Querétaro','Querétaro','Mexico','9632795805','maria.teresa201@medicare.com','maria.teresa201','maria.teresa201',(select id from especialidades order by rand() limit 1)),
('Julio Cesar','Artigas','Lema','79.381.517','Medico 177','Celaya','Guanajuato','Mexico','7131219474','julio.cesar169@medicare.com','julio.cesar169','julio.cesar169',(select id from especialidades order by rand() limit 1)),
('Enrique','Artola','Naranja','40.384.475','Medico 178','Acambaro','Guanajuato','Mexico','2084766156','enrique182@medicare.com','enrique182','enrique182',(select id from especialidades order by rand() limit 1)),
('Adriana Laura','Arturo','Loureiro','52.279.000','Medico 179','Celaya','Guanajuato','Mexico','8868448976','adriana.laura179@medicare.com','adriana.laura179','adriana.laura179',(select id from especialidades order by rand() limit 1)),
('Sergio Mario','Ashfield','Prats','51864061','Medico 180','Acambaro','Guanajuato','Mexico','1822779251','sergio.mario251@medicare.com','sergio.mario251','sergio.mario251',(select id from especialidades order by rand() limit 1)),
('Miguel Medardo','Asqueta','Soñora','52424544','Medico 181','Salamanca','Guanajuato','Mexico','3500215804','miguel.medardo197@medicare.com','miguel.medardo197','miguel.medardo197',(select id from especialidades order by rand() limit 1)),
('Alfredo Angel','Asti','Carli','52355729','Medico 182','Irapuato','Guanajuato','Mexico','6210118719','alfredo.angel166@medicare.com','alfredo.angel166','alfredo.angel166',(select id from especialidades order by rand() limit 1)),
('Diego','Astiazaran','Perez','52056904','Medico 183','Leon','Guanajuato','Mexico','4132067281','diego284@medicare.com','diego284','diego284',(select id from especialidades order by rand() limit 1)),
('Dario','Astor','Porrini','51642781','Medico 184','Santiago de Querétaro','Querétaro','Mexico','9111701177','dario32@medicare.com','dario32','dario32',(select id from especialidades order by rand() limit 1)),
('Danilo','Astori','','52056236','Medico 185','Celaya','Guanajuato','Mexico','8859631696','danilo281@medicare.com','danilo281','danilo281',(select id from especialidades order by rand() limit 1)),
('Juan','Atilio','Tapia','79712892','Medico 186','Acambaro','Guanajuato','Mexico','3889517796','juan372@medicare.com','juan372','juan372',(select id from especialidades order by rand() limit 1)),
('Jose Maria','Aunchain','Esponda','79841386','Medico 187','Celaya','Guanajuato','Mexico','851978616','jose.maria123@medicare.com','jose.maria123','jose.maria123',(select id from especialidades order by rand() limit 1)),
('Carlos Francisco','Aunchayna','Polla','52.849.625','Medico 188','Acambaro','Guanajuato','Mexico','7611870454','carlos.francisco55@medicare.com','carlos.francisco55','carlos.francisco55',(select id from especialidades order by rand() limit 1)),
('Luis Alberto','Avellanal','Suarez','52.849.626','Medico 189','Salamanca','Guanajuato','Mexico','4385065746','luis.alberto379@medicare.com','luis.alberto379','luis.alberto379',(select id from especialidades order by rand() limit 1)),
('Oldemar Jacinto','Avero','Diverio','52365690','Medico 190','Irapuato','Guanajuato','Mexico','758510267','oldemar.jacinto100@medicare.com','oldemar.jacinto100','oldemar.jacinto100',(select id from especialidades order by rand() limit 1)),
('Andrea','Aviaga','','16079301','Medico 191','Leon','Guanajuato','Mexico','8976011446','andrea57@medicare.com','andrea57','andrea57',(select id from especialidades order by rand() limit 1)),
('Dardo','Avila','Recuero','52515572','Medico 192','Santiago de Querétaro','Querétaro','Mexico','3189764325','dardo42@medicare.com','dardo42','dardo42',(select id from especialidades order by rand() limit 1)),
('Ana Patricia','Ayala','Sanchis','52.384.245','Medico 193','Celaya','Guanajuato','Mexico','7369396185','ana.patricia117@medicare.com','ana.patricia117','ana.patricia117',(select id from especialidades order by rand() limit 1)),
('Beatriz Maria','Azambuja','Patrone','41646919','Medico 194','Acambaro','Guanajuato','Mexico','6107352926','beatriz.maria98@medicare.com','beatriz.maria98','beatriz.maria98',(select id from especialidades order by rand() limit 1)),
('Teresita','Azambuya','Aguerre','41711908','Medico 195','Celaya','Guanajuato','Mexico','1687020537','teresita234@medicare.com','teresita234','teresita234',(select id from especialidades order by rand() limit 1)),
('Hernann Eric','Azaretto','Mañana','52112753','Medico 196','Acambaro','Guanajuato','Mexico','720448944','hernann.eric296@medicare.com','hernann.eric296','hernann.eric296',(select id from especialidades order by rand() limit 1)),
('Pablo Eduardo','Azcue','Aizpun','35.324.428','Medico 197','Salamanca','Guanajuato','Mexico','5230533144','pablo.eduardo216@medicare.com','pablo.eduardo216','pablo.eduardo216',(select id from especialidades order by rand() limit 1)),
('Karina','Azuriz','Cannella','46.660.281','Medico 198','Irapuato','Guanajuato','Mexico','3186249040','karina214@medicare.com','karina214','karina214',(select id from especialidades order by rand() limit 1));

insert into servicios_medicos(idMedicos,idServicios,costo) values (1,3,1000),(1,1,3200),(1,20,200),(1,45,400);

insert into consultas(idPaciente, idEspecialidad, sintomas, estado,fecha) values
(1,1,'Me siento mal 1','Con respuesta',current_timestamp()),
(1,2,'Me siento mal 2','Con respuesta',current_timestamp()),
(1,3,'Me siento mal 3','Sin responder',current_timestamp()),
(2,1,'Me siento mal 4','Sin responder',current_timestamp()),
(2,2,'Me siento mal 5','Sin responder',current_timestamp()),
(2,3,'Me siento mal 6','Sin responder',current_timestamp());

insert into covid(idPaciente, idMedico, estado, fecha) values
(1,1,'Sospechoso',current_timestamp()),
(1,2,'Confirmado',current_timestamp()),
(1,1,'Curado',current_timestamp());

insert into recetas(idConsulta, idMedico, descripcion) values
(1,1,'Debes hacer esto'),
(2,1,'Debes hacer esto');

insert into medicamentos(nombre, descripcion, costo, foto) values
('Simvastatina','Se emplea para reducir el colesterol y los triglicéridos (tipo de grasa) en la sangre. Descubierta y desarrollada por Merck, se trata del primer medicamento con estatina que evidenció una disminución de la enfermedad cardiovascular y mortalidad.'
,300,'Simvastatina.png'),
('Aspirina','También conocida como ácido acetil-salicílico (ASA), reduce las sustancias en el cuerpo que producen dolor, fiebre e inflamación. Es el medicamento más usado en todo el mundo y se calcula que cada año se consumen unas 40.000 toneladas. A veces incluso se usa como tratamiento o prevención de infartos de miocardio, derrames cerebrales y dolores en el pecho, y también puede ser efectiva en la prevención de ciertos tipos de cáncer, en particular, el cáncer colorectal. '
,100,'Aspirina.png'),
('Omeprazol','Para la acidez de estómago inhibe la bomba de protones (IBPS)y disminuye la producción de ácido al bloquear la enzima de la pared del estómago que se encarga de producir esta sustancia. Este efecto reviene las úlceras y tiene un resultadocu rativo sobre las úlceras existentes en el esófago, estómago y duodeno. La OMS lo incluye como medicamento básico.'
,50,'Omeprazol.png'),
('Lexotiroxina sódica','Se encarga de sustituir una hormona que se suele producir en nuestra glándula tiroidea para regular la energía y el metabolismo del cuerpo. Es una versión artificial de la hormona tiroxina, responsable de aumentar la tasa metabólica de las células de todos los tejidos del organismo y ayuda a mantener la función cerebral, la absorción de los alimentos y la temperatura corporal, entre otros efectos. '
,75,'Lexotiroxina.png'),
('Ramipril','Para la hipertensión, trata la presión arterial alta (hipertensión) o la insuficiencia cardíaca congestiva. También mejora la supervivencia después de un infarto de miocardio y previene la insuficiencia renal por presión alterial alta y diabetes.'
,122,'Ramipril.png'),
('Amlodipina','Para la hipertensión y la angina, es un bloqueador de los canales de calcio. Ensancha los vasos sanguíneos y mejora el flujo de la sangre, por lo que se usa para reducir la presión arterial y tratar la hipertensión. Ralentizan el latido cardíaco y, al bloquear la señal de calcio en las células de la corteza adrenal, disminuyen la presión arterial.'
,34,'Amlodipina.png'),
('Paracetamol','Para aliviar el dolor, es un medicamento ampliamente empleado para reducir la fiebre, aunque a día de hoy aún se desconoce su mecanismo de acción exacto. Se usa para tratar diversas dolencias como fiebres, dolor de cabeza, dolores musculares, artritis, dolor de espalda o resfriados. Aunque es seguro si se siguen las dosis recomendadas, sobredosis pequeñas pueden causar hasta la muerte. El paracetamol es más tóxico en sobredosis que otros medicamentos pero menos cuando su toma se realiza de forma crónica a pequeñas dosis.'
,30,'Paracetamol.png'),
('Atorvastatina','Para controlar el colesterol, disminuye la cantidad de colesterol que fabrica el hígado. Sirve para reducir los niveles de trigliricéridos en sangre y colesterol ''malo'', al tiempo que aumenta los niveles de colesterol bueno. Se suele emplear junto a una dieta saludable para tratar el colesterol y disminuir el riesgo de derrame cerebral o infarto de miocardio.'
,72,'Atorvastatina.png'),
('Salbutamol','Para el asma. Popularmente conocido como Ventolin, se usa como prevención de broncoespasmos en pacientes con asma, bronquitis, enfisema y otras enfermedades del pulmón. Alivia la tos, la falta de aire y la respiración dificultosa al aumentar el flujo de aire que pasa a través de los tubos bronquiales.'
,90,'Salbutamol.png'),
('Lansoprazol','Para controlar el ácido del estómago, se encarga también de disminuir la cantidad de ácido producido en el estómago y se usa para tratar y prevenir las úlceras en este órgano y en el intestino y para controlar el ardor.'
,88,'Lansoprazol.png');

insert into recetas_medicamentos(idRecetas, idMedicamentos) values
(1,1),(1,2),(1,3),(1,4),(2,5),(2,6),(2,7),(2,8);

insert into consultas_media(idConsulta, media) values
(1,'url 1'),(2,'url 2'),(1,'url 3');

insert into carrito(idPacientes, idMedicamentos, cantidad) values
(1,2,10),(1,3,2),(1,1,4);

insert into ventas(idPacientes, total, fecha) values
(1,3000,current_timestamp()),(1,200,current_timestamp());

insert into ventas_medicamentos(idVentas, idMedicamentos, cantidad, total, precio) values
(1,1,10,100,10),(1,2,1,50,50),(1,5,4,400,100);

insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));
insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1));
insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));
insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));
insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1));
insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));
insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));
insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1));
insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));
insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));
insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1));
insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));
insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));insert into pacientes_alergias(idPacientes, idAlergias) values ((select id from pacientes order by rand() limit 1),(select id from alergias order by rand() limit 1));
insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1)); insert into pacientes_cirugias(idPacientes, idCirugias) values ((select id from pacientes order by rand() limit 1),(select id from cirugias order by rand() limit 1));
insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));insert into pacientes_enfermedades(idPacientes, idEnfermedades) values ((select id from pacientes order by rand() limit 1),(select id from enfermedades order by rand() limit 1));

insert into covid(idPaciente, idMedico, estado, fecha) values
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Sospechoso',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Confirmado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Curado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Sospechoso',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Confirmado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Curado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Sospechoso',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Confirmado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Curado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Sospechoso',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Confirmado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Curado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Sospechoso',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Confirmado',current_timestamp()),
((select id from pacientes order by rand() limit 1),(select id from medicos order by rand() limit 1),'Curado',current_timestamp());

insert into medicos_consultas(idMedicos, idConsultas) values
((select id from medicos order by rand() limit 1),(select id from consultas order by rand() limit 1)),
((select id from medicos order by rand() limit 1),(select id from consultas order by rand() limit 1)),
((select id from medicos order by rand() limit 1),(select id from consultas order by rand() limit 1)),
((select id from medicos order by rand() limit 1),(select id from consultas order by rand() limit 1)),
((select id from medicos order by rand() limit 1),(select id from consultas order by rand() limit 1));

insert into medicos_consultas(idMedicos, idConsultas) values (1,1);

select * from covid;

select * from medicamentos;

select c.id, c.idPaciente, c.idMedico, c.estado, c.fecha, concat(p.nombres,' ',p.apellidoPaterno,' ', p.apellidoMaterno) paciente, concat(p.nombres,' ',p.apellidoPaterno,' ', p.apellidoMaterno) medico from covid c join medicos m on m.id = c.idMedico join pacientes p on c.idPaciente = p.id;

select v.id, v.idPacientes, concat(p.nombres,' ',p.apellidoPaterno,' ', p.apellidoMaterno) paciente ,v.fecha, v.total from ventas v join pacientes p on v.idPacientes = p.id