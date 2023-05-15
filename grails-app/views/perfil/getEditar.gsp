<!doctype html>
<html class="no-js">
<head>
    <meta name="layout" content="main"/>
    <asset:javascript src="jquery-3.3.1.min.js"/>
    <asset:javascript src="newSelected.js"/>
    <asset:stylesheet src="general.css"/>

    <title>FIUBAmigos</title>
</head>

<body>
<div class="container-fluid" style="padding-top: 50px">
    <g:form action="editar">
        <div class="row">
            <div class="col-6">
                <div class="card" style="margin:auto">
                    <div class="card-header">
                        <h4>Datos Personales</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                    <label for="fname">Nombre:</label>
                                    <input class="form-control form-control-sm" type="text" id="fname" name="fname"
                                           value='${estudiante.getNombre()}'>
                                    <br/>
                                    <label for="lname">Apellido:</label>
                                    <input class="form-control form-control-sm" type="text" id="lname" name="lname"
                                           value='${estudiante.getApellido()}'>
                                    <br/>
                                    <label for="orientacion">Orientación:</label>
                                    <g:select class="form-control form-control-sm" name="orientacion" id="orientacion"
                                              from="${['None', 'Gestión Industrial de Sistemas', 'Sistemas Distribuidos', 'Sistemas de Producción']}"
                                              value="${estudiante.getOrientacion()}"/>
                                    <br/>
                                    <label for="padron">Padr&oacute;n:</label>
                                    <input class="form-control form-control-sm" type="number" id="padron" name="padron"
                                           value='${estudiante.getPadron()}'>
                                    <br/>
                                    <label for="visibilidad">Visibilidad:</label>
                                    <g:select class="form-control form-control-sm" name="visibilidad" id="visibilidad"
                                              from="${['Privado', 'Público']}"
                                              value="${estudiante.getVisibilidad()}"/>
                                    <br/>
                                    <label for="email">Email:</label>
                                    <input class="form-control form-control-sm" type="text" id="email" name="email"
                                           value='${estudiante.getEmail()}'>
                                    <br/>
                            </div>
                        </div>
                    </div>
                </div>
                <g:submitButton class="btn-outline-primary" name="submit" value="Confirmar cambios"/>
            </div>
            <div class="col-6">
                <div class="card" style="margin: auto">
                    <div class="card-header">
                        <h4>Datos de Contacto</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="gmail24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="email" id="mailIn"
                                               name="mailIn" placeholder="Mail Personal" value="${estudiante.getDatosDeContacto().getMailPersonal()}">
                                    </div>
                                </div>
                                <br/>
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="whatsapp24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="tel" id="wppIn"
                                               name="wppIn" placeholder="WhatsApp" value="${estudiante.getDatosDeContacto().getWhatsApp()}">
                                    </div>
                                </div>
                                <br/>
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="instagram24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="text" id="igIn"
                                               name="igIn" placeholder="Instagram" value="${estudiante.getDatosDeContacto().getInstagram()}">
                                    </div>
                                </div>
                                <br/>
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="twitter24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="text" id="twIn"
                                               name="twIn" placeholder="Twitter" value="${estudiante.getDatosDeContacto().getTwitter()}">
                                    </div>
                                </div>
                                <br/>
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="facebook24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="text" id="fbIn"
                                               name="fbIn" placeholder="Facebook" value="${estudiante.getDatosDeContacto().getFacebook()}">
                                    </div>
                                </div>
                                <br/>
                                <div class="row">
                                    <div class="col-1">
                                        <asset:image src="linkedIn24.png" alt="LinkedIn"/>
                                    </div>

                                    <div class="col">
                                        <input class="form-control form-control-sm" type="text" id="linkIn"
                                               name="linkIn" placeholder="LinkedIn" value="${estudiante.getDatosDeContacto().getLinkedIn()}">
                                    </div>
                                </div>
                                <br/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div clas="row">
            <div class="col-6">

            </div>
        </div>

    </g:form>
</div>
</body>
</html>