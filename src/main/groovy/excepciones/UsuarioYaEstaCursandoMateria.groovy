package excepciones

class UsuarioYaEstaCursandoMateria extends RuntimeException{

    public UsuarioYaEstaCursandoMateria(String mensaje){
        super(mensaje)
    }
}
