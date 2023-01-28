import 'package:elecciones_app_movil/data/model/auth/entidad.dart';

class Contrato {
  Contrato(
      {required this.id,
      required this.nombre,
      required this.entidad,
      required this.identificacion,
      required this.sesiones,
      required this.sesionesActivas,
      required this.suscripcion,
      required this.juntasSuscritas,
      required this.juntasUsadas,
      required this.activo,
      required this.fechaInicio,
      required this.fechaFin,
      required this.tiempoRestante,
      required this.url,
      required this.fotoArchivo,
      required this.fotoNombre,
      required this.fondo,
      required this.color});

  final int id;
  final String nombre;
  final Entidad entidad;
  final String identificacion;
  final int sesiones;
  final int sesionesActivas;
  final String suscripcion;
  final int juntasSuscritas;
  final int juntasUsadas;
  final String activo;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String tiempoRestante;
  final String url;
  final String fotoArchivo;
  final String fotoNombre;
  final String fondo;
  final String color;

  Contrato copyWith(
          {int? id,
          String? nombre,
          Entidad? entidad,
          String? identificacion,
          int? sesiones,
          int? sesionesActivas,
          String? suscripcion,
          int? juntasSuscritas,
          int? juntasUsadas,
          String? activo,
          DateTime? fechaInicio,
          DateTime? fechaFin,
          String? tiempoRestante,
          String? url,
          String? fotoArchivo,
          String? fotoNombre,
          String? fondo,
          String? color}) =>
      Contrato(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        entidad: entidad ?? this.entidad,
        identificacion: identificacion ?? this.identificacion,
        sesiones: sesiones ?? this.sesiones,
        sesionesActivas: sesionesActivas ?? this.sesionesActivas,
        suscripcion: suscripcion ?? this.suscripcion,
        juntasSuscritas: juntasSuscritas ?? this.juntasSuscritas,
        juntasUsadas: juntasUsadas ?? this.juntasUsadas,
        activo: activo ?? this.activo,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaFin: fechaFin ?? this.fechaFin,
        tiempoRestante: tiempoRestante ?? this.tiempoRestante,
        url: url ?? this.url,
        fotoArchivo: fotoArchivo ?? this.fotoArchivo,
        fotoNombre: fotoNombre ?? this.fotoNombre,
        fondo: fondo ?? this.fondo,
        color: color ?? this.color,
      );

  @override
  String toString() {
    return 'Contrato{id: $id, nombre: $nombre, entidad: $entidad, identificacion: $identificacion, sesiones: $sesiones, sesionesActivas: $sesionesActivas, suscripcion: $suscripcion, juntasSuscritas: $juntasSuscritas, juntasUsadas: $juntasUsadas, activo: $activo, fechaInicio: $fechaInicio, fechaFin: $fechaFin, tiempoRestante: $tiempoRestante, url: $url, fotoArchivo: $fotoArchivo, fotoNombre: $fotoNombre, fondo: $fondo, color: $color}';
  }

  factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
        nombre: json["nombre"],
        entidad: Entidad.fromJson(json["entidad"]),
        identificacion: json["identificacion"],
        sesiones: json["sesiones"],
        sesionesActivas: json["sesionesActivas"],
        suscripcion: json["suscripcion"],
        juntasSuscritas: json["juntasSuscritas"],
        juntasUsadas: json["juntasUsadas"],
        activo: json["activo"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        tiempoRestante: json["tiempoRestante"],
        url: json["url"],
        fotoArchivo: json["fotoArchivo"],
        fotoNombre: json["fotoNombre"],
        fondo: json["fondo"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "entidad": entidad.toJson(),
        "identificacion": identificacion,
        "sesiones": sesiones,
        "sesionesActivas": sesionesActivas,
        "suscripcion": suscripcion,
        "juntasSuscritas": juntasSuscritas,
        "juntasUsadas": juntasUsadas,
        "activo": activo,
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaFin": fechaFin.toIso8601String(),
        "tiempoRestante": tiempoRestante,
        "url": url,
        "fotoArchivo": fotoArchivo,
        "fotoNombre": fotoNombre,
        "fondo": fondo,
        "color": color,
      };
}
