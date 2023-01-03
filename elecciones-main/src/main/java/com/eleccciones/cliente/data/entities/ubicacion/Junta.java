package com.eleccciones.cliente.data.entities.ubicacion;

import com.eleccciones.cliente.data.entities.candidatos.Sexo;
import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "junta")
@Getter
@Setter
public class Junta extends AbstractEntity {

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "id_recinto", referencedColumnName = "id")
    private Recinto recinto;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_sexo", referencedColumnName = "id")
    private Sexo sexo;

    @Column(name = "numero")
    private String numero;

    @Column(name = "numero_electores")
    private Integer numeroElectores;

    @Column(name = "utilizada")
    private Integer utilizada;
}
