package tp

import grails.compiler.GrailsCompileStatic
import grails.persistence.Entity

@Entity
@GrailsCompileStatic

class Materia {
    static mapWith = "mongo"

    String codigo
    String nombre
    Integer creditos
    List<String> correlativas
    List<Curso> cursos

    static constraints = {
    }

    static mapping = {
        id generator:'assigned', name:'codigo', unique:'true', column: 'codigo'
    }

    def usuarioPuedoCursarme(List<String> materiasUsuario){
        return materiasUsuario.containsAll(correlativas)
    }
}
