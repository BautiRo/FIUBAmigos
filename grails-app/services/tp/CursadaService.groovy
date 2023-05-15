package tp

import domain.CompaDeCursada
import grails.gorm.transactions.Transactional

@Transactional
class CursadaService {

    def mongo
    def springSecurityService
    def amigosService

    def getCompasDeCursada(List<Cursada> cursadas){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
//        def cursantes2 = cursadas[0].getCursantes2()
        LinkedHashMap<String, CompaDeCursada> compasActuales = [:]

        cursadas.collect{cursada->
            cursada.getCursantes().collect{cursante->
                if((cursante.estudiante.nombre == "Ignacio" || cursante.estudiante.nombre == "Juan Pablo") && cursante.estudiante != estudiante ){
                    log.error("test")
                }
                if(cursante.estudiante.visibilidad == "Privado" && ! estudiante.getAmigos().contains(cursante.estudiante))
                    return
                if (compasActuales.containsKey(cursante.estudiante.padron)){
                    compasActuales[cursante.estudiante.padron].cursadasCompartidas.add(cursada.getCodigoDeMateria())
                    return
                }
                if (cursante.estudiante != estudiante){
                    compasActuales[cursante.estudiante.padron] = new CompaDeCursada(
                            estudiante: cursante.estudiante,
                            cursadasCompartidas: [cursada.getCodigoDeMateria()],
                            amigo: estudiante.getAmigos().contains(cursante.estudiante),
                            amigosEnComun: amigosService.amigosEnComun(estudiante, cursante.estudiante),
                            ponderacion: 0
                    )
                }
            }
        }

        return compasActuales.values()
    }

// TODO: Mostrar que findall rompe linea 43
    def getCompasAntiguosDe (Estudiante estudiante) {
        LinkedHashMap<String, CompaDeCursada> compasActuales = [:]
        estudiante.getCursadas().collect{cursada ->
            cursada.getCursantes().collect{cursante ->
                if(cursante.nota < 4){
                    return
                }
                if(cursante.estudiante.visibilidad == "Privado" || estudiante.getAmigos().contains(cursante.estudiante))
                    return
                if (compasActuales.containsKey(cursante.estudiante.padron)){
                    compasActuales[cursante.estudiante.padron].cursadasCompartidas.add(cursada.getCodigoDeMateria())
                    return
                }
                if (cursante.estudiante != estudiante){
                    compasActuales[cursante.estudiante.padron] = new CompaDeCursada(
                            estudiante: cursante.estudiante,
                            cursadasCompartidas: [cursada.getCodigoDeMateria()],
                            amigo: estudiante.getAmigos().contains(cursante.estudiante),
                            amigosEnComun: amigosService.amigosEnComun(estudiante, cursante.estudiante),
                            ponderacion: 0
                    )
                }
            }
        }

        return compasActuales.values()
    }

    def eliminarCursadaActual(idCursadaActual){ // ESTO
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        
        def cursada = Cursada.findById(idCursadaActual)


        def cursante = cursada.cursantes.find{
            it.estudiante == estudiante
        }

        // elimino cursada de las cursadas del estudiante
        estudiante.removeFrom("cursadas", cursada)
        estudiante.save(flush: true, failOnError: true)

        // elimino cursante de cursantes para esa cursada
        cursada.removeFrom("cursantes", cursante)
        cursada.save(flush: true, failOnError: true)

        // elimino cursante
        cursante.delete()
    }
}
