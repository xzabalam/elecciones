package com.eleccciones.cliente.common.exception;

public class EstadisticaException extends RuntimeException {
    public EstadisticaException() {
        super();
    }

    public EstadisticaException(String message) {
        super(message);
    }

    public EstadisticaException(String message, Throwable cause) {
        super(message, cause);
    }
}
