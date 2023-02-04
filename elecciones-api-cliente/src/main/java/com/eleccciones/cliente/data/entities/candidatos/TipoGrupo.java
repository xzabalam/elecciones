package com.eleccciones.cliente.data.entities.candidatos;

import com.eleccciones.cliente.data.entities.core.impl.AbstractNamed;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "tipo_grupo", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre"})})
public class TipoGrupo extends AbstractNamed {
}
