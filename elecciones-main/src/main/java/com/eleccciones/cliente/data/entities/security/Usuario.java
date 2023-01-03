package com.eleccciones.cliente.data.entities.security;

import com.eleccciones.cliente.data.entities.candidatos.Contrato;
import com.eleccciones.cliente.data.entities.candidatos.Entidad;
import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;


@Entity
@Table(name = "usuario", uniqueConstraints = {@UniqueConstraint(columnNames = {"login"})})
@Getter
@Setter
public class Usuario extends AbstractEntity implements Serializable {
    private static final long serialVersionUID = -7310305185273678943L;

    @NotEmpty
    @Column(name = "login", nullable = false)
    @Size(min = 10, max = 25, message = "{entity.auditoria.username}")
    private String username;

    @NotEmpty
    @JsonIgnore
    @Column(name = "clave", nullable = false)
    private String password;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_entidad", referencedColumnName = "id")
    private Entidad entidad;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_contrato", referencedColumnName = "id")
    private Contrato contrato;

    @NotNull
    @Column(name = "activo")
    private String activo;

    @Column(name = "habilitado_movil")
    private Integer habilitadoMovil;

    @Column(name = "sesion_movil")
    private Integer sessionMovil;

    @Column(name = "mac_movil")
    private String macMovil;

    @Column(name = "habilitado_web")
    private Integer habilitadoWeb;

    @Column(name = "sesion_web")
    private Integer sessionWeb;
    
    @Override
    public String toString() {
        return "Usuario [" + (username != null ? "username=" + username + ", " : "")
                + (password != null ? "password=" + password : "") + "]";
    }
}
