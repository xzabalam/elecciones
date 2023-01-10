class VotoSeleccionadoModel {
  int? idVoto;
  int? idActaDignidad;
  int? idJunta;
  int? cantidadVoto;

  VotoSeleccionadoModel(
      {this.idVoto, this.idActaDignidad, this.idJunta, this.cantidadVoto});

  VotoSeleccionadoModel copyWith({
    int? idVoto,
    int? idActaDignidad,
    int? idJunta,
    int? cantidadVoto,
    bool? seGuardoVoto
  }) =>
      VotoSeleccionadoModel(
        idVoto: idVoto ?? this.idVoto,
        idActaDignidad: idActaDignidad ?? this.idActaDignidad,
        idJunta: idJunta ?? this.idJunta,
        cantidadVoto: cantidadVoto ?? this.cantidadVoto,
      );
}
