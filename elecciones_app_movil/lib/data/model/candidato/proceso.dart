import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Proceso extends AbstractEntity {
  Proceso({
    required super.id,
    required super.nombre,
  });

  Proceso copyWith({
    int? id,
    String? nombre,
  }) =>
      Proceso(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );

  factory Proceso.fromMap(Map<String, dynamic> json) => Proceso(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };

  @override
  String toString() {
    return 'Proceso{id: $id, nombre: $nombre}';
  }
}
