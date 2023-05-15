function crearUsuario(){
    var nombre = document.getElementById("nombre").value;
    var apellido = document.getElementById("apellido").value;
    var email = document.getElementById("email").value;
    var padron = document.getElementById("padron").value;
    var nombreUsuario = document.getElementById("nombreUsuario").value;
    var contrasenia = document.getElementById("contrasenia").value;


    $.ajax({
        url: `/signUp/crearUsuario`,
        type: "GET",
        data: {nombre: nombre, apellido: apellido, email: email, padron: padron, nombreUsuario: nombreUsuario, contrasenia: contrasenia},
        dataType: "text",
        success: function (response){
            if (response == "OK"){
                window.location = '/perfil'
            }
            else{
                alert(response)
            }
        }
    })
}