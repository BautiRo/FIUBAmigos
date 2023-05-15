<!doctype html>
<html class="no-js">
<head>
    <meta name="layout" content="main"/>
    <asset:javascript src="jquery-3.3.1.min.js" />
    <asset:javascript src="newSelected.js"/>
    <asset:stylesheet src="general.css"/>

    <title>FIUBAmigos</title>
</head>
<body>
<div class="container" style="padding-top: 5rem">
    <div class="row">
        <div class="col">
            <br/>
            <h4>${amigo.getApellido()} ${amigo.getNombre()}, ${amigo.getPadron()}</h4>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <h1>${carrera}</h1>
            <g:if test="${amigo.getOrientacion() != 'None'}">
                <h1>, ${amigo.getOrientacion()}</h1>
            </g:if>
        </div>
       <br/>
    </div>
    <div class="row">
        <div class="col-lg-3">
            <div class="card" style="margin: auto">
                <div class="card-header">
                    <h4>Datos Académicos</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <label>Promedio: ${amigo.getPromedio()}</label>
                            <br/>
                            <label># Materias aprobadas: ${amigo.getCursadasAprobadas().size()}</label>
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
                        <div class="col-12">
                            <g:if test="${amigo.getDatosDeContacto().getMailPersonal() != ''}">
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="gmail24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="email" id="mailIn"
                                               name="mailIn" placeholder="Mail Personal" style="background-color: white;" readonly="true" value="${amigo.getDatosDeContacto().getMailPersonal()}">
                                    </div>
                                </div>
                            </g:if>
                            <g:if test="${amigo.getDatosDeContacto().getWhatsApp() != ''}">
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="whatsapp24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="tel" id="wppIn"
                                               name="wppIn" placeholder="WhatsApp" style="background-color: white;" readonly="true" value="${amigo.getDatosDeContacto().getWhatsApp()}">
                                    </div>
                                </div>
                            </g:if>
                            <g:if test="${amigo.getDatosDeContacto().getInstagram() != ''}">
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="instagram24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="text" id="igIn"
                                               name="igIn" placeholder="Instagram" style="background-color: white;" readonly="true" value="${amigo.getDatosDeContacto().getInstagram()}">
                                    </div>
                                </div>
                            </g:if>
                            <g:if test="${amigo.getDatosDeContacto().getTwitter() != ''}">
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="twitter24.png" alt="Twitter"/>
                                    </div>
                                    <div class="col">
                                        <input class="form-control form-control-sm" type="text" id="twIn"
                                               name="twIn" placeholder="Twitter" style="background-color: white;" readonly="true" value="${amigo.getDatosDeContacto().getTwitter()}">
                                    </div>
                                </div>
                            </g:if>
                            <g:if test="${amigo.getDatosDeContacto().getFacebook() != ''}">
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="facebook24.png" alt="Facebook"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="email" id="fbIn"
                                               name="fbIn" placeholder="Facebook" style="background-color: white;" readonly="true" value="${amigo.getDatosDeContacto().getFacebook()}">
                                    </div>
                                </div>
                            </g:if>
                            <g:if test="${amigo.getDatosDeContacto().getLinkedIn() != ''}">
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="linkedIn24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="email" id="linkIn"
                                               name="linkIn" placeholder="LinkedIn" style="background-color: white;" readonly="true" value="${amigo.getDatosDeContacto().getLinkedIn()}">
                                    </div>
                                </div>
                            </g:if>
                            <g:if test="${amigo.getDatosDeContacto().getMailPersonal() == '' &&
                                    amigo.getDatosDeContacto().getWhatsApp() == '' &&
                                    amigo.getDatosDeContacto().getInstagram() == '' &&
                                    amigo.getDatosDeContacto().getTwitter() == '' &&
                                    amigo.getDatosDeContacto().getFacebook() == '' &&
                                    amigo.getDatosDeContacto().getLinkedIn() == ''}">
                                <label class="text-center">El usuario aún no ha cargado datos de contacto. </label>
                            </g:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="card" style="margin: auto">
                <div class="card-header">
                    <h4>Materias inscripto</h4>
                </div>
                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                    <table class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>C&oacute;digo</th>
                                <th>Materia</th>
                                <th>Curso</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each var="materiaEnCurso" in="${amigo.getMateriasEnCurso()}" status="i">
                                <tr>
                                    <td>${i+1}</td>
                                    <td>${materiaEnCurso.codigo}</td>
                                    <td>${materiaEnCurso.nombre}</td>
                                    <td>${materiaEnCurso.codigo}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card" style="margin: auto; max-height: 500px">
                <div class="card-header">
                    <h4>Materias disponibles</h4>
                </div>
                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                    <table class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Código</th>
                                <th>Materia</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each var="materiaDisponible" in="${materiasDisponibles}" status="i">
                                <tr>
                                    <td>${i+1}</td>
                                    <td>${materiaDisponible.codigo}</td>
                                    <td>${materiaDisponible.nombre}</td>
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