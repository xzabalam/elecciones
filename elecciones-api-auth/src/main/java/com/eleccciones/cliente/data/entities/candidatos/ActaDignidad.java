package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import com.eleccciones.cliente.data.entities.ubicacion.Junta;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.concurrent.locks.StampedLock;

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

    @Column(name = "escrutada")
    private Integer escrutada;

    @Transient
    @JsonIgnore
    private StampedLock lock;

    public ActaDignidad() {
        this.lock = new StampedLock();
    }
}
