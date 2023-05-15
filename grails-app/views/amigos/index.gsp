<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="layout" content="main"/>
    <asset:stylesheet src="general.css"/>
    <asset:javascript src="amigos/amigos.js"/>
    <title>FIUBamigos</title>
</head>
<body>
    <div class="container" style="padding-top: 5rem">
        <div class="row">
            <div class="col-5">
                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Buscador</h4>
                    </div>
                    <div class="card-body">
                        <g:form class="search-form" style="text-align: center; margin-top: 20px">
                            <div class="row">
                                <div class="col-12">
                                    <label class="text-left" for="nombre">Nombre:</label>
                                    <input class="form-control" type="text" id="nombre" name="nombre">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <label for="apellido">Apellido:</label>
                                    <input class="form-control" type="text" id="apellido" name="apellido">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <label for="padron">Padr&oacute;n:</label>
                                    <input class="form-control" type="text" id="padron" name="padron">
                                </div>
                            </div>
                        <br/>
                            <div class="row">
                                <div class="col">
                                    <button class="btn btn-light" style="background-color: white" onclick="buscarEstudiantes()"
                                            type="button" name="submit" value="Buscar">
                                        <asset:image src="searchfriend32.png" alt="Buscar"/>
                                    </button>
                                </div>
                            </div>

                        </g:form>
                    <g:form class="search-form" style="margin-top: 10px">
                        <div class="row">
                                <div class="col-10">
                                    <style>
                                    select:invalid {color: gray;}
                                    </style>
                                    <select class="form-control"  id="selectEstudiante">
                                        <option disabled>-Seleccione un estudiante-</option>
                                    </select>
                                </div>
                                <div class="col-1">
                                    <button onclick="enviarSolicitudAmistad()" type="button" id="send-form" class="btn btn-light" style="background-color: white">
                                        <asset:image src="sendrequest32.png" alt="Enviar"/>
                                    </button>
                                </div>
                        </div>
                    </g:form>
                </div>
            </div>
            </div>

            <div class="col-7">
                <div class="row">
                    <div class="col-12">
                        <div class="card" style="margin: 0 auto; text-align:center;">
                            <div class="card-header">
                                <h4>Solicitudes pendientes</h4>
                            </div>
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Padr&oacute;n</th>
                                    <th>Estado</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                    <g:each var="solicitud" in="${solicitudesPendientes}" status="i">
                                        <tr>
                                            <td style="vertical-align: inherit;">${i+1}</td>
                                            <td style="vertical-align: inherit;">${solicitud.solicitante.nombre}</td>
                                            <td style="vertical-align: inherit;">${solicitud.solicitante.apellido}</td>
                                            <td style="vertical-align: inherit;">${solicitud.solicitante.padron}</td>
                                            <td style="vertical-align: inherit;">${solicitud.estado}</td>
                                            <td>
                                                <button class="btn" type="button" onclick="cambiarEstadoSolicitud('${solicitud.id}', 'aceptado')" title="Aceptar">
                                                    <asset:image style="width: 50%; height: 50%" src="acceptuser48.png" alt="Aceptar"/>
                                                </button>
                                                <button class="btn" type="button" onclick="cambiarEstadoSolicitud('${solicitud.id}', 'rechazado')" title="Rechazar">
                                                    <asset:image style="width: 50%; height: 50%" src="removeuser48.png" alt="Rechazar"/>
                                                </button>
                                            </td>
                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="card" style="margin: 0 auto; text-align:center; margin-top:20px">
                            <div class="card-header">
                                <h4>Solicitudes enviadas</h4>
                            </div>
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Padr&oacute&oacute;n</th>
                                    <th>Estado</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each var="solicitud" in="${solicitudesEnviadas}" status="i">
                                    <tr>
                                        <td>${i+1}</td>
                                        <td>${solicitud.solicitado.nombre}</td>
                                        <td>${solicitud.solicitado.apellido}</td>
                                        <td>${solicitud.solicitado.padron}</td>
                                        <td>${solicitud.estado}</td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>