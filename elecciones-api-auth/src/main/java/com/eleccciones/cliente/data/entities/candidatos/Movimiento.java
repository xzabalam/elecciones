package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "movimiento")
@Getter
@Setter
public class Movimiento extends AbstractNamed {

    @NotNull
    @Column(name = "siglas")
    private String siglas;

    @Column(name = "numero")
    private String numero;

    @Lob
    @Type(type="org.hibernate.type.ImageType")
    @Column(name = "foto_archivo")
    private byte[] fotoArchivo;

    @Column(name = "foto_nombre")
    private String fotoNombre;

}
