/* Se llama desde la vista de Inscripción a materias */
function agregarMateriasEnCurso(padron) {
    $.ajax({
        url: `/materiasEnCurso/crear`,
        type: "POST",
        data: $(document.getElementById('initial-form')).serializeArray(),
        dataType: "text",
        success: function(response){
            alert(response)
            window.location = `/perfil`
        }
    })
}

/*
* Se llama desde la vista de home, en cursos recomendados
*/
function agregarMateriaEnCurso(codigoMateria, nombreMateria, codigoCurso) {
    var data = {"materia-0": [codigoMateria + "-" + nombreMateria, codigoCurso + "-" + ""]};
    $.ajax({
        url: `/materiasEnCurso/crear`,
        type: "POST",
        data: data,
        dataType: "text",
        success: function(response){
            alert(response)
            window.location = `/perfil`
        }
    })
}

function agregarMateriasAprobadas() {
    $.ajax({
        url: `/materiasAprobadas/crear`,
        type: "POST",
        data: $(document.getElementById('formMateriasAprobadas')).serializeArray(),
        dataType: "text",
        success: function(response){
            alert(response)
            window.location = `/perfil`
        }
    })
}


function agregadorDeMateriasEnCurso (materias) {
    var lastField = $("#select-subject div:last");
    var intId = (lastField && lastField.length && lastField.data("idx") + 1) || 1;

    var fieldRow = $("<div class=\"row\" style='padding-top: 0.5rem' />");
    var fieldCol = $("<div class=\"col-5\" />");
    var fieldColCurso = $("<div class=\"col-5\" />");

    var fieldWrapper = $("<div class=\"fieldwrapper\" id=\"field" + intId + "\"/>");
    fieldWrapper.data("idx", intId);

    var fName = $("<select onchange=\"getCursos(this)\" class=\"form-control materia\"" + " name=\"materia-" + intId + "\" id=\"materia-" + intId + "\"/>")
    fName.append($("<option value>-Elija una materia-<option\"/>"));
    $(materias).each(function() {
        fName.append($("<option>").attr('value',this).text(this));
    });

    var fCurso = $("<select class=\"form-control\" class=\"materias\"" + " name=\"materia-" + intId + "\" id=\"curso-" + intId + "\"/>")
    fCurso.append($("<option value>-<option\"/>"));

    var removeButton = $("<input type=\"button\" class=\"btn btn-danger\" value=\"X\" />");
    removeButton.click(function() {
        $(this).parent().remove();
    });

    fieldWrapper.append(fCurso)
    removeButton.append(fieldCol)

    fieldCol.append(fName)
    fieldColCurso.append(fieldWrapper)

    fieldRow.append(fieldCol);
    fieldRow.append(fieldColCurso);
    fieldRow.append(removeButton);
    $("#select-subject").append(fieldRow);
}

function ordenarCursosRecomendados(){
    var optionSelected = document.getElementById("selectCursosOrden");
    var criterioElegido = optionSelected.value;

    $.ajax({
        url: `/home/ordenarCursosRecomendados`,
        type: "POST",
        data: {criterioCursosRecomendados: criterioElegido},
        dataType: "text",
        success: function (result){
            const cursos = JSON.parse(result)
            $('#cursos-recomendados').find('tbody').empty();

            for (let i in cursos){
                var myRow =
                    "<tr>" +
                        "<td>" + cursos[i].codigo + "</td>" +
                        "<td>" + cursos[i].materia + "</td>" +
                        "<td>" + cursos[i].creditos + "</td>" +
                        "<td>" + cursos[i].curso + "</td><td>" + cursos[i].amigos + "</td>" +
                        "<td>" + cursos[i].companieros + "</td>" +
                        "<td>" +
                            "<button onclick=\"agregarMateriaEnCurso('" + cursos[i].codigo + "', '" + cursos[i].materia + "', '" + cursos[i].curso + "')\" type=\"button\" class=\"btn\">" +
                            "<img src=\"/assets/inscription24.png\" alt=\"Inscribirme\"/>" +
                            "</button>" +
                        "</td>" +
                    "</tr>";
                $('#cursos-recomendados').find('tbody').append(myRow);
            }
        }
    })
}

function eliminarCursadaActual(idCursadaActual){
    $.ajax({
        url: `/materiasEnCurso/eliminar`,
        type: "POST",
        data: {idCursadaActual: idCursadaActual},
        dataType: "text",
        success: function(response){
            alert(response)
            window.location = `/perfil`
        }
    })
}