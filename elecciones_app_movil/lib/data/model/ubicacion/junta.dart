import 'package:elecciones_app_movil/data/model/auth/sexo.dart';

class Junta {
  int id;
  Sexo? sexo;
  String numero;
  int numeroElectores;
  int utilizada;

  Junta(
      {required this.id,
      required this.sexo,
      required this.numero,
      required this.numeroElectores,
      required this.utilizada});

  Junta copyWith({
    int? id,
    Sexo? sexo,
    String? numero,
    int? numeroElectores,
    int? utilizada,
  }) =>
      Junta(
        id: id ?? this.id,
        sexo: sexo ?? this.sexo,
        numero: numero ?? this.numero,
        numeroElectores: numeroElectores ?? this.numeroElectores,
        utilizada: utilizada ?? this.utilizada,
      );

  factory Junta.fromMap(Map<String, dynamic> json) => Junta(
        id: json["id"] == null ? null : json["id"],
        sexo: json["sexo"] == null ? null : Sexo.fromJson(json["sexo"]),
        numero: json["numero"] == null ? null : json["numero"],
        numeroElectores: json["numeroElectores"] == null ? null : json["numeroElectores"],
        utilizada: json["utilizada"] == null ? null : json["utilizada"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "sexo": sexo == null ? null : sexo!.toJson(),
        "numero": numero == null ? null : numero,
        "numeroElectores": numeroElectores == null ? null : numeroElectores,
        "utilizada": utilizada == null ? null : utilizada,
      };
}
