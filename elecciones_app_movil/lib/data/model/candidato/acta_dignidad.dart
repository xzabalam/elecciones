import 'package:elecciones_app_movil/data/model/candidato/dignidad_ubicacion.dart';

class ActaDignidad {
  ActaDignidad(
      {required this.id,
      required this.dignidadUbicacion,
      required this.identificacion,
      required this.actaArchivo,
      required this.actaNombre,
      required this.actaDescripcion,
      required this.escrutada});

  int id;
  DignidadUbicacion dignidadUbicacion;
  String identificacion;
  dynamic actaArchivo;
  String actaNombre;
  String actaDescripcion;
  int escrutada;

  ActaDignidad copyWith(
          {int? id,
          DignidadUbicacion? dignidadUbicacion,
          String? identificacion,
          dynamic actaArchivo,
          String? actaNombre,
          String? actaDescripcion,
          int? escrutada}) =>
      ActaDignidad(
          id: id ?? this.id,
          dignidadUbicacion: dignidadUbicacion ?? this.dignidadUbicacion,
          identificacion: identificacion ?? this.identificacion,
          actaArchivo: actaArchivo ?? this.actaArchivo,
          actaNombre: actaNombre ?? this.actaNombre,
          actaDescripcion: actaDescripcion ?? this.actaDescripcion,
          escrutada: escrutada ?? this.escrutada);

  factory ActaDignidad.fromMap(Map<String, dynamic> json) => ActaDignidad(
      id: json["id"],
      dignidadUbicacion: DignidadUbicacion?.fromMap(json["dignidadUbicacion"]),
      identificacion: json["identificacion"],
      actaArchivo: json["actaArchivo"],
      actaNombre: json["actaNombre"],
      actaDescripcion: json["actaDescripcion"],
      escrutada: json["escrutada"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "dignidadUbicacion": dignidadUbicacion?.toMap(),
        "identificacion": identificacion,
        "actaArchivo": actaArchivo,
        "actaNombre": actaNombre,
        "actaDescripcion": actaDescripcion,
        "escrutada": escrutada
      };

  @override
  String toString() {
    return 'ActaDignidad{id: $id, dignidadUbicacion: $dignidadUbicacion, identificacion: $identificacion, actaArchivo: $actaArchivo, actaNombre: $actaNombre, actaDescripcion: $actaDescripcion, escrutada: $escrutada}';
  }
}
