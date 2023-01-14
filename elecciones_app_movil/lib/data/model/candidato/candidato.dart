class Candidato {
  Candidato({
    this.id,
    this.nombre,
    this.tipo,
    this.orden,
    this.fotoArchivo,
    this.fotoNombre,
  });

  int? id;
  String? nombre;
  String? tipo;
  int? orden;
  dynamic fotoArchivo;
  dynamic fotoNombre;

  Candidato copyWith({
    int? id,
    String? nombre,
    String? tipo,
    int? orden,
    dynamic fotoArchivo,
    dynamic fotoNombre,
  }) =>
      Candidato(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        tipo: tipo ?? this.tipo,
        orden: orden ?? this.orden,
        fotoArchivo: fotoArchivo ?? this.fotoArchivo,
        fotoNombre: fotoNombre ?? this.fotoNombre,
      );

  factory Candidato.fromMap(Map<String, dynamic> json) => Candidato(
        id: json["id"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        orden: json["orden"],
        fotoArchivo: json["fotoArchivo"],
        fotoNombre: json["fotoNombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "tipo": tipo,
        "orden": orden,
        "fotoArchivo": fotoArchivo,
        "fotoNombre": fotoNombre,
      };

  @override
  String toString() {
    return 'Candidato{id: $id, nombre: $nombre, tipo: $tipo, orden: $orden, fotoArchivo: $fotoArchivo, fotoNombre: $fotoNombre}';
  }
}
