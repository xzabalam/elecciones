package com.eleccciones.cliente.data.entities.core.impl;

import com.eleccciones.cliente.data.entities.core.Auditable;
import com.eleccciones.cliente.data.entities.core.Entity;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * Clase abstracta que contiene toda la información común a todas las entidades.
 *
 * @author xzabalam
 */
@MappedSuperclass
public abstract class AbstractEntity implements Entity, Auditable {
    private static final long serialVersionUID = -412218241272244613L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @Column(name = "fecha_crea", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @JsonIgnore
    private Date fechaCrea;

    @Column(name = "fecha_modifica")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonIgnore
    private Date fechaModifica;

    @Column(name = "id_usuario_crea", nullable = false)
    @JsonIgnore
    private int usuarioCrea;

    @Column(name = "id_usuario_modifica")
    @JsonIgnore
    private int usuarioModifica;

    @NotNull
    @NotEmpty
    @Column(name = "estado")
    @JsonIgnore
    private String estado;

    @Override
    public String getEstado() {
        return estado;
    }

    @Override
    public void setEstado(String estado) {
        this.estado = estado;
    }


    @Override
    public Date getFechaCrea() {
        return fechaCrea;
    }

    @Override
    public void setFechaCrea(Date fechaCrea) {
        this.fechaCrea = fechaCrea;
    }

    @Override
    public Date getFechaModifica() {
        return fechaModifica;
    }

    @Override
    public void setFechaModifica(Date fechaModifica) {
        this.fechaModifica = fechaModifica;
    }

    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }

    @Override
    public int getUsuarioCrea() {
        return usuarioCrea;
    }

    @Override
    public void setUsuarioCrea(int usuarioCrea) {
        this.usuarioCrea = usuarioCrea;
    }

    @Override
    public int getUsuarioModifica() {
        return usuarioModifica;
    }

    @Override
    public void setUsuarioModifica(int usuarioModifica) {
        this.usuarioModifica = usuarioModifica;
    }


}
