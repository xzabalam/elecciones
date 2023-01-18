package com.eleccciones.cliente.data.entities.estadisticas;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Entity
@Table(name = "est_voto_dignidad")
@Getter
@Setter
public class EstadisticaVotoDignidad {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @Column(name = "id_proceso")
    private Integer idProceso;

    @NotNull
    @Column(name = "proceso")
    private String proceso;

    @NotNull

    @Column(name = "id_dignidad")
    private Integer idDignidad;

    @NotNull
    @Column(name = "dignidad")
    private String dignidad;

    @NotNull
    @Column(name = "id_dignidad_ubicacion")
    private Integer idDignidadUbicacion;

    @NotNull
    @Column(name = "id_tipo_ubicacion")
    private Integer idTipoUbicacion;

    @NotNull
    @Column(name = "tipo_ubicacion")
    private String tipoUbicacion;

    @Column(name = "id_pais")
    private Integer idPais;

    @Column(name = "pais")
    private String pais;

    @Column(name = "id_provincia")
    private Integer idProvincia;

    @Column(name = "provincia")
    private String provincia;

    @Column(name = "id_canton")
    private Integer idCanton;

    @Column(name = "canton")
    private String canton;

    @Column(name = "id_parroquia")
    private Integer idParroquia;

    @Column(name = "parroquia")
    private String parroquia;

    @Column(name = "id_circunscripcion")
    private Integer idCircunscripcion;

    @Column(name = "circunscripcion")
    private String circunscripcion;

    @Column(name = "sigla_circunscripcion")
    private String siglaCircunscripcion;

    @NotNull
    @Column(name = "id_contrato")
    private Integer idContrato;

    @NotNull
    @Column(name = "contrato")
    private String contrato;

    @NotNull
    @Column(name = "id_movimiento")
    private Integer idMovimiento;

    @NotNull
    @Column(name = "movimiento")
    private String movimiento;

    @Column(name = "numero_movimiento")
    private String numeroMovimiento;

    @NotNull
    @Column(name = "siglas_movimiento")
    private String siglasMovimiento;

    @NotNull
    @Column(name = "id_grupo_candidato")
    private Integer idGrupoMovimiento;

    @NotNull
    @Column(name = "cantidad_voto")
    private Integer cantidadVoto;

    @NotNull
    @Column(name = "fecha_crea", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @JsonIgnore
    private Date fechaCrea;

    @Column(name = "fecha_modifica")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonIgnore
    private Date fechaModifica;

    @Column(name = "usuario_crea", nullable = false)
    @JsonIgnore
    private int usuarioCrea;

    @Column(name = "usuario_modifica")
    @JsonIgnore
    private int usuarioModifica;

    @NotNull
    @NotEmpty
    @Column(name = "estado")
    @JsonIgnore
    private String estado;
}
