package tp

import grails.compiler.GrailsCompileStatic
import grails.persistence.Entity

@Entity
@GrailsCompileStatic
class Solicitud {
    static mapWith = "mongo"

    Estudiante solicitado;
    Estudiante solicitante;
    EstadoSolicitud estado;

    public static enum EstadoSolicitud{
            Pendiente,
            Rechazado,
            Aceptado
    }

    static constraints = {
        solicitado nullable: false , unique: false
        solicitante nullable: false , unique: false
        estado nullable: false , unique: false
    }
}
