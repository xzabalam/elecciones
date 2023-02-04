package com.eleccciones.cliente.data.entities.candidatos;


import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Entity
@Table(name = "entidad", uniqueConstraints = {@UniqueConstraint(columnNames = {"identificacion"})})
@Getter
@Setter
public class Entidad extends AbstractNamed {

    @NotNull
    @Column(name = "identificacion", nullable = false)
    private String identificacion;

    @Column(name = "fecha_nacimiento")
    @Temporal(TemporalType.DATE)
    private Date fechaNacimiento;

    @Column(name = "mail")
    private String mail;

    @Column(name = "etnia")
    private String etnia;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_tipo_identificacion", referencedColumnName = "id")
    private TipoIdentificacion tipoIdentificacion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_sexo", referencedColumnName = "id")
    private Sexo sexo;
}
