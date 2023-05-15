package tp

class BootStrap {
    def databaseService

    def init = { servletContext ->
        def userRole = Rol.findByAuthority('ROLE_USER') ?:
            new Rol(authority: 'ROLE_USER').save(failOnError: true)
        def adminRole = Rol.findByAuthority('ROLE_ADMIN') ?:
            new Rol(authority: 'ROLE_ADMIN').save(failOnError: true)

        def adminUser = Usuario.findByUsername('admin') ?: new Usuario(
                username: 'admin',
                password: 'admin',
                email: 'nachops@email.com',
                estudianteId: -1,
                authorities: [adminRole, userRole]).save(failOnError: true)
    }

    def destroy = {
    }
}
