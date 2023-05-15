<!doctype html>
<html class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <asset:javascript src="jquery-3.3.1.min.js" />
        <asset:javascript src="newSelected.js"/>
        <asset:stylesheet src="general.css"/>
        <asset:javascript src="amigos/amigos.js"/>
        <asset:javascript src="materias/materias.js"/>
        <title>FIUBAmigos</title>
    </head>
    <body>
    <div class="container" style="padding-top: 5rem">
        <div class="row">
            <div class="col-3">
                <div class="card" style="margin:auto">
                    <div class="card-header">
                        <h4>Datos Personales</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <label for="fname">Nombre:</label>
                                <input class="form-control form-control-sm" type="text" id="fname" name="fname" style="background-color: white;" readonly="true" value='${estudiante.getNombre()}'>
                                <br/>
                                <label for="lname">Apellido:</label>
                                <input class="form-control form-control-sm" type="text" id="lname" name="lname" style="background-color: white;" readonly="true" value='${estudiante.getApellido()}'>
                                <br/>
                                <label for="orientacion">Orientación:</label>
                                <input class="form-control form-control-sm" type="text" id="orientacion" name="orientacion" style="background-color: white;" readonly="true" value='${estudiante.getOrientacion()}'>
                                <br/>
                                <label for="email">Email:</label>
                                <input class="form-control form-control-sm" type="text" id="email" name="email" style="background-color: white;" readonly="true" value='${estudiante.getEmail()}'>
                                <br/>
                                <label for="padron">Padr&oacute;n:</label>
                                <input class="form-control form-control-sm" type="text" id="padron" name="padron" style="background-color: white;" readonly="true" value='${estudiante.getPadron()}'>
                                <br/>
                                <label for="visibilidad">Visibilidad:</label>
                                <input class="form-control form-control-sm" type="text" id="visibilidad" name="visibilidad" style="background-color: white;" readonly="true" value='${estudiante.getVisibilidad()}'>
                                <br/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Datos Académicos</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <label>Promedio: ${estudiante.getPromedio()}</label>
                                <label># Materias aprobadas: ${estudiante.getCursadasAprobadas().size()}</label>
                                <label># Materias en curso: ${estudiante.getCursadasActuales().size()}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <br/>
                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Datos de Contacto</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                                <g:if test="${estudiante.getDatosDeContacto().getMailPersonal() != ''}">
                                    <div class="row">
                                        <div class="col-1">
                                            <asset:image src="gmail24.png" alt="LinkedIn"/>
                                        </div>

                                        <div class="col">
                                            <input class="form-control form-control-sm" type="email" id="mailIn"
                                                   name="mailIn" placeholder="Mail Personal" style="background-color: white;" readonly="true" value="${estudiante.getDatosDeContacto().getMailPersonal()}">
                                        </div>
                                    </div>
                                </g:if>
                                <g:if test="${estudiante.getDatosDeContacto().getWhatsApp() != ''}">
                                    <div class="row">
                                        <div class="col-1">
                                            <asset:image src="whatsapp24.png" alt="Whatsapp"/>
                                        </div>

                                        <div class="col">
                                            <input class="form-control form-control-sm" type="tel" id="wppIn"
                                                   name="wppIn" placeholder="WhatsApp" style="background-color: white;" readonly="true" value="${estudiante.getDatosDeContacto().getWhatsApp()}">
                                        </div>
                                    </div>
                                </g:if>
                                <g:if test="${estudiante.getDatosDeContacto().getInstagram() != ''}">
                                    <div class="row">
                                        <div class="col-1">
                                            <asset:image src="instagram24.png" alt="LinkedIn"/>
                                        </div>

                                        <div class="col">
                                            <input class="form-control form-control-sm" type="text" id="igIn"
                                                   name="igIn" placeholder="Instagram" style="background-color: white;" readonly="true" value="${estudiante.getDatosDeContacto().getInstagram()}">
                                        </div>
                                    </div>
                                </g:if>
                                <g:if test="${estudiante.getDatosDeContacto().getTwitter() != ''}">
                                    <div class="row">
                                        <div class="col-1">
                                            <asset:image src="twitter24.png" alt="Twitter"/>
                                        </div>
                                        <div class="col">
                                            <input class="form-control form-control-sm" type="text" id="twIn"
                                                   name="twIn" placeholder="Twitter" style="background-color: white;" readonly="true" value="${estudiante.getDatosDeContacto().getTwitter()}">
                                        </div>
                                    </div>
                                </g:if>
                                <g:if test="${estudiante.getDatosDeContacto().getFacebook() != ''}">
                                    <div class="row">
                                        <div class="col-1">
                                            <asset:image src="facebook24.png" alt="Facebook"/>
                                        </div>

                                        <div class="col">
                                            <input class="form-control form-control-sm" type="email" id="fbIn"
                                                   name="fbIn" placeholder="Facebook" style="background-color: white;" readonly="true" value="${estudiante.getDatosDeContacto().getFacebook()}">
                                        </div>
                                    </div>
                                </g:if>
                                <g:if test="${estudiante.getDatosDeContacto().getLinkedIn() != ''}">
                                    <div class="row">
                                        <div class="col-1">
                                            <asset:image src="linkedIn24.png" alt="LinkedIn"/>
                                        </div>

                                        <div class="col">
                                            <input class="form-control form-control-sm" type="email" id="linkIn"
                                                   name="linkIn" placeholder="LinkedIn" style="background-color: white;" readonly="true" value="${estudiante.getDatosDeContacto().getLinkedIn()}">
                                        </div>
                                    </div>
                                </g:if>
                               <g:if test="${estudiante.getDatosDeContacto().getMailPersonal() == '' &&
                                       estudiante.getDatosDeContacto().getWhatsApp() == '' &&
                                       estudiante.getDatosDeContacto().getInstagram() == '' &&
                                       estudiante.getDatosDeContacto().getTwitter() == '' &&
                                       estudiante.getDatosDeContacto().getFacebook() == '' &&
                                       estudiante.getDatosDeContacto().getLinkedIn() == ''}">
                                   <label class="text-danger">No has cargado datos de contacto. </label>
                                   <label class="text-danger">Edita tu perfil para que tus amigos puedan comunicarse!</label>
                               </g:if>
                        </div>
                    </div>
                </div>
                <a class="navbar" href="perfil/editar"><asset:image src="editar32.png" alt="LinkedIn"/></a>
            </div>

            <div class="col-6">
                <div class="card" style="margin: auto; width: 700px">
                    <div class="card-header">
                        <h4>Materias Aprobadas</h4>
                    </div>
                    <div class="table-wrapper-scroll-y my-custom-scrollbar">
                        <table class="table table-striped table-bordered table-sm" cellspacing="0"
                               width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>C&oacute;digo</th>
                                    <th>Materia</th>
                                    <th>Nota</th>
                                    <th>Año</th>
                                    <th>Cuatrimestre</th>
                                    <th>Curso</th>
                                    <th>Cr&eacute;ditos</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each var="cursadaAprobada" in="${estudiante.getCursadasAprobadas()}" status="i">
                                    <tr>
                                        <td>${i+1}</td>
                                        <td>${cursadaAprobada.curso.materia.codigo}</td>
                                        <td>${cursadaAprobada.curso.materia.nombre}</td>
                                        <td>${cursadaAprobada.cursantes.find{it.estudiante == estudiante}.nota}</td>
                                        <td>${cursadaAprobada.anio}</td>
                                        <td>${cursadaAprobada.cuatrimestre}</td>
                                        <td>${cursadaAprobada.curso.codigo}</td>
                                        <td>${cursadaAprobada.curso.materia.creditos}</td>

                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>

                <br/>

                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Materias en curso</h4>
                    </div>
                    <div class="table-wrapper-scroll-y my-custom-scrollbar">
                        <table class="table table-striped table-bordered table-sm" cellspacing="0"
                           width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>C&oacute;digo</th>
                                    <th>Materia</th>
                                    <th>Curso</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each var="cursadaActual" in="${estudiante.getCursadasActuales()}" status="i">
                                    <tr>
                                        <td>${i+1}</td>
                                        <td>${cursadaActual.curso.materia.codigo}</td>
                                        <td>${cursadaActual.curso.materia.nombre}</td>
                                        <td>${cursadaActual.curso.codigo}</td>
                                        <td>
                                            <a onclick="eliminarCursadaActual(${cursadaActual.id})">
                                                <asset:image src="deleteMateria.png" alt="Eliminar"/>
                                            </a>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>

                <br>

                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Amigos</h4>
                    </div>
                    <div class="table-wrapper-scroll-y my-custom-scrollbar">
                        <table class="table table-striped table-bordered table-sm" cellspacing="0"
                               width="100%">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Padr&oacute;n</th>
                                <th></th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                                <g:each var="amigo" in="${estudiante.getAmigos()}" status="i">
                                    <tr>
                                        <td>${i+1}</td>
                                        <td>${amigo.nombre}</td>
                                        <td>${amigo.apellido}</td>
                                        <td>${amigo.padron}</td>
                                        <td>
                                            <a href="perfil/ver/${amigo.padron}">
                                                <asset:image src="finduser24.png" alt="Ver Perfil"/>
                                            </a>
                                        </td>
                                        <td>
                                            <a onclick="eliminarAmigo(${amigo.padron})">
                                                <asset:image src="removeuser24.png" alt="Eliminar"/>
                                            </a>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </body>
</html>