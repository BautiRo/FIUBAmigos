<html>
<head>
    <meta name="layout" content="navbar"/>
    <asset:stylesheet src="mobster/maicons.css"/>
    <asset:stylesheet src="mobster/animate.css"/>
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="navbar.css"/>
    <asset:stylesheet src="mobster/owl.carousel.min.css"/>
    <title><g:message code='springSecurity.login.title'/></title>
    <style type="text/css" media="screen">
    .login-page {
        width: 360px;
        padding: 8% 0 0;
        margin: auto;
    }
    .form {
        border: solid 2px #50e54b!important;
        position: relative;
        z-index: 1;
        background: #FFFFFF;
        max-width: 360px;
        margin: 0 auto 100px;
        padding: 45px;
        text-align: center;
        box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
    }
    .form input {
        font-family: "Roboto", sans-serif;
        outline: 0;
        background: #f2f2f2;
        width: 100%;
        border: 0;
        margin: 0 0 15px;
        padding: 15px;
        box-sizing: border-box;
        font-size: 14px;
    }
    .form button {
        font-family: "Roboto", sans-serif;
        text-transform: uppercase;
        outline: 0;
        background: #4CAF50;
        width: 100%;
        border: 0;
        padding: 15px;
        color: #FFFFFF;
        font-size: 14px;
        -webkit-transition: all 0.3 ease;
        transition: all 0.3 ease;
        cursor: pointer;
    }
    .form button:hover,.form button:active,.form button:focus {
        background: #43A047;
    }
    .form .message {
        margin: 15px 0 0;
        color: #b3b3b3;
        font-size: 12px;
    }
    .form .message a {
        color: #4CAF50;
        text-decoration: none;
    }
    .form .register-form {
        display: none;
    }
    .container-login {
        position: relative;
        z-index: 1;
        max-width: 300px;
        margin: 0 auto;
    }
    .container-login:before, .container:after {
        content: "";
        display: block;
        clear: both;
    }
    .container-login .info {
        margin: 50px auto;
        text-align: center;
        background-color: #2e6da4;
    }
    .container-login .info h1 {
        margin: 0 0 15px;
        padding: 0;
        font-size: 36px;
        font-weight: 300;
        color: #1a1a1a;
    }
    .container-login .info span {
        color: #4d4d4d;
        font-size: 12px;
    }
    .container-login .info span a {
        color: #000000;
        text-decoration: none;
    }
    .container-login .info span .fa {
        color: #EF3B3A;
    }
    </style>
</head>

<body>

<div class="row" style="padding-top: 10rem ">
    <div class="container-login">
        <div id="login-page">
            <div class="inner card-body" style="background-color: #585858; border-radius: 25px;">
                <div class="fheader" style="text-align:center; padding-bottom: 2rem; color: white;">
                    FIUBAMIGOS - Bienvenido
                </div>

                <g:if test='${flash.message}'>
                    <div class="login_message" style="color: white;">${flash.message}</div>
                </g:if>
                
                <form class="login-form" action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="cssform" autocomplete="off">
                    <p>
                        <label for="username" style="color: white;"><g:message code='springSecurity.login.username.label'/>:</label>
                        <input type="text" class="text_" name="${usernameParameter ?: 'username'}" id="username"/>
                    </p>

                    <p>
                        <label for="password" style="color: white;"><g:message code='springSecurity.login.password.label'/>:</label>
                        <input type="password" class="text_" name="${passwordParameter ?: 'password'}" id="password"/>
                    </p>
                    <div class="vertical-center">
                        <button class="btn btn-success float-right"> ${message(code: 'springSecurity.login.button')}</button>
                    </div>
                    <p class="message" style="color: white;">Not registered? <a href="/signUp/index">Create an account</a></p>
            </div>
        </div>
    </div>
</div>

<script>
    (function() {
        document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
    })();
</script>
</body>
</html>