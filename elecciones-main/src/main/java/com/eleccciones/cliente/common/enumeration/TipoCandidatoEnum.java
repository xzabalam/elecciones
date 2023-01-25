package com.eleccciones.cliente.common.enumeration;

public enum TipoCandidatoEnum {
    PRINCIPAL("PRINCIPAL"), PRINCIPAL_PUNTO("PRINCIPAL.");

    private final String nombre;

    TipoCandidatoEnum(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }
}
