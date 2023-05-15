package tp

import grails.gorm.transactions.Transactional

import excepciones.UsuarioNoPuedeEnviarSolicitudExcepcion

@Transactional
class AmigosService {

    def springSecurityService
    
    def enviarSolicitud(String padronEstudiante){
        // Obtengo usuario logueado
        def usuario = Estudiante.findById(springSecurityService.currentUser.estudianteId)

        // Obtengo usuario a enviarle la solicitud
        def solicitado = Estudiante.findByPadron(Integer.valueOf(padronEstudiante))

        if (!this.usuarioPuedeEnviarSolicitudASolicitante(usuario, solicitado))
            throw new UsuarioNoPuedeEnviarSolicitudExcepcion("Error al enviar la solicitud. Ya existe el usuario en " +
                    "su lista de amigos, o tiene una solicitud pendiente.");

        // Creo solicitud nueva, con estado de pendiente
        def solicitud = new Solicitud(solicitado: solicitado,
                                        solicitante: usuario,
                                        estado: Solicitud.EstadoSolicitud.Pendiente)

        // Guardo solicitud en base de datos
        solicitud.save(flush: true, failOnError: true)
    }

    def private usuarioPuedeEnviarSolicitudASolicitante(Estudiante solicitante, Estudiante solicitado){
        if (solicitante.getAmigos().contains(solicitado))
            return false

        if (!Solicitud.findAllBySolicitadoAndSolicitanteAndEstado(
                solicitado,
                solicitante,
                Solicitud.EstadoSolicitud.Pendiente).isEmpty())
            return false

        return true
    }

    def eliminarAmigo(Estudiante estudiante){
        def usuario = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        usuario.removeFrom("amigos", estudiante)
        usuario.save(flush:true, failOnError: true)

        estudiante.removeFrom("amigos", usuario)
        estudiante.save(flush:true, failOnError: true)
    }

    def getSolicitudesPendientes(){
        def usuario = Estudiante.findById(springSecurityService.currentUser.estudianteId)

        return Solicitud.findAllByEstadoAndSolicitado(
                Solicitud.EstadoSolicitud.Pendiente,
                usuario)
    }

    def getSolicitudesEnviadas(){
        def usuario = Estudiante.findAllById(springSecurityService.currentUser.estudianteId)

        return Solicitud.findAllByEstadoAndSolicitante(
                        [Solicitud.EstadoSolicitud.Pendiente],
                        usuario)
    }

    def updateEstadoSolicitud(String idSolicitud, Solicitud.EstadoSolicitud estado){
        def solicitud = Solicitud.findById(idSolicitud)
        solicitud.setEstado(estado)
        solicitud.save(flush:true, failOnError: true) //innecesario

        if (estado.equals(Solicitud.EstadoSolicitud.Rechazado)) return; // equals -> ==

        this.agregarAmigoALista(Estudiante.findById(springSecurityService.currentUser.estudianteId),
                Estudiante.findById(solicitud.getSolicitante().getId()))
    }

    def agregarAmigoALista(Estudiante estudiante_1, Estudiante estudiante_2){
        estudiante_1.addToAmigos(estudiante_2)
        estudiante_2.addToAmigos(estudiante_1)

        estudiante_1.save(flush: true, failOnError: true)
        estudiante_2.save(flush: true, failOnError: true)

    }

    def amigosEnComun(Estudiante est1, Estudiante est2){
        return est1.getAmigos().findAll{
            est2.getAmigos().contains(it)
        }.size()
    }
}
