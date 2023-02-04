import 'package:equatable/equatable.dart';

class ParametrosConsultaDto extends Equatable {
  final int? idProvincia;
  final int? idCanton;
  final int? idParroquia;
  final int? idDignidad;
  final int? idCircunscripcion;

  const ParametrosConsultaDto(
      {this.idProvincia, this.idCanton, this.idParroquia, this.idDignidad, this.idCircunscripcion});

  @override
  List<Object?> get props => [idProvincia, idCanton, idParroquia, idDignidad, idCircunscripcion];
}
