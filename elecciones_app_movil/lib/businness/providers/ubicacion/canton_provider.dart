import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/config/env/env.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/canton.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
final cantonFutureProvider = FutureProvider.autoDispose
    .family<List<Canton>, int>((ref, idProvincia) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = new Dio();
  try {
    final response = await dio.get(
        '${Env.clientApiUrl}/canton/provincia/${idProvincia}/all',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((canton) => Canton.fromMap(canton))
          .toList();
    } else {
      throw Exception(
          'Error al obtener los cantones de la provincia ${idProvincia}. Error: ${response.data['error']}');
    }
  } catch (e) {
    throw Exception(
        'Error al obtener los cantones de la provincia ${idProvincia}.  Error: ${e.toString()}');
  }
});
