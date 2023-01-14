import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class TipoGrupo extends AbstractEntity {
  TipoGrupo({
    required super.id,
    required super.nombre,
  });

  TipoGrupo copyWith({
    int? id,
    String? nombre,
  }) =>
      TipoGrupo(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );

  factory TipoGrupo.fromMap(Map<String, dynamic> json) =>
      TipoGrupo(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "nombre": nombre,
      };

  @override
  String toString() {
    return 'Proceso{id: $id, nombre: $nombre}';
  }

}
