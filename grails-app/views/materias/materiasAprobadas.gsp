<!doctype html>
<html class="no-js">
    <head>
        <meta name="layout" content="main"/>
        <asset:javascript src="cargaDeMaterias.js"/>
        <asset:javascript src="jquery-3.3.1.min.js"/>
        <asset:javascript src="materias/materias.js"/>
        <title>FIUBAmigos</title>
    </head>
    <body>
        <div class="container" style="padding-top: 5rem">
            <div class="body">
                <form id="formMateriasAprobadas" method="post" >
                    <div id="select-subject">
                        <div class="row">
                            <div class="col-4">
                                <b> Seleccione las materias aprobadas:</b>
                            </div>
                            <div class="col-2">
                                <b> Nota en libreta: </b>
                            </div>
                            <div class="col-1">
                                <b> Cuatri: </b>
                            </div>
                            <div class="col-2">
                                <b> Año: </b>
                            </div>
                            <div class="col-2">
                                <b> Curso: </b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                <g:select onchange="getCursos(this)"
                                          class="form-control materia" name="materia-0"
                                          from="${materias}"
                                          noSelection="['':'-Elija una materia-']" data-idx="0"/>
                            </div>
                            <div class="col-2">
                                <g:select class="form-control" name="materia-0" id="nota_materia-0"
                                          from="${4..10}"
                                          noSelection="['':'-Ingrese la nota-']" data-idx="0"/>
                            </div>
                            <div class="col-1">
                                <g:select class="form-control" name="materia-0" id="cuatri-0"
                                          from="${[1,2]}"
                                          noSelection="['':'-']" data-idx="0"/>
                            </div>
                            <div class="col-2">
                                <g:select class="form-control text-sm-left" name="materia-0" id="year-0"
                                          from="${2000..2020}"
                                          noSelection="['':'-']" data-idx="0"/>
                            </div>
                            <div class="col-2">
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
                        <div class="col-11">
                            <button class="btn btn-success float-right" type="button" onclick="agregarMateriasAprobadas()">Send</button>
                        </div>
                    </div>
                </form>
                </div>
                <br/>

                <script type="text/javascript">
                    $( document ).ready(function() {
                        document.getElementById("add-button").addEventListener("click", () => {
                            const lastField = $("#select-subject div:last");
                            const intId = (lastField && lastField.length && lastField.data("idx") + 1) || 1;
                            if($('#materia-' + (intId - 1)).val() && $('#nota_materia-' + (intId - 1)).val()) {
                                //const materias = calltoapicontroller..
                                const materias = JSON.stringify(parseMaterias(($(".materia").serializeArray())))
                                $.ajax({
                                    url:"/materias?tipo=aprobadas",
                                    type: "POST",
                                    contentType: 'application/json; charset=utf-8',
                                    data: materias,
                                    success: function (result){
                                        agregadorDeMaterias(result)
                                    }
                                })
                            }else{
                                alert("Seleccionar materia aprobada antes de agregar una nueva!")
                            }
                        })
                    });
                </script>
            </div>
        </body>
    </body>
</html>
