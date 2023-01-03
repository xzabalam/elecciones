package com.eleccciones.cliente.common.util;

public enum EstadoEnum {
    ACTIVO("A"), INACTIVO("I"), CREADO("C");

    private String estado;

    EstadoEnum(String estado) {
        this.estado = estado;
    }

    public String getEstado() {
        return estado;
    }
}
