package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "dignidad", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
@Getter
@Setter
public class Dignidad extends AbstractNamed {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_proceso", referencedColumnName = "id")
    private Proceso proceso;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="id_tipo_grupo", referencedColumnName = "id")
    private TipoGrupo tipoGrupo;

    @NotNull
    @Column(name = "numero")
    private Integer numero;
}
