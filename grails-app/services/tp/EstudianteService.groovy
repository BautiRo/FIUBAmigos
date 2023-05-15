package tp

import domain.MateriaEnCurso
import grails.gorm.transactions.Transactional
import excepciones.DatosVaciosException

import java.time.Year

@Transactional
class EstudianteService {

    def static final int JULIO = 7

    def springSecurityService

    def crearEstudiante(String nombre, String apellido, String padron, String email){
        def materiasAprobadas = []
        def estudiante = new Estudiante(nombre: nombre,
                apellido: apellido,
                padron: padron,
                email: email,
                materiasAprobadas: materiasAprobadas,
                orientacion: 'None',
                visibilidad: 'Privado',
                amigos: [],
                cursadas: [],
                materiasEnCurso: [],
                datosDeContacto: new DatosDeContacto(whatsApp: "",
                        instagram: "",
                        twitter: "",
                        facebook: "",
                        linkedIn: "",
                        mailPersonal: ""))
        estudiante.save(flush: true, failOnError: true)

        return estudiante.getId()
    }

    /* Actualizar el estudiante desde la sección de MiPerfil */
    def updateMiPerfil(LinkedHashMap newData){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)

        estudiante.setNombre(newData.name)
        estudiante.setApellido(newData.lastname)
        estudiante.setPadron(newData.padron)
        estudiante.setEmail(newData.email)
        estudiante.setOrientacion(newData.orientacion)
        estudiante.setVisibilidad(newData.visibilidad)

        def datos = estudiante.getDatosDeContacto()

        if (datos) {
            datos.whatsApp = newData.whatsapp
            datos.instagram = newData.instagram
            datos.twitter = newData.twitter
            datos.facebook = newData.facebook
            datos.linkedIn = newData.linkedin
            datos.mailPersonal = newData.mailP
        }
        else {
            estudiante.setDatosDeContacto(new DatosDeContacto(
                    whatsApp: newData.whatsapp,
                    instagram: newData.instagram,
                    twitter: newData.twitter,
                    facebook: newData.facebook,
                    linkedIn: newData.linkedin,
                    mailPersonal: newData.mailP
            ))
        }

        estudiante.save(flush: true, failOnError: true)
    }

    //TODO: habria que ver de unificar este con el de cursada actual.
    //el problema es que reciben 2 arrays distintos, eso me complica la vida.
    def agregarCursadaAprobada(ArrayList cursadasAprobadas){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)
        def listaDeCursadas = []

        cursadasAprobadas.collect{
            cursadaAprobada ->
                def searchFields = getDataDeCursadaActual(cursadaAprobada)

                def cursadaInDB = Cursada.findByCuatrimestreAndAnioAndCurso(searchFields[1], searchFields[2], searchFields[3])

                if(cursadaInDB){
                    if(estudiante.cursadas && estudiante.cursadas.contains(cursadaInDB)){
                        def cursada = estudiante.cursadas.find(cursadaInDB)
                        if (cursada){
                            def cursante = cursada.cursantes.find{it.estudiante = estudiante}
                            if(cursante)
                                cursante.nota = cursadaAprobada[1] as Integer
                        }
                    }
                    else{
                        def cursante = new Cursante(
                                estudiante: estudiante,
                                nota: cursadaAprobada[1] as Integer
                        )
                        cursadaInDB.addToCursantes(cursante)
                        cursante.save(flush: true, failOnError: true)
                        cursadaInDB.save(flush: true, failOnError: true)
                        listaDeCursadas << cursadaInDB
                    }
                }
                else{
                    listaDeCursadas << new Cursada(
                            curso: Curso.findByCodigo(cursadaAprobada[4].split("-")[0]),
                            cuatrimestre: cursadaAprobada[2] as Integer,
                            anio: cursadaAprobada[3] as Integer,
                            cursantes: [new Cursante(
                                    estudiante: estudiante,
                                    nota: cursadaAprobada[1] as Integer
                            )]
                    )
                }
        }

        listaDeCursadas.each{
            cursada ->
                estudiante.addToCursadas(cursada as Cursada)
        }

        estudiante.save(flush: true, failOnError: true)
    }

    def getDataDeCursadaActual(String[] cursadaAprobada){
        sonDatosValidos(cursadaAprobada)

        def searchFields = []

        searchFields << cursadaAprobada[0].split("-")[0] // MATERIA
        searchFields << cursadaAprobada[2]
        searchFields << cursadaAprobada[3]
        searchFields << cursadaAprobada[4].split("-")[0]

        return searchFields
    }

    def sonDatosValidos(String[] cursadaAprobada){
        if (cursadaAprobada[0].equals("") ||
                cursadaAprobada[1].equals("") ||
                cursadaAprobada[2].equals("") ||
                cursadaAprobada[3].equals("") ||
                cursadaAprobada[4].equals(""))
            throw new DatosVaciosException("¡Surgió un error al cargar la materia! Porfavor, asegurate de completar " +
                    "todos los campos antes de enviar.")
    }

    def agregarCursadaActual(ArrayList cursadasActuales){
        def estudiante = Estudiante.findById(springSecurityService.currentUser.estudianteId)

        def cursadas = []

        cursadasActuales.collect{
            cursada ->
                def codigo
                def nombre
                def curso
                (codigo, nombre, curso) = this.getDataDeCursada(cursada)

                /* Busco el registro de la materia solicitada */
                def cuatrimestre = getCuatrimestreActual()
                def año = Year.now().getValue()
                def cursadaInDB = Cursada.findByCuatrimestreAndAnioAndCurso(cuatrimestre, año, curso)

                if(cursadaInDB){
                    /* Chequeo que el usuario no tenga ya esa materia en su lista de materiasEnCurso */
                    if(estudiante.cursadas.contains(cursadaInDB))
                        return

                    /* Guardo la materia en curso con los cursantes actualizados */
                    cursadaInDB.addToCursantes(new Cursante(
                            estudiante: estudiante
                    ))
                    cursadaInDB.save(flush: true, failOnError: true)

                    /* Agrego a materias la materiaEnCurso */
                    cursadas.add(cursadaInDB)
                }
                else{
                    cursadas << new Cursada(
                            curso: curso,
                            cuatrimestre: cuatrimestre,
                            anio: año,
                            cursantes: [new Cursante(
                                    estudiante: estudiante
                            )]
                    )
                }
        }

        cursadas.collect{
            cursada ->
                estudiante.addTo("cursadas", cursada)
        }

        estudiante.save(flush: true, failOnError: true)
    }

    def getCuatrimestreActual(){
        return new Date().getMonth() < JULIO ? 1 : 2
    }

    def getDataDeCursada(String[] materia){
        if (materia[0].equals("") || materia[1].equals(""))
            throw new DatosVaciosException("¡Surgió un error al cargar la materia! Porfavor, asegurate de completar " +
                    "todos los campos antes de enviar.")

        def codigo = materia[0].split("-")[0] as String
        def nombre = materia[0].split("-")[1] as String
        def curso = Curso.findByCodigo(materia[1].split("-")[0])

        return [codigo, nombre, curso]
    }

    def buscarEstudiantes(String paramsNombre, String paramsApellido, String paramsPadron){
        def estudiantes = new ArrayList<Estudiante>()

        if (!paramsNombre.equals(""))
            estudiantes.addAll(Estudiante.findAllByNombreIlike("%" + paramsNombre + "%"))

        if (!paramsApellido.equals(""))
            estudiantes.addAll(Estudiante.findAllByApellidoIlike("%" + paramsApellido + "%"))

        if (!paramsPadron.equals(""))
            estudiantes.addAll(Estudiante.findAllByPadron(paramsPadron))

        return estudiantes
    }

    def getAmigoById(String padron){
        return Estudiante.findByPadron(padron)
    }
}
