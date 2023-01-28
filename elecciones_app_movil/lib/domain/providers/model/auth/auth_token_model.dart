import 'package:elecciones_app_movil/data/model/auth/usuario.dart';

class AuthTokenModel {
  String basicToken;
  String? error;
  Usuario? usuario;

  AuthTokenModel({required this.basicToken, this.error, this.usuario});

  AuthTokenModel copyWith({String? basicToken, String? error, Usuario? usuario}) {
    return AuthTokenModel(
        basicToken: basicToken ?? this.basicToken, error: error ?? this.error, usuario: usuario ?? this.usuario);
  }
}
