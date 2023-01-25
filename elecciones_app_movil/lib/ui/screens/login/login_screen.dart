import 'package:adaptive_button/adaptive_button.dart';
import 'package:elecciones_app_movil/domain/providers/auth/auth_provider.dart';
import 'package:elecciones_app_movil/domain/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese un nombre de usuario.';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese una contraseña.';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              AdaptiveButton(
                width: 125,
                borderRadius: BorderRadius.circular(5),
                enabledLoading: true,
                loadingWidget: const SizedBox(width: 20, height: 20, child: CircularProgessIndicatorCustomWidget()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text("Iniciar sesión"),
                  ],
                ),
                onPressed: () async {
                  ref.read(authTokenProvider.notifier).resetState();
                  if (formKey.currentState!.validate()) {
                    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Ingrese un nombre de usuario y una contraseña.")));
                      return;
                    }

                    try {
                      final token = await ref.read(
                          loginProvider(UsuarioTo(username: usernameController.text, password: passwordController.text))
                              .future);
                      print(token);
                      ref.read(authTokenProvider.notifier).changeAuthTokenSatate(token!);
                      Navigator.pushNamed(context, '/home');
                    } catch (e) {
                      Navigator.pushNamed(context, '/failure');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
