package tp

import grails.compiler.GrailsCompileStatic
import grails.persistence.Entity

import java.time.Year

@Entity
@GrailsCompileStatic
class Cursada {
    static mapWith = "mongo"

    private static final int JULIO = 7

    Curso curso
    Integer cuatrimestre
    Integer anio
    static hasMany = [cursantes: Cursante]

    static constraints = {
        curso nullable: false
    }

    def estaAprobado(Estudiante estudiante){
        def cursante = cursantes.find{it.estudiante == estudiante}
        if (cursante)
            return cursante.nota >= 4
        else
            return false
    }


    def getNotaDeEstudiante(Estudiante estudiante){
        def cursante = cursantes.find{it -> it.estudiante == estudiante}
        return cursante.nota
    }

    def getCodigoDeMateria (){
        return curso.materia.codigo
    }

    def getMateria (){
        return curso.materia
    }

    def esCursadaCuatrimestreYAñoActual(){
        return (anio == Year.now().getValue() ) && (esCuatrimestreActual())
    }
    
    def esCuatrimestreActual(){
        def cuatrimestreActual = new Date().getMonth() < JULIO ? 1 : 2
        return cuatrimestre == cuatrimestreActual
    }
}
