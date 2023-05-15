package tp

import grails.gorm.transactions.Transactional

@Transactional
class UsuarioService {
    def mongo
    def estudianteService

    def crearUsuario(String nombre, String apellido, String email, String padron,
                     String nombreUsuario, String contrasenia){


        def rolUsuario = new Rol(authority: 'ROLE_USER')

        /* Creo usuario */
        def usuario = new Usuario(username: nombreUsuario, password: contrasenia, email: email,
                authorities: [rolUsuario])

        /* Creo estudiante */
        usuario.estudianteId = estudianteService.crearEstudiante(nombre, apellido, padron, email)

        usuario.save(flush: true, failOnError: true)
    }
}
