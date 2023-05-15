package tp

class DefaultPageController {
    def springSecurityService

    def index() {
        if (springSecurityService.currentUser)
            redirect(action: "view", controller:"perfil")
    }
}
