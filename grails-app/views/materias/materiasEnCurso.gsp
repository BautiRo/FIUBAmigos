<!doctype html>
<html class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <asset:javascript src="jquery-3.3.1.min.js" />
        <asset:javascript src="cargaDeMaterias.js"/>
        <asset:javascript src="materias/materias.js"/>
        <title>FIUBAmigos</title>
    </head>
    <body>
        <div class="container" style="padding-top: 5rem">
            <div class="body">
                <form id="initial-form" action="/materiasEnCurso/crear" method="post" >
                    <div id="select-subject">
                        <div class="row">
                            <div class="col-5">
                                <b> Seleccione las materias que se encuentra cursando:</b>
                            </div>
                            <div class="col-2">
                                <b> Curso </b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-5">
                                <g:select onchange="getCursos(this)"
                                          class="form-control materia" name="materia-0"
                                          from="${materias}"
                                          noSelection="['':'-Elija una materia-']" data-idx="0"/>
                            </div>
                            <div class="col-5">
                                <g:select class="form-control text-sm-left" name="materia-0" id="curso-0"
                                          from=""
                                          noSelection="['':'-']" data-idx="0"/>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding-top: 0.5rem">
                        <div class="col-10">
                            <button type="button" class="btn btn-dark" id="add-button"> Agregar Materia </button>
                        </div>
                        <div class="col-10">
                            <button class="btn btn-success float-right" onclick="agregarMateriasEnCurso(${sec.loggedInUserInfo(field: 'id')})" type="button" id="send-form">Send</button>
                        </div>
                    </div>
                </form>
                </div>
                <br/>

                <script type="text/javascript">
                    $( document ).ready(function() {
                        document.getElementById("add-button").addEventListener("click", () => {
                            const materias = JSON.stringify(parseMaterias(($(".materia").serializeArray())))
                            $.ajax({
                                url:"/materias?tipo=cursables",
                                type: "POST",
                                data: materias,
                                contentType: 'application/json; charset=utf-8',
                                success: function (result){
                                    agregadorDeMateriasEnCurso(result)
                                }
                            })
                        })
                    });
                </script>
            </div>
        </div>
    </body>
</html>
