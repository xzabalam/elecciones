import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Canton extends AbstractEntity {
  Canton({required super.id, required super.nombre});

  factory Canton.fromMap(Map<String, dynamic> json) => Canton(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
