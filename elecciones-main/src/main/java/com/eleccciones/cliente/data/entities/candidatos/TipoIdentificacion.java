package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "tipo_identificacion", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
public class TipoIdentificacion extends AbstractNamed {
}
