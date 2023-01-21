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
  bool operator ==(Object other) =>
      identical(this, other) || super == other && other is Canton && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => super.hashCode ^ id.hashCode;

  @override
  List<Object?> get props => [id, nombre];
}
