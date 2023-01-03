package com.eleccciones.cliente.data.entities.ubicacion;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "recinto", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
@Getter
@Setter
public class Recinto extends AbstractNamed {

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_zona", referencedColumnName = "id")
    private Zona zona;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "id_circunscripcion", referencedColumnName = "id")
    private Circunscripcion circunscripcion;

    @NotNull
    @NotEmpty
    @Column(name = "sigla_circunscripcion", nullable = false)
    private String siglaCircunscripcion;

    @Column(name = "direccion", nullable = false)
    private String direccion;

    @NotNull
    @Column(name = "longitud", nullable = false)
    private Double longitud;

    @NotNull
    @Column(name = "latitud", nullable = false)
    private Double latitud;

    @NotNull
    @Column(name = "juntas_masculino", nullable = false)
    private int juntasMasculino;

    @NotNull
    @Column(name = "juntas_femenino", nullable = false)
    private int juntasFemenino;

    @NotNull
    @Column(name = "juntas_total", nullable = false)
    private int juntasTotal;

    @NotNull
    @Column(name = "junta_inicial_femenino", nullable = false)
    private int juntaInicialFemenino;

    @NotNull
    @Column(name = "junta_final_femenino", nullable = false)
    private int juntaFinalFemenino;

    @NotNull
    @Column(name = "junta_inicial_masculino", nullable = false)
    private int juntaInicialMasculino;

    @NotNull
    @Column(name = "junta_final_masculino", nullable = false)
    private int juntaFinalMasculino;

    @NotNull
    @Column(name = "electores_hombres", nullable = false)
    private int electoresHombres;

    @NotNull
    @Column(name = "electores_mujeres", nullable = false)
    private int electoresMujeres;

    @NotNull
    @Column(name = "electores_total", nullable = false)
    private Integer electoresTotal;
}
