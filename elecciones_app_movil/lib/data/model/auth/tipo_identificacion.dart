class TipoIdentificacion {
  TipoIdentificacion({this.id, this.nombre, this.sigla});

  int? id;
  String? nombre;
  String? sigla;

  TipoIdentificacion copyWith({
    int? id,
    String? nombre,
    String? sigla,
  }) =>
      TipoIdentificacion(id: id ?? this.id, nombre: nombre ?? this.nombre, sigla: sigla ?? this.sigla);

  factory TipoIdentificacion.fromJson(Map<String, dynamic> json) => TipoIdentificacion(
        id: json["id"],
        nombre: json["nombre"],
        sigla: json["sigla"],
      );

  @override
  String toString() {
    return 'TipoIdentificacion{id: $id, nombre: $nombre, sigla: $sigla}';
  }

  Map<String, dynamic> toJson() => {"id": id, "nombre": nombre, "sigla": sigla};
}
