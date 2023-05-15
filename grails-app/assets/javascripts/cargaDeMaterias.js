function parseMaterias(jsonMaterias) {
    const materias = []
    jsonMaterias.forEach((item) => {
        materias.push(item.value.split('-')[0])
    })
    return materias
}


function getCursos(selectedOption) {
    const id = selectedOption.id
    const idCurso = id.replace('materia', 'curso')
    const codigoMateria = selectedOption.value.split('-')[0]
    $.ajax({
        url: `/cursos?materia=${codigoMateria}`,
        type: "GET",
        contentType: 'application/json; charset=utf-8',
        success: function (result){
            const curso = $("#" + idCurso)
            curso.find('option').remove()
            let i
            for (i in result){
                curso.append($('<option></option>').val(result[i]).html(result[i]))
            }
        }
    })
}


function agregadorDeMaterias (materias) {
    var lastField = $("#select-subject div:last");
    var intId = (lastField && lastField.length && lastField.data("idx") + 1) || 1;

    var fieldRow = $("<div class=\"row\" style='padding-top: 0.5rem' />");
    var fieldCol = $("<div class=\"col-4\" />");
    var fieldColNota = $("<div class=\"col-2\" />");
    var fieldColCuatri = $("<div class=\"col-1\" />");
    var fieldColYear = $("<div class=\"col-2\" />");
    var fieldColCurso = $("<div class=\"col-2\" />");
    // var fieldWrapper = $("<div class=\"materias\" id=\"materia-" + intId + "\"/>");

    var fieldWrapper = $("<div class=\"fieldwrapper\"  id=\"field" + intId + "\"/>");
    fieldWrapper.data("idx", intId);

    var fName = $("<select onchange=\"getCursos(this)\" class=\"form-control materia\"" + " name=\"materia-" + intId + "\" id=\"materia-" + intId + "\"/>")
    fName.append($("<option value>-Elija una materia-<option\"/>"));
    $(materias).each(function() {
        fName.append($("<option>").attr('value',this).text(this));
    });

    var fNota = $("<select class=\"form-control\" class=\"materias\"" + " name=\"materia-" + intId + "\" id=\"nota_materia-" + intId + "\"/>")
    fNota.append($("<option value>-Ingrese la nota-<option\"/>"));
    for (i=4;i<=10;i++){
        fNota.append($('<option></option>').val(i).html(i))
    }

    var fCuatri = $("<select class=\"form-control\" class=\"materias\"" + " name=\"materia-" + intId + "\" id=\"cuatri-" + intId + "\"/>")
    fCuatri.append($("<option value>-<option\"/>"));
    for (i=1;i<=2;i++){
        fCuatri.append($('<option></option>').val(i).html(i))
    }

    var fYear = $("<select class=\"form-control\" class=\"materias\"" + " name=\"materia-" + intId + "\" id=\"year-" + intId + "\"/>")
    fYear.append($("<option value>-<option\"/>"));
    for (i=2000;i<=2020;i++){
        fYear.append($('<option></option>').val(i).html(i))
    }

    var fCurso = $("<select class=\"form-control\" class=\"materias\"" + " name=\"materia-" + intId + "\" id=\"curso-" + intId + "\"/>")
    fCurso.append($("<option value>-<option\"/>"));


    var removeButton = $("<input type=\"button\" class=\"btn btn-danger\" value=\"X\" />");
    removeButton.click(function() {
        $(this).parent().remove();
    });


    //fieldWrapper.append(fNota)
    fieldWrapper.append(fCurso)
    removeButton.append(fieldCol)

    fieldCol.append(fName)
    //fieldColNota.append(fieldWrapper)
    fieldColNota.append(fNota)
    fieldColCuatri.append(fCuatri)
    //fieldColYear.append(fYear)
    fieldColYear.append(fYear)
    fieldColCurso.append(fieldWrapper)

    fieldRow.append(fieldCol);
    fieldRow.append(fieldColNota);
    fieldRow.append(fieldColCuatri);
    fieldRow.append(fieldColYear);
    fieldRow.append(fieldColCurso);
    fieldRow.append(removeButton);
    $("#select-subject").append(fieldRow);
}