package com.eleccciones.cliente.bussiness.services.builder;

import com.eleccciones.cliente.data.enums.EntityStateEnum;
import com.eleccciones.cliente.data.entities.security.Rol;

import java.util.Date;

public class RolBuilder {

	private static Rol rol;

	public static RolBuilder newBuilder() {
		rol = new Rol();
		return new RolBuilder();
	}

	public Rol build() {
		rol.setFechaCrea(new Date());
		rol.setEstado(EntityStateEnum.ACTIVO.getEstado());
		return rol;
	}


	public RolBuilder nombre(String nombre) {
		rol.setNombre(nombre);
		return this;
	}

	public RolBuilder usuarioCrea(int idUsuarioCrea) {
		rol.setUsuarioCrea(idUsuarioCrea);
		return this;
	}
}
