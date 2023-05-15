package domain

import tp.Estudiante

class CompaDeCursada {
    static mapWith = "none"
    Estudiante estudiante
    List<String> cursadasCompartidas
    Boolean amigo
    Integer amigosEnComun
    Double ponderacion

    static constraints = {
    }

    def getCantidadDeCursadasCompartidas(){
        return cursadasCompartidas.size()
    }
}
