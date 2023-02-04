package com.eleccciones.cliente.data.entities.ubicacion;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "provincia", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
@Getter
@Setter
public class Provincia extends AbstractNamed {

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_pais", referencedColumnName = "id")
    private Pais pais;
}
