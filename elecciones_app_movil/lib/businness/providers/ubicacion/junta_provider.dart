import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final juntaFutureProvider =
    FutureProvider.autoDispose.family<List<Junta>, int>((ref, idRecinto) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = new Dio();
  try {
    final response = await dio.get(
        '${Env.clientApiUrl}/junta/recinto/${idRecinto}/all',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((junta) => Junta.fromMap(junta))
          .toList();
    } else {
      throw Exception('Error al obtener las juntas del recinto ${idRecinto}.');
    }
  } catch (e) {
    throw Exception('Error al obtener las juntas del recinto ${idRecinto}.');
  }
});
