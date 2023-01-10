class Movimiento {
  Movimiento({
    this.id,
    this.nombre,
    this.siglas,
    this.numero,
    this.fotoArchivo,
    this.fotoNombre,
  });

  int? id;
  String? nombre;
  String? siglas;
  String? numero;
  dynamic fotoArchivo;
  String? fotoNombre;

  Movimiento copyWith({
    int? id,
    String? nombre,
    String? siglas,
    String? numero,
    dynamic fotoArchivo,
    String? fotoNombre,
  }) =>
      Movimiento(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        siglas: siglas ?? this.siglas,
        numero: numero ?? this.numero,
        fotoArchivo: fotoArchivo ?? this.fotoArchivo,
        fotoNombre: fotoNombre ?? this.fotoNombre,
      );

  factory Movimiento.fromMap(Map<String, dynamic> json) => Movimiento(
        id: json["id"],
        nombre: json["nombre"],
        siglas: json["siglas"],
        numero: json["numero"],
        fotoArchivo: json["fotoArchivo"],
        fotoNombre: json["fotoNombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "siglas": siglas,
        "numero": numero,
        "fotoArchivo": fotoArchivo,
        "fotoNombre": fotoNombre,
      };
}
