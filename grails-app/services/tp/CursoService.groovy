package tp

import grails.gorm.transactions.Transactional

@Transactional
class CursoService {
    def mongo

    def getCursosDeMateria(String codigoDeMateria) {
        def cursos = Curso.findAllByMateria(codigoDeMateria)
        def cursosDisponibles = []

        cursos.collect{cursosDisponibles.push("${it.codigo}- ${it.docentes}")}

        return cursosDisponibles
    }
}
