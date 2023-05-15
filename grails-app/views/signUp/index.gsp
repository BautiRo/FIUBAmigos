<!doctype html>
<html class="no-js">
<head>
    <meta name="layout" content="navbar"/>
    <asset:javascript src="jquery-3.3.1.min.js" />
    <asset:javascript src="cargaDeMaterias.js"/>
    <asset:javascript src="signUp/signUp.js"/>
    <title>FIUBAmigos</title>
</head>

<body>
<div class="body">
    <div class="container" style="padding-top: 5rem">
        <div style="padding-left: 7rem">
            <form id="initial-form" action="/signUp/crearUsuario" method="post" >
                <div class="row">
                    <div class="col-7">
                        <div class="title">
                            <h1> ${carrera} </h1>
                        </div>
                        <div class="row">
                            <div class="col-3">
                                <p>Nombre:</p>
                            </div>
                            <div class="col-5">
                                <input type="text" class="form-control" id="nombre" name="nombre" required/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-3">
                                <p>Apellido:</p>
                            </div>

                            <div class="col-5">
                                <input type="text" class="form-control" id="apellido" name="apellido" required/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-3">
                                <p>Email:</p>
                            </div>
                            <div class="col-5">
                                <input type="email" class="form-control" id="email" name="email" required/>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-3">
                                <p>Padr&oacute;n:</p>
                            </div>
                            <div class="col-5">
                                <input type="number" class="form-control" id="padron" name="padron" required/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-3">
                                <p>Usuario:</p>
                            </div>
                            <div class="col-5">
                                <input type="text" class="form-control" id="nombreUsuario" name="nombreUsuario" required/>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-3">
                                <p>Contraseña:</p>
                            </div>
                            <div class="col-5">
                                <input type="password" class="form-control" id="contrasenia" name="contrasenia" required/>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row" style="padding-top: 1rem">
                    <div class="col-5" style="padding-right: 2.5rem">
%{--                        <button class="btn btn-success float-right" id="send-form">Send</button>--}%
                        <button type="button" class="btn btn-success float-right" onclick="crearUsuario()">Send</button>
                    </div>
                </div>
            </form>
        </div>

</div>



</div>
</body>
</html>
