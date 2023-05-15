package domain

import tp.Curso
import tp.Estudiante

class MateriaEnCurso {
    static mapWith = "mongo"

    String nombre
    String codigo
    Curso curso
    List<Estudiante> cursantes

    static constraints = {
        nombre nullable: false
        curso nullable: false
        codigo nullable: false
        cursantes nullable: false
    }
}
