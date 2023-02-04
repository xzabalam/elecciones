package com.eleccciones.cliente.data.entities.core;

/**
 *
 * @author xzabalam
 *
 */
public interface Auditable extends Dated {
	int getUsuarioCrea();

	int getUsuarioModifica();

	void setUsuarioCrea(int usuarioCrea);

	void setUsuarioModifica(int usuarioModifica);
}
