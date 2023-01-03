import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Parroquia extends AbstractEntity {
  String siglaCircunscripcion;

  Parroquia(
      {required super.id,
      required super.nombre,
      required this.siglaCircunscripcion});

  factory Parroquia.fromMap(Map<String, dynamic> json) => Parroquia(
      id: json["id"],
      nombre: json["nombre"],
      siglaCircunscripcion: json["siglaCircunscripcion"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "siglaCircunscripcion": siglaCircunscripcion
      };
}
