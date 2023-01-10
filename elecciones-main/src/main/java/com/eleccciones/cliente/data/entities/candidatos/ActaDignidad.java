package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Table(name = "acta_dignidad")
@Getter
@Setter
public class ActaDignidad extends AbstractEntity {

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "id_junta", referencedColumnName = "id")
    private Junta junta;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_dignidad_ubicacion", referencedColumnName = "id")
    private DignidadUbicacion dignidadUbicacion;

    @Column(name = "identificacion")
    private String identificacion;

    @Lob
    @Type(type = "org.hibernate.type.ImageType")
    @Column(name = "acta_archivo")
    private byte[] actaArchivo;

    @Column(name = "acta_nombre")
    private String actaNombre;

    @Column(name = "descripcion")
    private String actaDescripcion;
}
