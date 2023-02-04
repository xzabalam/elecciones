package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Table(name = "grupo_candidato")
@Getter
@Setter
public class GrupoCandidato extends AbstractNamed {

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_contrato", referencedColumnName = "id")
    @JsonIgnore
    private Contrato contrato;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_movimiento", referencedColumnName = "id")
    private Movimiento movimiento;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_dignidad_ubicacion", referencedColumnName = "id")
    private DignidadUbicacion dignidadUbicacion;

    @Lob
    @Type(type = "org.hibernate.type.ImageType")
    @Column(name = "foto_archivo")
    private byte[] fotoArchivo;

    @Column(name = "foto_nombre")
    private String fotoNombre;

    @OneToMany(mappedBy = "grupoCandidato")
    private List<Candidato> candidatos;
}
