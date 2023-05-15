package tp
import grails.plugin.springsecurity.annotation.Secured

class SignUpController {
    def usuarioService

    @Secured('permitAll')
    def index() {
        [carrera: "Ingeniería Informática"]
    }

    @Secured("permitAll")
    def crearUsuario() {
        try{
            def mail = Estudiante.findByEmail(params.email)
            def padron = Estudiante.findByPadron(params.padron)
            def userName = Usuario.findByUsername(params.nombreUsuario)

            if (mail) {
                render "Ya existe un usuario con ese mail."
                return
            }
            if (padron) {
                render "Ya existe un usuario con ese padrón."
                return
            }
            if (userName) {
                render "Ya existe un usuario con ese nombre de usuario."
                return
            }
            def resp = usuarioService.crearUsuario(params.nombre, params.apellido,
                    params.email, params.padron, params.nombreUsuario, params.contrasenia)
            render "OK"
        } catch(Throwable ex){
            render ex.getMessage()
        }
    }

    @Secured(["ROLE_USER"])
    def checkIfEmailExists(){
        def estudiante = Estudiante.findByEmail(params.email)

        if (estudiante)
            render "Ya existe un usuario con este mail."
    }
}
