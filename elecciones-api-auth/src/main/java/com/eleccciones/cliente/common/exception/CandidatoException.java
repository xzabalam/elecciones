package com.eleccciones.cliente.common.exception;

public class CandidatoException extends RuntimeException {
    public CandidatoException() {
        super();
    }

    public CandidatoException(String message) {
        super(message);
    }

    public CandidatoException(String message, Throwable cause) {
        super(message, cause);
    }
}
