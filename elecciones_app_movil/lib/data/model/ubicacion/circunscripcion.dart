import 'package:equatable/equatable.dart';

class Circunscripcion extends Equatable {
  int? id;
  String? nombre;

  Circunscripcion({
    this.id,
    this.nombre,
  });

  Circunscripcion copyWith({
    int? id,
    String? nombre,
  }) =>
      Circunscripcion(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );

  factory Circunscripcion.fromJson(Map<String, dynamic> json) => Circunscripcion(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };

  @override
  List<Object?> get props => [id, nombre];
}
