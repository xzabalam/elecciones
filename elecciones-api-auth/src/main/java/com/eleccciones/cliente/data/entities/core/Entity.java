package com.eleccciones.cliente.data.entities.core;

import java.io.Serializable;

/**
 * @author xzabalam
 *
 */
public interface Entity extends Serializable {

	int getId();

	void setId(int id);

	String getEstado();

	void setEstado(String estado);
}
