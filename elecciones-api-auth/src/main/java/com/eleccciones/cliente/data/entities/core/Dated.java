package com.eleccciones.cliente.data.entities.core;

import java.io.Serializable;
import java.util.Date;

/**
 * @author xzabalam
 *
 */
public interface Dated extends Serializable {
	Date getFechaCrea();

	Date getFechaModifica();

	void setFechaCrea(Date fechaCrea);

	void setFechaModifica(Date fechaModifica);
}
