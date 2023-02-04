import 'package:equatable/equatable.dart';

class UsuarioTo extends Equatable {
  String username;
  String password;
  String basicAuth;

  UsuarioTo({required this.username, required this.password, required this.basicAuth});

  @override
  String toString() {
    return 'UsuarioTo{username: $username, password: $password, basicAuth: $basicAuth}';
  }

  @override
  List<Object?> get props => [username, password, basicAuth];
}
