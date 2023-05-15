package tp

import grails.compiler.GrailsCompileStatic
import grails.persistence.Entity

@Entity
@GrailsCompileStatic
class Cursante {
    static mapWith = "mongo"
    Integer nota
    Estudiante estudiante

    static constraints = {
        nota nullable: true
    }
}
