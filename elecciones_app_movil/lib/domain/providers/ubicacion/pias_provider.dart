import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/pais.dart';
import 'package:elecciones_app_movil/domain/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final paisFutureProvider = FutureProvider<List<Pais>>((ref) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = new Dio();
  try {
    final response = await dio.get('${Env.clientApiUrl}/pais/all', options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List).map((pais) => Pais.fromMap(pais)).toList();
    } else {
      throw Exception('Error al obtener los paises ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener los paises ${e.toString()}');
  }
});
