package tp

import excepciones.UsuarioNoPuedeEnviarSolicitudExcepcion
import grails.plugin.springsecurity.annotation.Secured

class AmigosController {
    def estudianteService
    def amigosService
    def materiasService
    def springSecurityService

    static allowedMethods = [aceptarSolicitud: 'GET']

    @Secured(["ROLE_USER"])
    def index() {
        [solicitudesPendientes: amigosService.getSolicitudesPendientes(),
         solicitudesEnviadas  : amigosService.getSolicitudesEnviadas()]
    }

    @Secured(['ROLE_USER'])
    def buscar() {
        def estudiantes = estudianteService.buscarEstudiantes(
                params.nombre,
                params.apellido,
                params.padron)

        // Remuevo de la lista de posibles futuros amigos al usuario que esta logueado
        estudiantes.removeAll { it.email.equals(springSecurityService.currentUser.email) }

        respond estudiantes, formats: ['json']
    }

    @Secured(["ROLE_USER"])
    def enviarSolicitudAmistad() {
        try {
            amigosService.enviarSolicitud(params.toString().split(":")[0].split("#")[1])
            render "Solicitud enviada exitosamente!"
        } catch (UsuarioNoPuedeEnviarSolicitudExcepcion e) {
            render e.getMessage()
        }
    }

    @Secured(["ROLE_USER"])
    def eliminarAmigo() {
        try {
            amigosService.eliminarAmigo(estudianteService.getAmigoById(params.padron))
            render "Amigo eliminado exitosamente!"
        } catch (Throwable e) {
            render e.getMessage()
        }
    }

    @Secured(["ROLE_USER"])
    def cambiarEstadoSolicitud() {
        def nuevoEstado = params.estado == 'aceptado' ? Solicitud.EstadoSolicitud.Aceptado : Solicitud.EstadoSolicitud.Rechazado

        amigosService.updateEstadoSolicitud(params.id, nuevoEstado)

        if (nuevoEstado.equals(Solicitud.EstadoSolicitud.Aceptado))
            render "Nuevo amigo agregado! Podes encontrarlo en la sección Mi Perfil."

        if (nuevoEstado.equals(Solicitud.EstadoSolicitud.Rechazado))
            render "Solicitud rechazada exitosamente!"
    }
}
