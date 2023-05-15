package tp

import grails.compiler.GrailsCompileStatic
import grails.persistence.Entity

@Entity
@GrailsCompileStatic

class Estudiante {
    static mapWith = "mongo"

    String nombre
    String apellido
    String email
    String padron
    String orientacion
    String visibilidad
    static hasMany = [cursadas: Cursada, amigos: Estudiante]
    DatosDeContacto datosDeContacto

    static embedded = ['datosDeContacto']

    static mapping = {
        orientacion defaultValue: "'None'"
    }
    static constraints = {
        email nullable: false , unique: true
    }

    def getPromedio(){
        def cursadasAprobadas = getCursadasAprobadas() as List<Cursada>

        if (cursadasAprobadas.size() == 0)
            return 0

        return (cursadasAprobadas.sum{ Cursada it->
                it.getNotaDeEstudiante(this)
        }.asType(Integer) / cursadasAprobadas.size()).round(2)
    }

    def getCursadasAprobadas(){
        return cursadas.findAll{it.estaAprobado(this)}
    }

    def getCursadasActuales(){
        return cursadas.findAll{!it.estaAprobado(this) && it.esCursadaCuatrimestreYAñoActual()}
    }

    def getMateriasAprobadas(){
        def cursadasAprobadas = cursadas.findAll{it.estaAprobado(this)}
        return cursadasAprobadas.collect {element -> return element.getMateria()}

    }

    def getMateriasEnCurso(){
        def cursadasActuales = cursadas.findAll{!it.estaAprobado(this)}
        return cursadasActuales.collect {element -> return element.getMateria()}
    }

    def codigosDeMateriasAprobadas(){
        def cursadasAprobadas = cursadas.findAll{it.estaAprobado(this)}
        return cursadasAprobadas.collect {element -> return element.getCodigoDeMateria()}
    }

    def getCodigoDeMateriasEnCurso(){
        def cursadasActuales = cursadas.findAll{!it.estaAprobado(this)}
        return cursadasActuales.collect {element -> return element.getCodigoDeMateria()}
    }

    def esAmigoDe(Estudiante amigo){
        return amigos.contains(amigo)
    }
}
