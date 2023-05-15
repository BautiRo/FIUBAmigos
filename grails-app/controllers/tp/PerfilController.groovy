package tp

import grails.plugin.springsecurity.annotation.Secured

class PerfilController {

    /* Inyecto servicio para poder buscar el usuario logueado */
    def springSecurityService

    /* Inyecto Estudiante Service para guardar la edición */
    def estudianteService

    def materiasService

    @Secured(["ROLE_USER"])
    def view() {
        log.error(params.padron)
        if (!params.padron) {
            [estudiante: Estudiante.findById(springSecurityService.currentUser.estudianteId)]
        } else {
            def amigo = Estudiante.findByPadron(params.padron)

            if (usuarioPuedeVerPerfil(amigo)){
                render(view: "perfilAmigo",
                        model: [carrera            : "Ingenieria Informatica",
                                amigo              : amigo,
                                materiasDisponibles:  materiasService.calcularMateriasDisponibles(amigo.codigosDeMateriasAprobadas() as ArrayList<String>)])
            } else {
                [estudiante: Estudiante.findById(springSecurityService.currentUser.estudianteId)] //no podes ver esta pagina
            }
        }
    }

    def usuarioPuedeVerPerfil(Estudiante amigo){
        return Estudiante.findById(springSecurityService.currentUser.estudianteId).esAmigoDe(amigo)
    }

    @Secured(["ROLE_USER"])
    def getEditar() {
        [estudiante: Estudiante.findById(springSecurityService.currentUser.estudianteId)]
    }

    @Secured(["ROLE_USER"])
    def postEditar() {
        def parameters = [name: params.fname, lastname: params.lname, padron: params.padron, email: params.email,
                          orientacion: params.orientacion, mailP: params.mailIn, whatsapp: params.wppIn,
                          instagram: params.igIn, twitter: params.twIn, facebook: params.fbIn,
                          linkedin: params.linkIn, visibilidad: params.visibilidad]
        estudianteService.updateMiPerfil(parameters)
        redirect(action: "view", controller:"perfil")
    }
}
