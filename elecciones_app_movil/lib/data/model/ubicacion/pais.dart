import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Pais extends AbstractEntity {
  Pais({required super.id, required super.nombre});

  factory Pais.fromMap(Map<String, dynamic> json) => Pais(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
