class VotosMovimientoDto {
  VotosMovimientoDto({
    required this.idMovimiento,
    required this.movimiento,
    required this.sumatoria,
  });

  final int? idMovimiento;
  final String? movimiento;
  final int? sumatoria;

  VotosMovimientoDto copyWith({
    int? idMovimiento,
    String? movimiento,
    int? sumatoria,
  }) =>
      VotosMovimientoDto(
        idMovimiento: idMovimiento ?? this.idMovimiento,
        movimiento: movimiento ?? this.movimiento,
        sumatoria: sumatoria ?? this.sumatoria,
      );

  factory VotosMovimientoDto.fromJson(Map<String, dynamic> json) => VotosMovimientoDto(
        idMovimiento: json["idMovimiento"],
        movimiento: json["movimiento"],
        sumatoria: json["sumatoria"],
      );

  Map<String, dynamic> toJson() => {
        "idMovimiento": idMovimiento,
        "movimiento": movimiento,
        "sumatoria": sumatoria,
      };

  @override
  String toString() {
    return 'VotosMovimientoDto{idMovimiento: $idMovimiento, movimiento: $movimiento, sumatoria: $sumatoria}';
  }
}
