import 'package:flutter/material.dart';

class LoginFailurePage extends StatelessWidget {
  const LoginFailurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('No autorizado.')),
      body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SafeArea(
            child: Center(
              child: Column(
                children: const [
                  Text(
                    "Usuario no autorizado",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Solicite al coordinador la activación de su cuenta.",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
