import 'package:equatable/equatable.dart';

class VotosMovimientoDto extends Equatable {
  VotosMovimientoDto({
    required this.idMovimiento,
    required this.movimiento,
    required this.numeroMovimiento,
    required this.sumatoria,
  });

  final int? idMovimiento;
  final String? movimiento;
  final String? numeroMovimiento;
  final int? sumatoria;

  VotosMovimientoDto copyWith({
    int? idMovimiento,
    String? movimiento,
    String? numeroMovimiento,
    int? sumatoria,
  }) =>
      VotosMovimientoDto(
        idMovimiento: idMovimiento ?? this.idMovimiento,
        movimiento: movimiento ?? this.movimiento,
        numeroMovimiento: numeroMovimiento ?? this.numeroMovimiento,
        sumatoria: sumatoria ?? this.sumatoria,
      );

  factory VotosMovimientoDto.fromJson(Map<String, dynamic> json) => VotosMovimientoDto(
        idMovimiento: json["idMovimiento"],
        movimiento: json["movimiento"],
        numeroMovimiento: json["numeroMovimiento"],
        sumatoria: json["sumatoria"],
      );

  Map<String, dynamic> toJson() => {
        "idMovimiento": idMovimiento,
        "movimiento": movimiento,
        "numeroMovimiento": numeroMovimiento,
        "sumatoria": sumatoria,
      };

  @override
  String toString() {
    return 'VotosMovimientoDto{idMovimiento: $idMovimiento, movimiento: $movimiento, numeroMovimiento: $numeroMovimiento, sumatoria: $sumatoria}';
  }

  @override
  List<Object?> get props => [idMovimiento, movimiento, numeroMovimiento, sumatoria];
}
