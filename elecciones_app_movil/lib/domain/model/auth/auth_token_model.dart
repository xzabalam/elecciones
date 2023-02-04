import 'package:elecciones_app_movil/data/model/auth/usuario.dart';
import 'package:equatable/equatable.dart';

class AuthTokenModel extends Equatable {
  String basicToken;
  String? error;
  Usuario? usuario;
  String? urlApiCliente;

  AuthTokenModel({required this.basicToken, this.error, this.usuario, this.urlApiCliente});

  AuthTokenModel copyWith({String? basicToken, String? error, Usuario? usuario, String? urlApiCliente}) {
    return AuthTokenModel(
        basicToken: basicToken ?? this.basicToken,
        error: error ?? this.error,
        usuario: usuario ?? this.usuario,
        urlApiCliente: urlApiCliente ?? this.urlApiCliente);
  }

  @override
  List<Object?> get props => [basicToken, error, usuario, urlApiCliente];
}
