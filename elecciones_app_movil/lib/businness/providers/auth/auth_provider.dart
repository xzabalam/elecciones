import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class UsuarioTo {
  String username;
  String password;

  UsuarioTo({required this.username, required this.password});
}

final loginProvider = FutureProvider.autoDispose
    .family<String, UsuarioTo>((ref, usuarioTo) async {
  print(Env.clientApiUrl);
  try {
    String basicToken =
        'Basic ${base64.encode(
        utf8.encode('${usuarioTo.username}:${usuarioTo.password}'))}';
    Response response = await Dio().get('${Env.clientApiUrl}/auth',
        options: Options(headers: {'Authorization': basicToken}));

    if (response.statusCode == 200) {
      return basicToken;
    } else {
      throw Exception("Usuario no autorizado.");
    }
  } on DioError catch (e) {
    print(e.stackTrace);

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
