class DignidadDto {
  DignidadDto({
    required this.id,
    required this.nombre,
  });

  final int? id;
  final String? nombre;

  DignidadDto copyWith({
    int? id,
    String? nombre,
  }) =>
      DignidadDto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );

  factory DignidadDto.fromJson(Map<String, dynamic> json) => DignidadDto(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };

  @override
  String toString() {
    return 'DignidadDto{id: $id, nombre: $nombre}';
  }
}
