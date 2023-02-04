import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/notifiers/auth/token_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final zonaFutureProvider = FutureProvider.autoDispose.family<List<Zona>, int>((ref, idParroquia) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio()
        .get('$urlApiCliente/zona/parroquia/$idParroquia/all', options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return (response.data as List).map((zona) => Zona.fromMap(zona)).toList();
    } else {
      throw Exception('Error al obtener las zonas de la parroquia $idParroquia.');
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener las zonas de la parroquia $idParroquia.');
    }
  }
});
