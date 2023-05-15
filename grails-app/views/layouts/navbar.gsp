<%--
  Created by IntelliJ IDEA.
  User: Nachops
  Date: 3/2/2021
  Time: 12:47 AM
--%>

<html>
<head>
    %{--    <meta name="layout" content="${gspLayout ?: 'main'}"/>--}%
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
                        <a class="nav-link" href="/login/auth">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="updates.html">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/#contactanos">Contactanos</a>
                    </li>
                </ul>
                <div class="ml-auto my-2 my-lg-0">
                    <a href="/signUp/index" class="btn btn-dark rounded-pill">Registrate ahora!</a>
                </div>
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