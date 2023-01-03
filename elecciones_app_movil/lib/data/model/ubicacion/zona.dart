import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Zona extends AbstractEntity {
  int codigoZona;

  Zona({required super.id, required super.nombre, required this.codigoZona});

  factory Zona.fromMap(Map<String, dynamic> json) => Zona(
      id: json["id"], nombre: json["nombre"], codigoZona: json["codigoZona"]);

  Map<String, dynamic> toMap() =>
      {"id": id, "nombre": nombre, "codigoZona": codigoZona};
}
