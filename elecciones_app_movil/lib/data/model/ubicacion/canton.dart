import 'package:equatable/equatable.dart';

class Canton extends Equatable {
  final int id;
  final String nombre;

  const Canton({required this.id, required this.nombre});

  factory Canton.fromMap(Map<String, dynamic> json) => Canton(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };

  @override
  String toString() {
    return 'Canton{id: $id, nombre: $nombre}';
  }

  @override
  List<Object?> get props => [id, nombre];
}
