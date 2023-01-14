import 'package:equatable/equatable.dart';

class VotoModificadoModel extends Equatable {
  int? idVoto;
  int? idActaDignidad;
  int? idJunta;
  int? cantidadVoto;

  VotoModificadoModel({this.idVoto, this.idActaDignidad, this.idJunta, this.cantidadVoto});

  VotoModificadoModel copyWith(
          {int? idVoto, int? idActaDignidad, int? idJunta, int? cantidadVoto, bool? seGuardoVoto}) =>
      VotoModificadoModel(
        idVoto: idVoto ?? this.idVoto,
        idActaDignidad: idActaDignidad ?? this.idActaDignidad,
        idJunta: idJunta ?? this.idJunta,
        cantidadVoto: cantidadVoto ?? this.cantidadVoto,
      );

  @override
  String toString() {
    return 'VotoModificadoModel{idVoto: $idVoto, idActaDignidad: $idActaDignidad, idJunta: $idJunta, cantidadVoto: $cantidadVoto}';
  }

  @override
  List<Object?> get props => [idVoto, idActaDignidad, idJunta, cantidadVoto];
}
