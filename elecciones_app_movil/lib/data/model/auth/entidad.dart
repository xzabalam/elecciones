import 'package:elecciones_app_movil/data/model/auth/sexo.dart';
import 'package:elecciones_app_movil/data/model/auth/tipo_identificacion.dart';

class Entidad {
  Entidad(
      {this.id,
      this.nombre,
      this.identificacion,
      this.fechaNacimiento,
      this.mail,
      this.etnia,
      this.tipoIdentificacion,
      this.sexo});

  int? id;
  String? nombre;
  String? identificacion;
  DateTime? fechaNacimiento;
  String? mail;
  String? etnia;
  TipoIdentificacion? tipoIdentificacion;
  Sexo? sexo;

  Entidad copyWith(
          {int? id,
          String? nombre,
          String? identificacion,
          DateTime? fechaNacimiento,
          String? mail,
          String? etnia,
          TipoIdentificacion? tipoIdentificacion,
          Sexo? sexo}) =>
      Entidad(
          id: id ?? this.id,
          nombre: nombre ?? this.nombre,
          identificacion: identificacion ?? this.identificacion,
          fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
          mail: mail ?? this.mail,
          etnia: etnia ?? this.etnia,
          tipoIdentificacion: tipoIdentificacion ?? this.tipoIdentificacion,
          sexo: sexo ?? this.sexo);

  @override
  String toString() {
    return 'Entidad{id: $id, nombre: $nombre, identificacion: $identificacion, fechaNacimiento: $fechaNacimiento, mail: $mail, etnia: $etnia, tipoIdentificacion: $tipoIdentificacion, sexo: $sexo}';
  }

  factory Entidad.fromJson(Map<String, dynamic> json) => Entidad(
        id: json["id"],
        nombre: json["nombre"],
        identificacion: json["identificacion"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        mail: json["mail"],
        etnia: json["etnia"],
        tipoIdentificacion: TipoIdentificacion.fromJson(json["tipoIdentificacion"]),
        sexo: Sexo.fromJson(json["sexo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "identificacion": identificacion,
        "fechaNacimiento":
            "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
        "mail": mail,
        "etnia": etnia,
        "tipoIdentificacion": tipoIdentificacion!.toJson(),
        "sexo": sexo!.toJson()
      };
}
