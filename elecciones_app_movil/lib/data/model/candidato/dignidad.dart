import 'package:elecciones_app_movil/data/model/candidato/proceso.dart';
import 'package:elecciones_app_movil/data/model/candidato/tipo_grupo.dart';
import 'package:equatable/equatable.dart';

class Dignidad extends Equatable {
  Dignidad({
    required this.id,
    required this.nombre,
    required this.proceso,
    required this.tipoGrupo,
    required this.numero,
  });

  int id;
  String nombre;
  Proceso proceso;
  TipoGrupo tipoGrupo;
  int numero;

  Dignidad copyWith({
    int? id,
    String? nombre,
    Proceso? proceso,
    TipoGrupo? tipoGrupo,
    int? numero,
  }) =>
      Dignidad(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        proceso: proceso ?? this.proceso,
        tipoGrupo: tipoGrupo ?? this.tipoGrupo,
        numero: numero ?? this.numero,
      );

  factory Dignidad.fromMap(Map<String, dynamic> json) => Dignidad(
        id: json["id"],
        nombre: json["nombre"],
        proceso: Proceso.fromMap(json["proceso"]),
        tipoGrupo: TipoGrupo.fromMap(json["tipoGrupo"]),
        numero: json["numero"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "proceso": proceso?.toMap(),
        "tipoGrupo": tipoGrupo?.toMap(),
        "numero": numero,
      };

  @override
  List<Object?> get props => [id, nombre];
}
