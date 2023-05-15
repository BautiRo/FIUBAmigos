package tp

import grails.compiler.GrailsCompileStatic
import grails.persistence.Entity

@Entity
@GrailsCompileStatic
class DatosDeContacto {
    static mapWith = "mongo"

    String whatsApp
    String instagram
    String twitter
    String facebook
    String linkedIn
    String mailPersonal

    static constraints = {
        whatsApp nullable: true, blank: true
        instagram nullable: true, blank: true
        twitter nullable: true, blank: true
        facebook nullable: true, blank: true
        linkedIn nullable: true, blank: true
        mailPersonal nullable: true, blank: true
    }
}
