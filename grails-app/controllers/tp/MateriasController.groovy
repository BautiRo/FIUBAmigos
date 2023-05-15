package tp

import excepciones.DatosVaciosException
import excepciones.UsuarioYaEstaCursandoMateria
import grails.plugin.springsecurity.annotation.Secured

class MateriasController {

    def estudianteService
    def materiasService
    def springSecurityService
    def cursadaService

    static allowedMethods = [materiasAprobadas: 'POST']

    @Secured(["ROLE_USER"])
    def materiasEnCursoPage() {
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        def materiasEnCurso = estudiante.getCodigoDeMateriasEnCurso() + estudiante.codigosDeMateriasAprobadas()

        def materiasDisp = materiasService.calcularMateriasDisponibles(materiasEnCurso)
        materiasDisp = materiasService.convertirMateriasDisponiblesEnStringArray(materiasDisp)

        render (view: "materiasEnCurso.gsp", model: [materias: materiasDisp])
    }

    @Secured(["ROLE_USER"])
    def materiasAprobadasPage() {
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        def materiasAprobadas = estudiante.codigosDeMateriasAprobadas()

        def materiasDisp = materiasService.calcularMateriasDisponibles(materiasAprobadas)
        def materias = materiasService.convertirMateriasDisponiblesEnStringArray(materiasDisp)

        render (view: "materiasAprobadas.gsp", model: [materias: materias])
    }

    @Secured(["ROLE_USER"])
    def materiasEnCursoCrear() {
        def materiasEnCurso = params.values() as List

        materiasEnCurso.removeLast() // elimino param controller
        materiasEnCurso.removeLast() // elimino param action

        try {
            estudianteService.agregarCursadaActual(materiasEnCurso as ArrayList)
            render "Materias agregadas exitosamente!"
        }catch(UsuarioYaEstaCursandoMateria e){
            render e.getMessage()
        }catch(DatosVaciosException e){
            render e.getMessage()
        }
    }

    @Secured(["ROLE_USER"])
    def materiasEnCursoEliminar(){
        def idCursadaActual = params.idCursadaActual

        try {
            cursadaService.eliminarCursadaActual(idCursadaActual)
            render "Materia eliminada exitosamente!"
        } catch (Throwable e) {
            render e.getMessage()
        }
    }

    @Secured(["ROLE_USER"])
    def materiasAprobadasCrear() {
        def materiasAprobadas = params.values() as List

        materiasAprobadas.removeLast() // elimino param controller
        materiasAprobadas.removeLast() // elimino param action

        try {
            estudianteService.agregarCursadaAprobada(materiasAprobadas as ArrayList)
            render "Materias agregadas exitosamente!"
        }catch(DatosVaciosException e){
            render e.getMessage()
        }
    }

    @Secured(["ROLE_USER"])
    def index() {
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        switch (params.tipo){
            case "aprobadas":
                def materiasAprobadasEnForm = request.JSON as ArrayList
                def materiasAprobadas = estudiante.codigosDeMateriasAprobadas() + materiasAprobadasEnForm

                def materias = materiasService.calcularMateriasDisponibles(materiasAprobadas)
                respond materiasService.convertirMateriasDisponiblesEnStringArray(materias), formats: ['json']
                break
            case "cursables":
                def materiasCursandoEnForm = request.JSON as ArrayList
                def materiasEnCurso = estudiante.getMateriasEnCurso() as ArrayList
                def materiasAprobadas = estudiante.codigosDeMateriasAprobadas()
                log.error("Materias Aprobadas" + materiasAprobadas)

                def materias = materiasService.calcularMateriasDisponibles(materiasAprobadas)
                materias.removeAll {
                    materiasCursandoEnForm.contains(it.codigo) || materiasEnCurso.contains(it.codigo)
                }
                respond materiasService.convertirMateriasDisponiblesEnStringArray(materias), formats: ['json']
                break
        }

    }


}
