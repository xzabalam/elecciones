package com.eleccciones.cliente.common.util;

public enum TipoCandidatoEnum {
    PRINCIPAL("PRINCIPAL"), PRINCIPAL_PUNTO("PRINCIPAL.");

    private String nombre;

    TipoCandidatoEnum(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }
}
