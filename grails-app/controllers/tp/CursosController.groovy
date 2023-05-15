package tp

import grails.plugin.springsecurity.annotation.Secured

class CursosController {

    def cursoService

    @Secured(["ROLE_USER"])
    def index() {
        respond cursoService.getCursosDeMateria(params.materia), formats: ['json']
    }
}
