package com.eleccciones.cliente.data.entities.security;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "rol", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
public class Rol extends AbstractNamed {

}
