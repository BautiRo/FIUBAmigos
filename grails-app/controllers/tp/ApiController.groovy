package tp

import grails.plugin.springsecurity.annotation.Secured
import org.grails.web.json.JSONArray

import java.lang.reflect.Array

class ApiController {
    def databaseService

    @Secured(["ROLE_ADMIN"])
    def cargarBase() {
        databaseService.cargaDeMaterias()
        databaseService.cargaDeCursos()
        render "OK"
    }
}
