package com.eleccciones.cliente.data.entities.ubicacion;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "circunscripcion", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre", "sigla"})})
@Getter
@Setter
public class Circunscripcion extends AbstractNamed {

    @NotNull
    @NotEmpty
    @Column(name = "sigla", nullable = false)
    private String sigla;

}
