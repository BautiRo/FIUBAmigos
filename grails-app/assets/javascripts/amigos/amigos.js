function buscarEstudiantes() {
    $.ajax({
        url: "/amigos/buscar",
        type: "GET",
        data: $(".search-form").serialize(),
        success: function (result){
            var select = document.getElementById("selectEstudiante");

            // Vacio las opciones que ya había
            select.textContent = '';

            if(result.length == 0){
                var opt = "-No se encontró ningún estudiante-";
                var el = document.createElement("option");
                el.textContent = opt;
                el.value = opt;
                el.disabled = true;
                // el.selected = true;
                select.appendChild(el);
            }

            for(var i = 0; i < result.length; i++) {
                var opt = result[i].apellido + ", " + result[i].nombre + "   #" + result[i].padron;
                var el = document.createElement("option");
                el.textContent = opt;
                el.value = opt;
                select.appendChild(el);
            }
        }
    })
}

function enviarSolicitudAmistad() {
    var optionSelected = document.getElementById("selectEstudiante");
    var estudiante = optionSelected.value;

    // Si el usuario quiere enviar la opción default
    if (estudiante.toString().includes("Seleccioná un estudiante")){
        alert("Selecciona una opción válida.")
        location.reload()
        return
    }

    $.ajax({
        url: `/amigos/enviarSolicitudAmistad`,
        type: "POST",
        data: estudiante,
        dataType: 'text',
        success: function(response){
            alert(response)
            location.reload()
        },
    })
}

function eliminarAmigo(padron){
    $.ajax({
        url: `/amigos/eliminarAmigo`,
        type: "POST",
        data: {padron: padron},
        dataType: 'text',
        success: function(response){
            alert(response)
            location.reload()
        },
    })
}

function enviarSolicitud(selectedEstudiante) {
    var estudiante = selectedEstudiante;

    $.ajax({
        url: `/amigos/enviarSolicitudAmistad`,
        type: "POST",
        data: estudiante,
        dataType: 'text',
        success: function(response){
            alert(response)
            location.reload()
        },
    })
}

function cambiarEstadoSolicitud(idSolicitud, estado) {
    $.ajax({
        url: `/amigos/cambiarEstadoSolicitud`,
        type: "GET",
        data: {id: idSolicitud, estado: estado},
        dataType: "text",
        success: function(response){
            alert(response)
            location.reload()
        }
    })
}

function ordenarAmigosRecomendados(){
    var optionSelected = document.getElementById("selectAmigosOrden");
    var criterioElegido = optionSelected.value;

    $.ajax({
        url: `/home/ordenarAmigosRecomendados`,
        type: "POST",
        data: {criterioAmigosRecomendados: criterioElegido},
        dataType: "text",
        success: function (result){
            const compas = JSON.parse(result)
            $('#compas-recomendados').find('tbody').empty();

            for (let i in compas){
                var myRow =
                    "<tr>" +
                        "<td>" + compas[i].nombre + " " + compas[i].apellido + "</td>" +
                        "<td>" + compas[i].promedio + "</td>" +
                        "<td>" + compas[i].cursadas + "</td>" +
                        "<td>" + compas[i].amigosEnComun + "</td>" +
                        "<td>\n" +
                            "<button onclick=\"enviarSolicitud('" + compas[i].apellido + ", " + compas[i].nombre + " #" + compas[i].padron + "' )\" type=\"button\" id=\"send-form\" class=\"btn\">\n" +
                                "<img src=\"/assets/sendrequest24.png\" alt=\"Enviar\"/>\n" +
                            "</button>\n" +
                        "</td>" +
                    "</tr>";
                $('#compas-recomendados').find('tbody').append(myRow);
            }
        }
    })
}

function ordenarCompasActuales(){
    var optionSelected = document.getElementById("selectCompasOrden");
    var criterioElegido = optionSelected.value;

    $.ajax({
        url: `/home/ordenarCompasActuales`,
        type: "POST",
        data: {criterioCompasActuales: criterioElegido},
        dataType: "text",
        success: function (result){
            const compas = JSON.parse(result)
            $('#compas-actuales').find('tbody').empty();

            for (let i in compas){
                var myRow =
                    "<tr>" +
                        "<td>" + compas[i].nombre + " " + compas[i].apellido + "</td>" +
                        "<td>" + compas[i].promedio + "</td>" +
                        "<td>" + compas[i].cursadas + "</td>" +
                        "<td>" + compas[i].amigosEnComun + "</td>";

                if (!compas[i].amigo){
                    myRow +=
                        "<td>" +
                            "<button onclick=\"enviarSolicitud('" + compas[i].apellido + ", " + compas[i].nombre + " #" + compas[i].padron + "' )\" type=\"button\" id=\"send-form\" class=\"btn\">\n" +
                                "<img src=\"/assets/sendrequest24.png\" alt=\"Enviar\"/>" +
                            "</button>" +
                        "</td>"
                }

                myRow += "</tr>";

                $('#compas-actuales').find('tbody').append(myRow);
            }
        }
    })
}
