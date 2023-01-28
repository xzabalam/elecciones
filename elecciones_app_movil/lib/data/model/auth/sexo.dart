class Sexo {
  Sexo({this.id, this.nombre, this.sigla});

  int? id;
  String? nombre;
  String? sigla;

  Sexo copyWith({
    int? id,
    String? nombre,
    String? sigla,
  }) =>
      Sexo(id: id ?? this.id, nombre: nombre ?? this.nombre, sigla: sigla ?? this.sigla);

  factory Sexo.fromJson(Map<String, dynamic> json) => Sexo(
        id: json["id"],
        nombre: json["nombre"],
        sigla: json["sigla"],
      );

  @override
  String toString() {
    return 'Sexo{id: $id, nombre: $nombre, sigla: $sigla}';
  }

  Map<String, dynamic> toJson() => {"id": id, "nombre": nombre, "sigla": sigla};
}
