package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "candidato")
@Getter
@Setter
public class Candidato extends AbstractNamed {

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_grupo_candidato", referencedColumnName = "id")
    @JsonIgnore
    private GrupoCandidato grupoCandidato;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_entidad", referencedColumnName = "id")
    @JsonIgnore
    private Entidad entidad;

    @Column(name = "tipo")
    private String tipo;

    @Column(name = "orden")
    private Integer orden;

    @Lob
    @Type(type="org.hibernate.type.ImageType")
    @Column(name = "foto_archivo")
    private byte[] fotoArchivo;

    @Column(name = "foto_nombre")
    private String fotoNombre;
}
