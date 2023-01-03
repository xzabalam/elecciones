import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/config/env/env.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
final recintoFutureProvider =
    FutureProvider.autoDispose.family<List<Recinto>, int>((ref, idZona) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = new Dio();
  try {
    final response = await dio.get(
        '${Env.clientApiUrl}/recinto/zona/${idZona}/all',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((recinto) => Recinto.fromMap(recinto))
          .toList();
    } else {
      throw Exception(
          'Error al obtener los recintos de la zona ${idZona}. Error: ${response.data['error']}');
    }
  } catch (e) {
    throw Exception(
        'Error al obtener los recintos de la zona ${idZona}..  Error: ${e.toString()}');
  }
});
