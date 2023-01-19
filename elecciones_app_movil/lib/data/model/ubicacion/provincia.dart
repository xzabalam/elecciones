import 'package:equatable/equatable.dart';

class Provincia extends Equatable {
  final int id;
  final String nombre;

  const Provincia({required this.id, required this.nombre});

  factory Provincia.fromMap(Map<String, dynamic> json) => Provincia(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };

  @override
  String toString() {
    return 'Provincia{id: $id, nombre: $nombre}';
  }

  @override
  List<Object?> get props => [id, nombre];
}
