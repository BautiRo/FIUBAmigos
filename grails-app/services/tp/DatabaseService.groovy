package tp

import com.mongodb.BasicDBObject
import com.mongodb.Block
import com.mongodb.DBObject
import com.mongodb.client.MongoCollection
import com.mongodb.client.MongoDatabase
import grails.gorm.transactions.Transactional
import org.bson.Document

@Transactional
class DatabaseService {

    def mongo

    def cargaDeMaterias() {
        Block<Document> printBlock = new Block<Document>() {
            @Override
            public void apply(final Document document) {
                def codigo = document.get("codigo")
                def correlativas = document.get("correlativas")
                def creditos = document.get("creditos")
                def nombre = document.get("nombre")
                def materia = new Materia(codigo: codigo, correlativas: correlativas, nombre: nombre, creditos: creditos, cursos: [])
                materia.save(flush: true, failOnError: true)

            }
        };

        MongoDatabase db = mongo.getDatabase("FIUBAmigos")
        MongoCollection<Document> carrera = db.getCollection("carreras") as MongoCollection

        DBObject match = new BasicDBObject(['$match': ['nombre': 'Ingeniería en Informática']]);
        DBObject unwind = new BasicDBObject(['$unwind': '$materias']);

        DBObject project = new BasicDBObject(['$project': [
                'codigo'      : '$materias.codigo',
                'nombre'      : '$materias.nombre',
                'creditos'    : '$materias.creditos',
                'correlativas': '$materias.correlativas']
        ]);
        carrera.aggregate([match, unwind, project]).forEach(printBlock)
        return "ok"
    }

    def cargaDeCursos() {
        Block<Document> printBlock = new Block<Document>() {
            @Override
            public void apply(final Document document) {
                def codigo = document.get("codigo")
                def codigo_materia = document.get("codigo_materia")
                def docentes = document.get("docentes")
                def materia = Materia.findByCodigo(codigo_materia)
                def curso = new Curso(codigo: codigo, docentes: docentes, materia: materia)
                materia.cursos.add(curso)
                curso.save(flush: true, failOnError: true)
                materia.save(flush: true, failOnError: true)

            }
        };

        MongoDatabase db = mongo.getDatabase("FIUBAmigos")
        MongoCollection<Document> carrera = db.getCollection("carreras") as MongoCollection

        DBObject match = new BasicDBObject(['$match': ['nombre': 'Ingeniería en Informática']]);
        DBObject unwindMaterias = new BasicDBObject(['$unwind': '$materias']);

        DBObject addFields = new BasicDBObject(['$addFields': [
                'codigo'      : '$materias.codigo',
                'cursos'      : '$materias.cursos']
        ]);
        DBObject unwindCursos = new BasicDBObject(['$unwind': '$cursos']);

        DBObject project = new BasicDBObject(['$project': [
                'codigo_materia'      : '$codigo',
                'docentes'      : '$cursos.docentes',
                'codigo'    : '$cursos.codigo']
        ]);
        carrera.aggregate([match, unwindMaterias,addFields, unwindCursos, project]).forEach(printBlock)
        return "ok"
    }
}


