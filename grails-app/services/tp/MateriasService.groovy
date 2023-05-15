package tp

import grails.gorm.transactions.Transactional

@Transactional
class MateriasService {

    def mongo
    def springSecurityService


    def calcularMateriasDisponibles(ArrayList<String> materias){
        materias.push("CBC")
        materias = materias.unique(true)

        def materiasCursables = []
        def todasLasMaterias = Materia.all

        todasLasMaterias.collect{
            if ((!materias.contains(it.codigo) && it.usuarioPuedoCursarme(materias)))
                materiasCursables.push(it)
        }
        return materiasCursables
    }

    def convertirMateriasDisponiblesEnStringArray(ArrayList<Materia> materiasDisponibles) {
        def materiasCursables = []
        materiasDisponibles.collect{
            materiasCursables.push("${it.codigo}- ${it.nombre}")
        }
        return materiasCursables
    }
}
