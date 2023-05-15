<!doctype html>
<html class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <asset:javascript src="jquery-3.3.1.min.js" />
        <asset:javascript src="newSelected.js"/>

        <title>FIUBAmigos</title>
    </head>
        
    <body>
    <div class="container-fluid">
        <div class="row">
            <div class="card">
                <div class="card-header">
                    <h4>Datos Personales</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <label>Nombre:${nombre}</label>
                            <%--<input type="text" id="fname" name="fname" Text='${nombre}'>--%>
                            <br/>
                            <label>Apellido: ${apellido}</label>
                            <br/>
                            <label>Padron: ${padron}</label>
                            <br/>
                            <label>Mail: ${mail}</label>
                        </div>
                    </div>
                </div>
            </div>
            <div></div>
            <div class="card">
                <div class="card-header">
                    <h4>Datos Académicos</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg">
                            <label>Materias aprobadas: 20</label>
                            <br/>
                            <label>Promedio: 7.50</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="row">
            <div class="card">
                <div class="card-header">
                    <h4>${carrera}</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md">
                            <div id="datosPersonalesDiv">
                                <h1>Datos Personales</h1>
                                <div class="col-6">
                                    <label>Nombre: ${nombre}</label>
                                    <label>Apellido: ${apellido}</label>
                                    <label>Padrón: ${padron}</label>
                                    <label>Mail: ${mail}</label>
                                </div>                    
                            </div>
                        </div>
                        <div class="col-md">
                            <div id="datosAcademicos">
                                <h1>Datos Académicos</h1>
                                    <div class="col-5">                        
                                    <label>Materias aprobadas: 20</label>
                                    <label>Promedio: 7.50</label>                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> --%>
    </div>    
<%--       <div class="title">--}%
%{--           <h4> ${carrera} </h4>--}%
%{--        </div>--}%
%{--        <div class="menu">--}%
%{--        </div>--}%
%{--        <div class="row">--}%
%{--            <div class="col-md">--}%
%{--                <div id="datosPersonalesDiv">--}%
%{--                    <h1>Datos Personales</h1>--}%
%{--                    <div class="col-6">--}%
%{--                        <label>Nombre: ${nombre}</label>--}%
%{--                        <label>Apellido: ${apellido}</label>--}%
%{--                        <label>Padrón: ${padron}</label>--}%
%{--                        <label>Mail: ${mail}</label>--}%
%{--                    </div>--}%       
%{--                </div>--}%
%{--            </div>--}%
%{--            <div class="col-md">--}%
%{--                <div id="datosAcademicos">--}%
%{--                    <h1>Datos Académicos</h1>--}%
%{--                    <div class="col-5">--}%             
%{--                        <label>Materias aprobadas: 20</label>--}%
%{--                        <label>Promedio: 7.50</label>--}%          
%{--                    </div>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </div>--}%
%{--            <br/>--}%
%{--            <div></div>--}%
%{--            <div></div>--}%
%{--            <div></div>--}%
%{--        </div>--}% --%>
    </body>
</html>
