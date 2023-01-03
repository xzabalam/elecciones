import 'package:elecciones_app_movil/businness/providers/auth/auth_provider.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/businness/providers/model/auth/auth.dart';
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
      appBar: AppBar(title: Text('Login')),
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
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final authResponse = ref.read(authFutureProvider(AuthModel(
                            username: usernameController.text,
                            password: passwordController.text))
                        .future);

                    authResponse.then((value) {
                      ref
                          .read(authTokenProvider.notifier)
                          .changeAuthTokenSatate(value);
                      Navigator.pushNamed(context, '/home');
                    }).onError((error, stackTrace) {
                      const Text('Nombre de usuario y contraseña incorrectos');
                    });
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
