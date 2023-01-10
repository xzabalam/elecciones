package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "dignidad_ubicacion")
@Getter
@Setter
public class DignidadUbicacion extends AbstractEntity {

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_dignidad", referencedColumnName = "id")
    private Dignidad dignidad;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_tipo_ubicacion", referencedColumnName = "id")
    private TipoUbicacion tipoUbicacion;

    @NotNull
    @Column(name = "tabla_ubicacion")
    private String tablaUbicacion;

    @NotNull
    @Column(name = "id_tabla_ubicacion")
    private Integer idTablaUbicacion;

    @Column(name = "cargo")
    private String cargo;

    @Column(name = "sigla_circunscripcion")
    private String siglaCircunscripcion;

}
