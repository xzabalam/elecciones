class NumeroElectoresDto {
  NumeroElectoresDto({
    required this.idUbicacion,
    required this.nombreUbicacion,
    required this.cantidadElectores,
  });

  final int? idUbicacion;
  final String? nombreUbicacion;
  final int? cantidadElectores;

  NumeroElectoresDto copyWith({
    int? idUbicacion,
    String? nombreUbicacion,
    int? cantidadElectores,
  }) =>
      NumeroElectoresDto(
        idUbicacion: idUbicacion ?? this.idUbicacion,
        nombreUbicacion: nombreUbicacion ?? this.nombreUbicacion,
        cantidadElectores: cantidadElectores ?? this.cantidadElectores,
      );

  factory NumeroElectoresDto.fromJson(Map<String, dynamic> json) => NumeroElectoresDto(
        idUbicacion: json["idUbicacion"],
        nombreUbicacion: json["nombreUbicacion"],
        cantidadElectores: json["cantidadElectores"],
      );

  Map<String, dynamic> toJson() => {
        "idUbicacion": idUbicacion,
        "nombreUbicacion": nombreUbicacion,
        "cantidadElectores": cantidadElectores,
      };

  @override
  String toString() {
    return 'NumeroElectoresDto{idUbicacion: $idUbicacion, nombreUbicacion: $nombreUbicacion, cantidadElectores: $cantidadElectores}';
  }
}
