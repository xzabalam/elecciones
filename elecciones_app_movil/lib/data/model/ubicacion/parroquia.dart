import 'package:equatable/equatable.dart';

class Parroquia extends Equatable {
  final int id;
  final String nombre;
  final String siglaCircunscripcion;

  const Parroquia({required this.id, required this.nombre, required this.siglaCircunscripcion});

  factory Parroquia.fromMap(Map<String, dynamic> json) =>
      Parroquia(id: json["id"], nombre: json["nombre"], siglaCircunscripcion: json["siglaCircunscripcion"]);

  Map<String, dynamic> toMap() => {"id": id, "nombre": nombre, "siglaCircunscripcion": siglaCircunscripcion};

  @override
  List<Object?> get props => [id, nombre, siglaCircunscripcion];
}
