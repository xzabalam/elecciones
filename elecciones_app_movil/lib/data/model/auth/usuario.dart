import 'package:elecciones_app_movil/data/model/auth/contrato.dart';
import 'package:elecciones_app_movil/data/model/auth/entidad.dart';

class Usuario {
  Usuario({
    this.id,
    this.username,
    this.entidad,
    this.contrato,
    this.activo,
    this.habilitadoMovil,
    this.sessionMovil,
    this.macMovil,
    this.habilitadoWeb,
    this.sessionWeb,
    this.roles,
  });

  int? id;
  String? username;
  Entidad? entidad;
  Contrato? contrato;
  String? activo;
  String? habilitadoMovil;
  int? sessionMovil;
  String? macMovil;
  String? habilitadoWeb;
  int? sessionWeb;
  List<String>? roles;

  Usuario copyWith({
    int? id,
    String? username,
    Entidad? entidad,
    Contrato? contrato,
    String? activo,
    String? habilitadoMovil,
    int? sessionMovil,
    String? macMovil,
    String? habilitadoWeb,
    int? sessionWeb,
    List<String>? roles,
  }) =>
      Usuario(
        id: id ?? this.id,
        username: username ?? this.username,
        entidad: entidad ?? this.entidad,
        contrato: contrato ?? this.contrato,
        activo: activo ?? this.activo,
        habilitadoMovil: habilitadoMovil ?? this.habilitadoMovil,
        sessionMovil: sessionMovil ?? this.sessionMovil,
        macMovil: macMovil ?? this.macMovil,
        habilitadoWeb: habilitadoWeb ?? this.habilitadoWeb,
        sessionWeb: sessionWeb ?? this.sessionWeb,
        roles: roles ?? this.roles,
      );

  @override
  String toString() {
    return 'Usuario{id: $id, username: $username, entidad: $entidad, contrato: $contrato, activo: $activo, habilitadoMovil: $habilitadoMovil, sessionMovil: $sessionMovil, macMovil: $macMovil, habilitadoWeb: $habilitadoWeb, sessionWeb: $sessionWeb, roles: $roles}';
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        username: json["username"],
        entidad: Entidad.fromJson(json["entidad"]),
        contrato: Contrato.fromJson(json["contrato"]),
        activo: json["activo"],
        habilitadoMovil: json["habilitadoMovil"],
        sessionMovil: json["sessionMovil"],
        macMovil: json["macMovil"],
        habilitadoWeb: json["habilitadoWeb"],
        sessionWeb: json["sessionWeb"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "entidad": entidad!.toJson(),
        "contrato": contrato!.toJson(),
        "activo": activo,
        "habilitadoMovil": habilitadoMovil,
        "sessionMovil": sessionMovil,
        "macMovil": macMovil,
        "habilitadoWeb": habilitadoWeb,
        "sessionWeb": sessionWeb,
        "roles": List<dynamic>.from(roles!.map((x) => x)),
      };
}
