import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final parroquiaFutureProvider = FutureProvider.autoDispose
    .family<List<Parroquia>, int>((ref, idCanton) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = new Dio();
  try {
    final response = await dio.get(
        '${Env.clientApiUrl}/parroquia/canton/${idCanton}/all',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((canton) => Parroquia.fromMap(canton))
          .toList();
    } else {
      throw Exception(
          'Error al obtener las parroquias del camtón ${idCanton}. Error: ${response.data['error']}');
    }
  } catch (e) {
    throw Exception(
        'Error al obtener las parroquias del camtón ${idCanton}..  Error: ${e.toString()}');
  }
});
