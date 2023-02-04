package com.eleccciones.cliente.common.exception;

public class UbicacionException extends RuntimeException {
    public UbicacionException() {
        super();
    }

    public UbicacionException(String message) {
        super(message);
    }

    public UbicacionException(String message, Throwable cause) {
        super(message, cause);
    }
}
