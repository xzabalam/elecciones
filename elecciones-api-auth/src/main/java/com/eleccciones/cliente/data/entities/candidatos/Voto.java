package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.concurrent.locks.StampedLock;

@Entity
@Table(name = "voto")
@Getter
@Setter
public class Voto extends AbstractEntity {

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_acta_dignidad", referencedColumnName = "id")
    private ActaDignidad actaDignidad;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_grupo_candidato", referencedColumnName = "id")
    private GrupoCandidato grupoCandidato;

    @NotNull
    @Column(name = "cantidad")
    private Integer cantidad;

    @Transient
    @JsonIgnore
    private StampedLock lock;

    public Voto() {
        this.lock = new StampedLock();
    }
}
