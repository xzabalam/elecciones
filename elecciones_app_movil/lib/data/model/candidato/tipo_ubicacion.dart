import 'package:equatable/equatable.dart';

class TipoUbicacion extends Equatable {
  TipoUbicacion({
    required this.id,
    required this.nombre,
    required this.tablaUbicacion,
  });

  int id;
  String nombre;
  String tablaUbicacion;

  TipoUbicacion copyWith({
    int? id,
    String? nombre,
    String? tablaUbicacion,
  }) =>
      TipoUbicacion(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        tablaUbicacion: tablaUbicacion ?? this.tablaUbicacion,
      );

  factory TipoUbicacion.fromMap(Map<String, dynamic> json) => TipoUbicacion(
        id: json["id"],
        nombre: json["nombre"],
        tablaUbicacion: json["tablaUbicacion"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "tablaUbicacion": tablaUbicacion,
      };

  @override
  List<Object?> get props => [id, nombre];

  @override
  String toString() {
    return 'TipoUbicacion{id: $id, nombre: $nombre, tablaUbicacion: $tablaUbicacion}';
  }
}
