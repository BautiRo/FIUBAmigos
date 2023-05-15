package tp

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/login/$action?"(controller: "login")
        "/logout/$action?"(controller: "logout")

        "/materiasEnCurso/$id?"(controller: 'materias', action: 'materiasEnCursoPage')
        "/materiasEnCurso/crear/$id?"(controller: 'materias', action: 'materiasEnCursoCrear')
        "/materiasEnCurso/eliminar/$idMateria?"(controller: 'materias', action: 'materiasEnCursoEliminar')

        "/materiasAprobadas/$id?"(controller: 'materias', action: 'materiasAprobadasPage')
        "/materiasAprobadas/crear/$id?"(controller: 'materias', action: 'materiasAprobadasCrear')

        "/perfil/ver/$padron"(controller: 'perfil', action: 'view')
        "/perfil"(controller: 'perfil', action: 'view')

        "/perfil/editar"  controller: 'perfil', action: 'getEditar', method: 'GET'
        "/perfil/editar"  controller: 'perfil', action: 'postEditar', method: 'POST'

        "/" {
            controller = "DefaultPage"
            action = "index"
        }

        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
