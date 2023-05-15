package tp

import domain.CursoRecomendado
import grails.gorm.transactions.Transactional

@Transactional
class RecomendadorService {
    def cursadaService
    def materiasService
    def springSecurityService

    private static final int PONDERACION_CRITERIO_ELEGIDO_USUARIO = 5
    private static final int PONDERACION_SEGUNDO_CRITERIO = 2
    private static final int PONDERACION_TERCER_CRITERIO = 1

    private static final String AMIGOS = "amigos"
    private static final String PROMEDIO = "promedio"
    private static final String CURSADAS = "cursadas"
    private static final String EXCOMPAS = "exCompas"
    private static final String CREDITOS = "creditos"

    def calcularPonderacionesCompasRecomendados(String criterioOrdenamiento){
        def ponderaciones = [:]

        ponderaciones[criterioOrdenamiento] = PONDERACION_CRITERIO_ELEGIDO_USUARIO

        switch(criterioOrdenamiento){
            case PROMEDIO:
                ponderaciones[AMIGOS] = PONDERACION_SEGUNDO_CRITERIO;
                ponderaciones[CURSADAS] = PONDERACION_TERCER_CRITERIO;
                break;
            case CURSADAS:
                ponderaciones[AMIGOS] = PONDERACION_SEGUNDO_CRITERIO;
                ponderaciones[PROMEDIO] = PONDERACION_TERCER_CRITERIO;
                break;
            case AMIGOS:
                ponderaciones[CURSADAS] = PONDERACION_SEGUNDO_CRITERIO;
                ponderaciones[PROMEDIO] = PONDERACION_TERCER_CRITERIO;
                break;
        }

        return ponderaciones
    }

    def calcularPonderacionesDeCursosRecomendados(String criterioOrdenamiento){
        def ponderaciones = [:]

        ponderaciones[criterioOrdenamiento] = PONDERACION_CRITERIO_ELEGIDO_USUARIO

        switch(criterioOrdenamiento){
            case CREDITOS:
                ponderaciones[AMIGOS] = PONDERACION_SEGUNDO_CRITERIO;
                ponderaciones[EXCOMPAS] = PONDERACION_TERCER_CRITERIO;
                break;
            case AMIGOS:
                ponderaciones[EXCOMPAS] = PONDERACION_SEGUNDO_CRITERIO;
                ponderaciones[CREDITOS] = PONDERACION_TERCER_CRITERIO;
                break;
            case EXCOMPAS:
                ponderaciones[AMIGOS] = PONDERACION_SEGUNDO_CRITERIO;
                ponderaciones[CREDITOS] = PONDERACION_TERCER_CRITERIO;
                break;
        }

        return ponderaciones
    }

    def getCompasAntiguos(Estudiante estudiante){
        return cursadaService.getCompasAntiguosDe(estudiante)
    }

    def compasSortedByPonderacion(ArrayList compasNoAmigos, Map<String, Integer> ponderaciones){
        compasNoAmigos.collect{
            compa ->
                compa.ponderacion = (compa.estudiante.getPromedio() != null ? compa.estudiante.getPromedio() : 0) * ponderaciones[PROMEDIO] +
                        (compa.amigosEnComun != null ? compa.amigosEnComun : 0) * ponderaciones[AMIGOS]+
                        (compa.getCantidadDeCursadasCompartidas() != null ? compa.getCantidadDeCursadasCompartidas() : 0) * ponderaciones[CURSADAS]
        }

        return compasNoAmigos.sort{-it.ponderacion}
    }

    def getCursosRecomendados(Estudiante estudiante, List<Estudiante> companieros, LinkedHashMap<String, Integer> ponderaciones){
        LinkedHashMap<String, CursoRecomendado> cursosRecomendados = [:]

        def cursadasActuales = estudiante.getCursadasActuales()

        fillMateriasDictionary(cursosRecomendados, estudiante.getAmigos() as List<Estudiante>, cursadasActuales as List<Cursada>, true)
        fillMateriasDictionary(cursosRecomendados, companieros, cursadasActuales as List<Cursada>, false)

        return cursosSortedByPonderacion(cursosRecomendados.values(), ponderaciones)
    }

    def cursosSortedByPonderacion(Collection<CursoRecomendado> cursosRecomendados, LinkedHashMap<String, Integer> ponderaciones){
        cursosRecomendados.collect{
            it.ponderacion = (it.materia.creditos != null ? it.materia.creditos : 0) * ponderaciones[CREDITOS] +
                    (it.amigos != null ? it.amigos : 0) * ponderaciones[AMIGOS]+
                    (it.companieros != null ? it.companieros : 0) * ponderaciones[EXCOMPAS]
        }

        return cursosRecomendados.sort{-it.ponderacion}
    }

    def getCompasActuales(List<Cursada> cursadasActuales){
        def ponderaciones = calcularPonderacionesCompasRecomendados(CURSADAS)
        def compasActuales = cursadaService.getCompasDeCursada(cursadasActuales)
        def compasOrdenados = compasSortedByPonderacion(compasActuales as ArrayList, ponderaciones as LinkedHashMap<String, Integer>)
        return compasOrdenados
    }

    def fillMateriasDictionary(LinkedHashMap<String, CursoRecomendado> cursosRecomendados, List<Estudiante> companieros, List<Cursada> cursadasActuales, Boolean amigos){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        def materiasAprobadas = estudiante.codigosDeMateriasAprobadas()
        companieros.collect{est->
            est.getCursadasActuales().collect{cursada->
                if (cursosRecomendados.containsKey(cursada.curso.materia.codigo)) {
                    if (amigos)
                        cursosRecomendados[cursada.curso.materia.codigo].amigos += 1
                    else if (!amigos) {
                        if(!Estudiante.findById(springSecurityService.currentUser.estudianteId).getAmigos().contains(est))
                            cursosRecomendados[cursada.curso.materia.codigo].companieros += 1
                    }
                    return
                }

                if (!cursadasActuales.contains(cursada) && usuarioPuedeCursarMateria(cursada, materiasAprobadas)) {
                    cursosRecomendados[cursada.curso.materia.codigo] = new CursoRecomendado(
                            materia: Materia.findByCodigo(cursada.curso.materia.codigo),
                            amigos: 0,
                            companieros: 0,
                            ponderacion: 0,
                            curso: cursada.curso
                    )
                    if (amigos)
                        cursosRecomendados[cursada.curso.materia.codigo].amigos += 1
                    else if (!amigos) {
                        if(! Estudiante.findById(springSecurityService.currentUser.estudianteId).getAmigos().contains(est))
                            cursosRecomendados[cursada.curso.materia.codigo].companieros += 1
                    }
                }
            }
        }
    }

    def usuarioPuedeCursarMateria(Cursada cursada, ArrayList<String> materiasAprobadas){
        def materiasDisponibles = materiasService.calcularMateriasDisponibles(materiasAprobadas)
        return materiasDisponibles.find{it.codigo == cursada.curso.materia.codigo} != null
    }

    /*
    * Saco de amigos recomendados a aquellos que posean una solicitud pendiente, tanto enviada como recibidad
    * con el estudiante en cuestion
    * */
    def filtrarSolicitudEnviadaAndAmigos(compas) {
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        def ret = []

        compas.collect{
            if (Solicitud.findByEstadoAndSolicitadoAndSolicitante(Solicitud.EstadoSolicitud.Pendiente, estudiante, it.estudiante) ||
                    Solicitud.findByEstadoAndSolicitadoAndSolicitante(Solicitud.EstadoSolicitud.Pendiente, it.estudiante, estudiante) ||
                    it.amigo)
                return

            ret.add(it)
        }

        return ret
    }
}
