package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "voto")
@Getter
@Setter
public class Voto extends AbstractEntity {

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_acta_dignidad", referencedColumnName = "id")
    private ActaDignidad actaDignidad;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_grupo_candidato", referencedColumnName = "id")
    private GrupoCandidato grupoCandidato;

    @NotNull
    @Column(name = "cantidad")
    private Integer cantidad;

}
