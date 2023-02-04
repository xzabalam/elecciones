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
@Table(name = "zona", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
@Getter
@Setter
public class Zona extends AbstractNamed {

    @Column(name = "codigo")
    private Integer codigoZona;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_parroquia", referencedColumnName = "id")
    private Parroquia parroquia;
}
