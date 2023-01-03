import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Sexo extends AbstractEntity {
  String sigla;

  Sexo({required super.id, required super.nombre, required this.sigla});

  Sexo copyWith({
    int? id,
    String? nombre,
    String? sigla,
  }) =>
      Sexo(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        sigla: sigla ?? this.sigla,
      );

  factory Sexo.fromMap(Map<String, dynamic> json) => Sexo(
        id: json["id"] == null ? null : json["id"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        sigla: json["sigla"] == null ? null : json["sigla"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "nombre": nombre == null ? null : nombre,
        "sigla": sigla == null ? null : sigla,
      };
}
