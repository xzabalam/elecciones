import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/canton.dart';
import 'package:elecciones_app_movil/domain/notifiers/auth/token_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final cantonFutureProvider = FutureProvider.autoDispose.family<List<Canton>, int>((ref, idProvincia) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio()
        .get('$urlApiCliente/canton/provincia/$idProvincia/all', options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List).map((canton) => Canton.fromMap(canton)).toList();
    } else {
      throw Exception('Error al obtener los cantones de la provincia $idProvincia.');
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener los cantones de la provincia $idProvincia.');
    }
  }
});
