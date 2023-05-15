package excepciones

class UsuarioNoPuedeEnviarSolicitudExcepcion extends RuntimeException{

    public UsuarioNoPuedeEnviarSolicitudExcepcion(String mensaje){
        super(mensaje)
    }
}
