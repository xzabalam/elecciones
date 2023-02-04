package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "proceso", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
public class Proceso extends AbstractNamed {
}
