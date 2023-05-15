package tp

import domain.CursoRecomendado
import grails.plugin.springsecurity.annotation.Secured

import java.util.stream.Collectors

class HomeController {
    def springSecurityService
    def materiasService
    def cursadaService
    def amigosService
    def recomendadorService
    def estudianteService

    @Secured(['ROLE_USER'])
    def index() {
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        def compasAntiguos = recomendadorService.getCompasAntiguos(estudiante)
        def compasActuales = recomendadorService.getCompasActuales(estudiante.getCursadasActuales() as List<Cursada>)
        def ponderaciones = recomendadorService.calcularPonderacionesDeCursosRecomendados("creditos")
        def cursosRecomendados = recomendadorService.getCursosRecomendados(
                estudiante,
                compasAntiguos.stream().
                        map({c -> c.estudiante}).
                        collect(Collectors.toList()), ponderaciones)

        // def aux = Estudiante.findById(4)
        // def cursada = Cursada.findById(4)
        // def cursante = Cursante.findById(103)
        // cursante.delete()
        // aux.removeFrom("cursadas", cursada)
        // aux.save(flush: true, failOnError: true)        


        [carrera: "Ingenieria Informatica",
         estudiante: estudiante,
         compasAntiguos: compasAntiguos,
         compasActuales: compasActuales,
         cursosRecomendados: cursosRecomendados]
    }

    @Secured(['ROLE_USER'])
    def ordenarCursosRecomendados(){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)

        def ponderaciones = recomendadorService.
                calcularPonderacionesDeCursosRecomendados(params.criterioCursosRecomendados)

        def cursadas = estudiante.getCursadas()

        def compasAntiguos = recomendadorService.
                filtrarSolicitudEnviadaAndAmigos(cursadaService.getCompasDeCursada(cursadas as List<Cursada>))

        def cursosOrdenados = recomendadorService.
                getCursosRecomendados(
                        estudiante,
                        compasAntiguos.stream().
                                map({c -> c.estudiante}).collect(Collectors.toList()), ponderaciones).sort{it->it.ponderacion}

        def jsonObj = []

        cursosOrdenados.collect{
            curso ->
                def cursoItem = [
                    codigo: curso.materia.codigo,
                    materia: curso.materia.nombre,
                    creditos: curso.materia.creditos,
                    curso: curso.curso.codigo,
                    amigos: curso.amigos,
                    companieros: curso.companieros,
                ]

                jsonObj.push(cursoItem)
        }

        respond jsonObj, formats: ['json']
    }

    @Secured(['ROLE_USER'])
    def ordenarCompasActuales(){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)

        def ponderaciones = recomendadorService.
                calcularPonderacionesCompasRecomendados(params.criterioCompasActuales)

        def compasActuales = cursadaService.
                getCompasDeCursada(estudiante.getCursadasActuales() as List<Cursada>)

        def compasOrdenados = recomendadorService.
                compasSortedByPonderacion(compasActuales as ArrayList, ponderaciones as LinkedHashMap).sort{ it->it.ponderacion}

        def jsonObj = []

        compasOrdenados.collect{
            compa ->
                def compaItem = [
                    nombre: compa.estudiante.nombre,
                    apellido: compa.estudiante.apellido,
                    promedio: compa.estudiante.getPromedio(),
                    cursadas: compa.cursadasCompartidas,
                    padron: compa.estudiante.padron,
                    amigosEnComun: amigosService.amigosEnComun(estudiante, compa.estudiante),
                    amigo: estudiante.getAmigos().contains(compa.estudiante)
                ]
                jsonObj.push(compaItem)
        }

        respond jsonObj, formats: ['json']
    }

    @Secured(['ROLE_USER'])
    def ordenarAmigosRecomendados(){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)

        def ponderaciones = recomendadorService.
                calcularPonderacionesCompasRecomendados(params.criterioAmigosRecomendados)

        def compasNoAmigos = recomendadorService.
                filtrarSolicitudEnviadaAndAmigos(
                        cursadaService.getCompasDeCursada(estudiante.getCursadasAprobadas() as List<Cursada>))

        def compasOrdenados = recomendadorService.
                compasSortedByPonderacion(compasNoAmigos as ArrayList, ponderaciones as LinkedHashMap<String, Integer>).
                sort{ it->it.ponderacion}

        def jsonObj = []

        compasOrdenados.collect{
            compa ->
                def compaItem = [
                        nombre: compa.estudiante.nombre,
                        apellido: compa.estudiante.apellido,
                        promedio: compa.estudiante.getPromedio(),
                        cursadas: compa.getCantidadDeCursadasCompartidas(),
                        padron: compa.estudiante.padron,
                        amigo: estudiante.getAmigos().contains(compa.estudiante),
                        amigosEnComun: amigosService.amigosEnComun(estudiante, compa.estudiante)
                ]

                jsonObj.push(compaItem)
        }

        respond jsonObj, formats: ['json']
    }
}
