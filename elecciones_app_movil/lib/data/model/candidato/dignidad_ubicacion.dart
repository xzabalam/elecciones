import 'package:elecciones_app_movil/data/model/candidato/dignidad.dart';
import 'package:elecciones_app_movil/data/model/candidato/tipo_ubicacion.dart';
import 'package:equatable/equatable.dart';

class DignidadUbicacion extends Equatable {
  DignidadUbicacion({
    required this.id,
    required this.dignidad,
    required this.tipoUbicacion,
    required this.tablaUbicacion,
    required this.idTablaUbicacion,
    required this.cargo,
    required this.siglaCircunscripcion,
  });

  int id;
  Dignidad dignidad;
  TipoUbicacion tipoUbicacion;
  String tablaUbicacion;
  int idTablaUbicacion;
  String cargo;
  String siglaCircunscripcion;

  DignidadUbicacion copyWith({
    int? id,
    Dignidad? dignidad,
    TipoUbicacion? tipoUbicacion,
    String? tablaUbicacion,
    int? idTablaUbicacion,
    String? cargo,
    String? siglaCircunscripcion,
  }) =>
      DignidadUbicacion(
        id: id ?? this.id,
        dignidad: dignidad ?? this.dignidad,
        tipoUbicacion: tipoUbicacion ?? this.tipoUbicacion,
        tablaUbicacion: tablaUbicacion ?? this.tablaUbicacion,
        idTablaUbicacion: idTablaUbicacion ?? this.idTablaUbicacion,
        cargo: cargo ?? this.cargo,
        siglaCircunscripcion: siglaCircunscripcion ?? this.siglaCircunscripcion,
      );

  factory DignidadUbicacion.fromMap(Map<String, dynamic> json) =>
      DignidadUbicacion(
        id: json["id"],
        dignidad: Dignidad.fromMap(json["dignidad"]),
        tipoUbicacion: TipoUbicacion.fromMap(json["tipoUbicacion"]),
        tablaUbicacion: json["tablaUbicacion"],
        idTablaUbicacion: json["idTablaUbicacion"],
        cargo: json["cargo"],
        siglaCircunscripcion: json["siglaCircunscripcion"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "dignidad": dignidad?.toMap(),
        "tipoUbicacion": tipoUbicacion?.toMap(),
        "tablaUbicacion": tablaUbicacion,
        "idTablaUbicacion": idTablaUbicacion,
        "cargo": cargo,
        "siglaCircunscripcion": siglaCircunscripcion,
      };

  @override
  List<Object?> get props => [id, dignidad, tipoUbicacion, cargo];
}
