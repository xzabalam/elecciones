import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final zonaFutureProvider = FutureProvider.autoDispose.family<List<Zona>, int>((ref, idParroquia) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = new Dio();
  try {
    final response = await dio.get('${Env.clientApiUrl}/zona/parroquia/${idParroquia}/all',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List).map((zona) => Zona.fromMap(zona)).toList();
    } else {
      throw Exception('Error al obtener las zonas de la parroquia ${idParroquia}. Error: ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener las zonas de la parroquia ${idParroquia}..  Error: ${e.toString()}');
  }
});
