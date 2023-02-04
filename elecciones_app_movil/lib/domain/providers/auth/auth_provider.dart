import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/auth/usuario.dart';
import 'package:elecciones_app_movil/domain/model/auth/usuario_to.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final loginProvider = FutureProvider.autoDispose.family<Usuario, UsuarioTo>((ref, usuarioTo) async {
  try {
    Response response =
        await Dio().get('${Env.clientApiUrl}/auth', options: Options(headers: {'Authorization': usuarioTo.basicAuth}));

    if (response.statusCode == 200) {
      return Usuario.fromJson(response.data);
    } else {
      throw Exception("Usuario no autorizado.");
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception("Usuario y/o contraseña incorrectos.");
    }
  }
});
