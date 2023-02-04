package com.eleccciones.cliente.data.entities.ubicacion;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "parroquia", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
@Getter
@Setter
public class Parroquia extends AbstractNamed {
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_canton", referencedColumnName = "id")
    private Canton canton;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "id_circunscripcion", referencedColumnName = "id")
    private Circunscripcion circunscripcion;

    @NotNull
    @NotEmpty
    @Column(name = "sigla_circunscripcion", nullable = false)
    private String siglaCircunscripcion;
}
