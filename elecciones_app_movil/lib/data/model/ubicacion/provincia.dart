import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Provincia extends AbstractEntity {
  Provincia({required super.id, required super.nombre});

  factory Provincia.fromMap(Map<String, dynamic> json) => Provincia(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
