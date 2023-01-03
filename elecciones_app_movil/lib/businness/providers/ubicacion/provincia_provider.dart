import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/config/env/env.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/provincia.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
final provinciaFutureProvider = FutureProvider.autoDispose
    .family<List<Provincia>, int>((ref, idPais) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = new Dio();
  try {
    final response = await dio.get(
        '${Env.clientApiUrl}/provincia/pais/${idPais}/all',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((provincia) => Provincia.fromMap(provincia))
          .toList();
    } else {
      throw Exception(
          'Error al obtener las provincias del país ${idPais}. Error: ${response.data['error']}');
    }
  } catch (e) {
    throw Exception(
        'Error al obtener las provincias del país ${idPais}.  Error: ${e.toString()}');
  }
});
