package tp

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class Usuario implements Serializable {

    static mapWith = "mongo"

    private static final long serialVersionUID = 1

    String username
    String password
    String email
    Integer estudianteId
    boolean enabled = true

    Set<Rol> authorities // Set para guardar los roles del usuaio
    static embedded = ['authorities'] // mongodb supports embedded document

    Set<Rol> getAuthorities() {
        this.authorities
    }

    static constraints = {
        password nullable: false, blank: false, password: true
        username nullable: false, blank: false, unique: true
        estudianteId unique: true
    }

    static mapping = {
	    password column: '`password`'
    }
}
