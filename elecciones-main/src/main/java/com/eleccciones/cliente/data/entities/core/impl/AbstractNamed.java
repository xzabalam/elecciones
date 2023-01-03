package com.eleccciones.cliente.data.entities.core.impl;

import com.eleccciones.cliente.data.entities.core.Named;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@MappedSuperclass
public abstract class AbstractNamed extends AbstractEntity implements Named {
    private static final long serialVersionUID = -412218241272244614L;

    @NotNull
    @NotEmpty
    @Column(name = "nombre")
    private String nombre;

    @Override
    public String getNombre() {
        return nombre;
    }

    @Override
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
