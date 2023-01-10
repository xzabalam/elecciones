package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "tipo_ubicacion", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
@Getter
@Setter
public class TipoUbicacion extends AbstractNamed {

    @NotNull
    @Column(name = "tabla_ubicacion")
    private String tablaUbicacion;
}
