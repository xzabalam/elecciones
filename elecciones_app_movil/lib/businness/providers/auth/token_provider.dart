import 'package:elecciones_app_movil/businness/providers/model/auth/auth_token_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthTokenNotifier extends StateNotifier<AuthTokenModel> {
  AuthTokenNotifier() : super(AuthTokenModel(basicToken: ''));

  void changeAuthTokenSatate(String token) {
    state = state.copyWith(basicToken: token);
  }
}

final authTokenProvider =
    StateNotifierProvider<AuthTokenNotifier, AuthTokenModel>((ref) {
  return AuthTokenNotifier();
});
