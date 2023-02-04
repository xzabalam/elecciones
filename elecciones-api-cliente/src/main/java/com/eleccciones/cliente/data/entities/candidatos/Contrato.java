package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Entity
@Table(name = "contrato", uniqueConstraints = {@UniqueConstraint(columnNames = {"identificacion"})})
@Getter
@Setter
public class Contrato extends AbstractNamed {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_entidad", referencedColumnName = "id")
    private Entidad entidad;

    @NotNull
    @Column(name = "identificacion")
    private String identificacion;

    @NotNull
    @Column(name = "sesiones")
    private Integer sesiones;

    @NotNull
    @Column(name = "sesiones_activas")
    private Integer sesionesActivas;

    @NotNull
    @Column(name = "suscripcion")
    private String suscripcion;

    @NotNull
    @Column(name = "juntas_suscritas")
    private Integer juntasSuscritas;

    @NotNull
    @Column(name = "juntas_usadas")
    private Integer juntasUsadas;

    @NotNull
    @Column(name = "activo")
    private String activo;

    @NotNull
    @Column(name = "fecha_inicio")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaInicio;

    @NotNull
    @Column(name = "fecha_fin")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaFin;

    @Column(name = "tiempo_restante")
    private String tiempoRestante;

    @Column(name = "url")
    private String url;

    @Lob
    @Type(type = "org.hibernate.type.ImageType")
    @Column(name = "foto_archivo")
    private byte[] fotoArchivo;

    @Column(name = "foto_nombre")
    private String fotoNombre;

    @Column(name = "fondo")
    private String fondo;

    @Column(name = "color")
    private String color;
}
