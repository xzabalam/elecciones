import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/config/env/env.dart';

/// Devuelve el token de autoriazaci[on que se almacenara en el estado.
class AuthService {
  Future<String> login(
      {required String username, required String password}) async {
    try {
      String basicToken =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      Response response = await Dio().get('${Env.mainApiUrl}/auth',
          options: Options(headers: {'Authorization': basicToken}));

      if (response.statusCode == 200) {
        return basicToken;
      } else {
        throw Exception("Usuario no autorizado.");
      }
    } on DioError catch (e) {
      if (e.message.contains("Http status error [401]")) {
        throw Exception("Usuario no autorizado.");
      } else {
        throw Exception("Usuario y/o contraseña incorrectos.");
      }
    }
  }
}
