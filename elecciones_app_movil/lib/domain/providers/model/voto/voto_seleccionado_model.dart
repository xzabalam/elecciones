import 'package:equatable/equatable.dart';

class VotoModificadoModel extends Equatable {
  int? idVoto;
  int? idActaDignidad;
  int? cantidadVoto;

  VotoModificadoModel({this.idVoto, this.idActaDignidad, this.cantidadVoto});

  VotoModificadoModel copyWith(
          {int? idVoto, int? idActaDignidad, int? idJunta, int? cantidadVoto, bool? seGuardoVoto}) =>
      VotoModificadoModel(
        idVoto: idVoto ?? this.idVoto,
        idActaDignidad: idActaDignidad ?? this.idActaDignidad,
        cantidadVoto: cantidadVoto ?? this.cantidadVoto,
      );

  @override
  String toString() {
    return 'VotoModificadoModel{idVoto: $idVoto, idActaDignidad: $idActaDignidad, cantidadVoto: $cantidadVoto}';
  }

  factory VotoModificadoModel.fromJson(Map<String, dynamic> json) => VotoModificadoModel(
        idVoto: json["idVoto"],
        idActaDignidad: json["idActaDignidad"],
        cantidadVoto: json["cantidadVoto"],
      );

  Map<String, dynamic> toJson() => {
        "idVoto": idVoto,
        "idActaDignidad": idActaDignidad,
        "cantidadVoto": cantidadVoto,
      };

  @override
  List<Object?> get props => [idVoto, idActaDignidad, cantidadVoto];
}
