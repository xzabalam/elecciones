import 'package:elecciones_app_movil/data/model/core/abstract_entity.dart';

class Recinto extends AbstractEntity {
  String siglaCircunscripcion;
  String direccion;
  double longitud;
  double latitud;
  int juntasMasculino;
  int juntasFemenino;
  int juntasTotal;
  int juntaInicialFemenino;
  int juntaFinalFemenino;
  int juntaInicialMasculino;
  int juntaFinalMasculino;
  int electoresHombres;
  int electoresMujeres;
  int electoresTotal;

  Recinto(
      {required super.id,
      required super.nombre,
      required this.siglaCircunscripcion,
      required this.direccion,
      required this.longitud,
      required this.latitud,
      required this.juntasMasculino,
      required this.juntasFemenino,
      required this.juntasTotal,
      required this.juntaInicialFemenino,
      required this.juntaFinalFemenino,
      required this.juntaInicialMasculino,
      required this.juntaFinalMasculino,
      required this.electoresHombres,
      required this.electoresMujeres,
      required this.electoresTotal});

  Recinto copyWith({
    int? id,
    String? nombre,
    String? siglaCircunscripcion,
    String? direccion,
    double? longitud,
    double? latitud,
    int? juntasMasculino,
    int? juntasFemenino,
    int? juntasTotal,
    int? juntaInicialFemenino,
    int? juntaFinalFemenino,
    int? juntaInicialMasculino,
    int? juntaFinalMasculino,
    int? electoresHombres,
    int? electoresMujeres,
    int? electoresTotal,
  }) =>
      Recinto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        siglaCircunscripcion: siglaCircunscripcion ?? this.siglaCircunscripcion,
        direccion: direccion ?? this.direccion,
        longitud: longitud ?? this.longitud,
        latitud: latitud ?? this.latitud,
        juntasMasculino: juntasMasculino ?? this.juntasMasculino,
        juntasFemenino: juntasFemenino ?? this.juntasFemenino,
        juntasTotal: juntasTotal ?? this.juntasTotal,
        juntaInicialFemenino: juntaInicialFemenino ?? this.juntaInicialFemenino,
        juntaFinalFemenino: juntaFinalFemenino ?? this.juntaFinalFemenino,
        juntaInicialMasculino:
            juntaInicialMasculino ?? this.juntaInicialMasculino,
        juntaFinalMasculino: juntaFinalMasculino ?? this.juntaFinalMasculino,
        electoresHombres: electoresHombres ?? this.electoresHombres,
        electoresMujeres: electoresMujeres ?? this.electoresMujeres,
        electoresTotal: electoresTotal ?? this.electoresTotal,
      );

  factory Recinto.fromMap(Map<String, dynamic> json) => Recinto(
        id: json["id"] == null ? null : json["id"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        siglaCircunscripcion: json["siglaCircunscripcion"] == null
            ? null
            : json["siglaCircunscripcion"],
        direccion: json["direccion"] == null ? null : json["direccion"],
        longitud: json["longitud"] == null ? null : json["longitud"].toDouble(),
        latitud: json["latitud"] == null ? null : json["latitud"].toDouble(),
        juntasMasculino:
            json["juntasMasculino"] == null ? null : json["juntasMasculino"],
        juntasFemenino:
            json["juntasFemenino"] == null ? null : json["juntasFemenino"],
        juntasTotal: json["juntasTotal"] == null ? null : json["juntasTotal"],
        juntaInicialFemenino: json["juntaInicialFemenino"] == null
            ? null
            : json["juntaInicialFemenino"],
        juntaFinalFemenino: json["juntaFinalFemenino"] == null
            ? null
            : json["juntaFinalFemenino"],
        juntaInicialMasculino: json["juntaInicialMasculino"] == null
            ? null
            : json["juntaInicialMasculino"],
        juntaFinalMasculino: json["juntaFinalMasculino"] == null
            ? null
            : json["juntaFinalMasculino"],
        electoresHombres:
            json["electoresHombres"] == null ? null : json["electoresHombres"],
        electoresMujeres:
            json["electoresMujeres"] == null ? null : json["electoresMujeres"],
        electoresTotal:
            json["electoresTotal"] == null ? null : json["electoresTotal"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "nombre": nombre == null ? null : nombre,
        "siglaCircunscripcion":
            siglaCircunscripcion == null ? null : siglaCircunscripcion,
        "direccion": direccion == null ? null : direccion,
        "longitud": longitud == null ? null : longitud,
        "latitud": latitud == null ? null : latitud,
        "juntasMasculino": juntasMasculino == null ? null : juntasMasculino,
        "juntasFemenino": juntasFemenino == null ? null : juntasFemenino,
        "juntasTotal": juntasTotal == null ? null : juntasTotal,
        "juntaInicialFemenino":
            juntaInicialFemenino == null ? null : juntaInicialFemenino,
        "juntaFinalFemenino":
            juntaFinalFemenino == null ? null : juntaFinalFemenino,
        "juntaInicialMasculino":
            juntaInicialMasculino == null ? null : juntaInicialMasculino,
        "juntaFinalMasculino":
            juntaFinalMasculino == null ? null : juntaFinalMasculino,
        "electoresHombres": electoresHombres == null ? null : electoresHombres,
        "electoresMujeres": electoresMujeres == null ? null : electoresMujeres,
        "electoresTotal": electoresTotal == null ? null : electoresTotal,
      };
}
