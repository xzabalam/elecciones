import 'package:elecciones_app_movil/data/model/candidato/candidato.dart';
import 'package:elecciones_app_movil/data/model/candidato/movimiento.dart';

class GrupoCandidato {
  GrupoCandidato({
    this.id,
    this.nombre,
    this.movimiento,
    this.fotoArchivo,
    this.fotoNombre,
    this.candidatos,
  });

  int? id;
  String? nombre;
  Movimiento? movimiento;
  dynamic fotoArchivo;
  String? fotoNombre;
  List<Candidato?>? candidatos;

  GrupoCandidato copyWith({
    int? id,
    String? nombre,
    Movimiento? movimiento,
    dynamic fotoArchivo,
    String? fotoNombre,
    List<Candidato?>? candidatos,
  }) =>
      GrupoCandidato(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        movimiento: movimiento ?? this.movimiento,
        fotoArchivo: fotoArchivo ?? this.fotoArchivo,
        fotoNombre: fotoNombre ?? this.fotoNombre,
        candidatos: candidatos ?? this.candidatos,
      );

  factory GrupoCandidato.fromMap(Map<String, dynamic> json) => GrupoCandidato(
        id: json["id"],
        nombre: json["nombre"],
        movimiento: Movimiento?.fromMap(json["movimiento"]),
        fotoArchivo: json["fotoArchivo"],
        fotoNombre: json["fotoNombre"],
        candidatos: json["candidatos"] == null
            ? []
            : json["candidatos"] == null
                ? []
                : List<Candidato?>.from(
                    json["candidatos"]!.map((x) => Candidato.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "movimiento": movimiento,
        "fotoArchivo": fotoArchivo,
        "fotoNombre": fotoNombre,
        "candidatos": candidatos == null
            ? []
            : candidatos == null
                ? []
                : List<dynamic>.from(candidatos!.map((x) => x!.toMap())),
      };
}
