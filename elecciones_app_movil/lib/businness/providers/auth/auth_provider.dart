import 'package:elecciones_app_movil/businness/providers/auth/auth_notifier_service.dart';
import 'package:elecciones_app_movil/businness/providers/model/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

final authFutureProvider = FutureProvider.autoDispose
    .family<String, AuthModel>((ref, authModel) async {
  return ref
      .read(authProvider)
      .login(username: authModel.username, password: authModel.password);
});
