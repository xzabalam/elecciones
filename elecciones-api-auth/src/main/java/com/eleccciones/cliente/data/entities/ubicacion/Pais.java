package com.eleccciones.cliente.data.entities.ubicacion;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "pais", uniqueConstraints = { @UniqueConstraint(columnNames = { "nombre" }) })
public class Pais extends AbstractNamed {
}
