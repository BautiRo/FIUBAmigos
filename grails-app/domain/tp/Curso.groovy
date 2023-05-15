package tp

import grails.compiler.GrailsCompileStatic
import grails.persistence.Entity

@Entity
@GrailsCompileStatic
class Curso {
    static mapWith = "mongo"

    String codigo
    String docentes
    Materia materia

    static constraints = {
    }

    static mapping = {
        id generator:'assigned', name:'codigo', unique:'true', column: 'codigo'
    }
}
