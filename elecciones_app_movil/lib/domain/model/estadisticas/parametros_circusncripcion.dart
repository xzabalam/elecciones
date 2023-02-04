import 'package:equatable/equatable.dart';

class ParametrosBusquedaCircunscripcion extends Equatable {
  final int? idContrato;
  final int? idDignidad;

  const ParametrosBusquedaCircunscripcion({this.idContrato, this.idDignidad});

  @override
  List<Object?> get props => [idContrato, idDignidad];
}
