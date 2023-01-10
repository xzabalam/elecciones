import 'package:elecciones_app_movil/data/model/candidato/acta_dignidad.dart';
import 'package:elecciones_app_movil/data/model/candidato/grupo_candidato.dart';

class Voto {
  Voto({
    this.id,
    this.actaDignidad,
    this.grupoCandidato,
    this.cantidad,
  });

  int? id;
  ActaDignidad? actaDignidad;
  GrupoCandidato? grupoCandidato;
  int? cantidad;

  Voto copyWith({
    int? id,
    ActaDignidad? actaDignidad,
    GrupoCandidato? grupoCandidato,
    int? cantidad,
  }) =>
      Voto(
        id: id ?? this.id,
        actaDignidad: actaDignidad ?? this.actaDignidad,
        grupoCandidato: grupoCandidato ?? this.grupoCandidato,
        cantidad: cantidad ?? this.cantidad,
      );

  factory Voto.fromMap(Map<String, dynamic> json) => Voto(
        id: json["id"],
        actaDignidad: ActaDignidad?.fromMap(json["actaDignidad"]),
        grupoCandidato: GrupoCandidato?.fromMap(json["grupoCandidato"]),
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "actaDignidad": actaDignidad,
        "grupoCandidato": grupoCandidato,
        "cantidad": cantidad,
      };
}
