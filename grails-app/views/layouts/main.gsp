<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.png" type="image/x-ico"/>

    <asset:stylesheet src="mobster/maicons.css"/>
    <asset:stylesheet src="mobster/animate.css"/>
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="navbar.css"/>
    <asset:stylesheet src="mobster/owl.carousel.min.css"/>

    <g:layoutHead/>
</head>

<body>


<nav class="navbar navbar-expand-lg navbar-dark navbar-floating">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="../assets/faicon.png" alt="" width="200">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggler" aria-controls="navbarToggler" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarToggler">

            <ul class="navbar-nav ml-lg-5 mt-3 mt-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="/home/index">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/amigos/index">Amigos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/materiasEnCurso">Inscripci&oacute;n a materias</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/materiasAprobadas">Materias aprobadas</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/perfil">Mi perfil</a>
                </li>
                <li class="nav-item">
                    <g:link class="nav-link" controller='logout'>Cerrar Sesi&oacute;n</g:link>
                </li>
            </ul>
        </div>
    </div>
</div>
</nav>

<g:layoutBody/>

<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<asset:javascript src="application.js"/>

</body>
</html>
