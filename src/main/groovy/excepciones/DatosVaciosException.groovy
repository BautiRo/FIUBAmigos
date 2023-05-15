package excepciones

class DatosVaciosException extends RuntimeException{

    public DatosVaciosException(String mensaje){
        super(mensaje)
    }
}
