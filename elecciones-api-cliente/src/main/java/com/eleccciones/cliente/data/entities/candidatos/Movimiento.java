package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

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
