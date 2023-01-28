import 'package:elecciones_app_movil/data/model/auth/usuario.dart';
import 'package:elecciones_app_movil/domain/providers/model/auth/auth_token_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthTokenNotifier extends StateNotifier<AuthTokenModel> {
  AuthTokenNotifier() : super(AuthTokenModel(basicToken: ''));

  void changeAuthTokenSatate(String token) {
    state = state.copyWith(basicToken: token);
  }

  void changeAuthErrorState(String error) {
    state = state.copyWith(error: error);
  }

  void changeAuthUsuarioState(Usuario usuario) {
    state = state.copyWith(usuario: usuario);
  }

  void resetState() {
    state = AuthTokenModel(basicToken: '');
  }
}

final authTokenProvider = StateNotifierProvider<AuthTokenNotifier, AuthTokenModel>((ref) {
  return AuthTokenNotifier();
});
