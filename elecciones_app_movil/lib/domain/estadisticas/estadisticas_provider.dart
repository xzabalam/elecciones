// Obtener el listado de dignidades
import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/domain/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DignidadDto {
  DignidadDto({
    required this.id,
    required this.nombre,
  });

  final int? id;
  final String? nombre;

  DignidadDto copyWith({
    int? id,
    String? nombre,
  }) =>
      DignidadDto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );

  factory DignidadDto.fromJson(Map<String, dynamic> json) => DignidadDto(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}

final dignidades = FutureProvider((ref) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = Dio();
  try {
    final response =
        await dio.get('${Env.clientApiUrl}/dignidad/all', options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      List<DignidadDto> dignidades = (response.data as List).map((dignidad) {
        return DignidadDto.fromJson(dignidad);
      }).toList();

      return dignidades;
    } else {
      throw Exception('Error al obtener las dignidades configuradas. ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas. ${e.toString()}');
  }
});

// Obtener el numero de electores por ubicacion

// Obtener el conteo de votos por ubicacion y por dignidad seleccionadas
