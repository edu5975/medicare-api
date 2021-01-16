# proyecto-tweb


Rutas para las alergias
<ul>
  <li>/alergias (get, post)</li>
  <li>/alergias/:id (get, put, delete)</li>
</ul>

Rutas para las enfermedades
<ul>
  <li>/enfermedades (get, post)</li>
  <li>/enfermedades/:id (get, put, delete)</li>
</ul>

Rutas para las especialidades
<ul>
  <li>/especialidades (get, post)</li>
  <li>/especialidades/:id (get, put, delete)</li>
</ul>

Rutas para las cirugias
<ul>
  <li>/cirugias (get, post)</li>
  <li>/cirugias/:id (get, put, delete)</li>
</ul>

Rutas para los pacientes
<ul>
  <li>/pacientes (get, post)</li>
  <li>/pacientes/:id (get, put, delete)</li>
</ul>

Rutas para pacientes_enfermedades
<ul>
  <li>/pacientes/:id/enfermedades (get)</li>
  <li>/pacientes/:idPacientes/enfermedades/:idEnfermedades (get, delete)</li>
</ul>

Rutas para pacientes_alergias
<ul>
  <li>/pacientes/:id/alergias (get)</li>
  <li>/pacientes/:idPacientes/alergias/:idAlergias (get, delete)</li>
</ul>

Rutas para pacientes_cirugias
<ul>
  <li>/pacientes/:id/cirugias (get)</li>
  <li>/pacientes/:idPacientes/cirugias/:idCirugias (get, delete)</li>
</ul>

Rutas para los servicios
<ul>
  <li>/servicios (get, post)</li>
  <li>/servicios/:id (get, put, delete)</li>
</ul>

Rutas para los medicos
<ul>
  <li>/medicos (get, post)</li>
  <li>/medicos/:id (get, put, delete)</li>
</ul>

Rutas para servicios_medicos
<ul>
  <li>/medicos/:id/servicios (get)</li>
  <li>/medicos/:idMedicos/servicios/:idServicios (get, post, put, delete)</li>
</ul>

Rutas para consultas
<ul>
  <li>/consultas (get, post)</li>
  <li>/consultas/:id (get, put, delete)</li>
  <li>/pacientes/:idPacientes/consultas (get)</li>
  <li>/pacientes/:idPacientes/consultas/:idConsultas (get)</li>
</ul>

Rutas para covid
<ul>
  <li>/covid (get, post)</li>
  <li>/covid/:id (get, delete)</li>
  <li>/pacientes/:id/covid (get)</li>
  <li>/medicos/:id/covid (get)</li>
</ul>

Rutas para recetas
<ul>
  <li>/recetas (get)</li>
  <li>/recetas/:id (get, delete)</li>
</ul>

Rutas para acceso
<ul>
  <li>/login (post)</li>
  <li>/logout (post)</li>
</ul>

Rutas para los medicamentos
<ul>
  <li>/medicamentos (get, post)</li>
  <li>/medicamentos/:id (get, put, delete)</li>
</ul>

Rutas para recetas_medicamentos
<ul>
  <li>/recetas/:id/medicamentos (get)</li>
  <li>/recetas/:idRecetas/medicamentos/:idMedicamentos (get, post, delete)</li>
</ul>

Rutas para consultas_media
<ul>
  <li>/consultas/:id/media (get,post)</li>
  <li>/consultas/:idConsulta/media/:idMedia (get, delete)</li>
</ul>

Rutas para carrito
<ul>
  <li>/carrito (post)</li>
  <li>/carrito/:idPacientes (get, delete)</li>
  <li>/carrito/:idPacientes/medicamentos/idMedicamentos (get, post, put, delete) </li>
</ul>

Rutas para ventas
<ul>
  <li>/ventas (post)</li>
  <li>/ventas/:idVenta (get, put, delete)</li>
  <li>/pacientes/:idPacientes/compras (get)</li>
</ul>

Rutas para ventas_medicamentos
<ul>
  <li>/ventas/:idVentas/medicamentos (get)</li>
  <li>/ventas/:idVentas/medicamentos/:idMedicamentos (get, post, delete)</li>
</ul>

Ruta para email
<ul>
  <li>/email (post)</li>
</ul>

Ruta para imagenes
<ul>
  <li>/images (post)</li>
  <li>/images/:nombre (get)</li>
</ul>