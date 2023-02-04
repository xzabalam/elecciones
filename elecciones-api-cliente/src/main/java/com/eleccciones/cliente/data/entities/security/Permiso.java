package com.eleccciones.cliente.data.entities.security;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.eleccciones.cliente.data.entities.core.impl.AbstractEntity;
import com.eleccciones.cliente.data.enums.EntityStateEnum;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;


@Entity
@Table(name = "permiso")
public class Permiso extends AbstractEntity implements Serializable {

	private static final long serialVersionUID = 7633379909000709682L;

	@ManyToOne
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JoinColumn(name = "id_usuario", referencedColumnName = "id")
	private Usuario usuario;

	@ManyToOne(cascade = CascadeType.REMOVE)
	@JoinColumn(name = "id_rol", referencedColumnName = "id")
	private Rol rol;

	public Permiso() {
	}

	public Permiso(Usuario usuario, Rol rol) {
		this.usuario = usuario;
		this.rol = rol;
		this.setFechaCrea(new Date());
		this.setEstado(EntityStateEnum.ACTIVO.getEstado());
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (!super.equals(obj) || getClass() != obj.getClass()) {
			return false;
		}
		final Permiso other = (Permiso) obj;
		return Objects.equals(rol, other.rol) && Objects.equals(usuario, other.usuario);
	}

	public Rol getRol() {
		return rol;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		final int result = super.hashCode();
		return prime * result + Objects.hash(rol, usuario);
	}

	public void setRol(Rol rol) {
		this.rol = rol;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	@Override
	public String toString() {
		return "UsuarioRol [" + (usuario != null ? "usuario=" + usuario + ", " : "") + (rol != null ? "rol=" + rol : "")
				+ "]";
	}

}
