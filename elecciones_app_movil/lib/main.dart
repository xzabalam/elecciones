import 'dart:async';

import 'package:elecciones_app_movil/domain/extensions/hex_color_extension.dart';
import 'package:elecciones_app_movil/ui/screens/home/home_screen.dart';
import 'package:elecciones_app_movil/ui/screens/login/login_failure.dart';
import 'package:elecciones_app_movil/ui/screens/login/login_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

StreamController<String> color = StreamController();

void main() {
  runApp(
    const ProviderScope(child: EleccionesApp()),
  );
}

class EleccionesApp extends StatelessWidget {
  const EleccionesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        initialData: Colors.blue.toHex(),
        stream: color.stream,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Elecciones 2023',
            theme: FlexThemeData.light(
                scheme: FlexScheme.blue,
                colors: FlexSchemeColor.from(
                  primary: HexColor.fromHex(snapshot.data!),
                  secondary: HexColor.fromHex(snapshot.data!),
                  appBarColor: HexColor.fromHex(snapshot.data!),
                ),
                appBarElevation: 0.5,
                fontFamily: GoogleFonts.openSans().fontFamily,
                visualDensity: VisualDensity.comfortable),
            darkTheme: FlexThemeData.dark(
              scheme: FlexScheme.blue,
              appBarElevation: 2,
              fontFamily: GoogleFonts.openSans().fontFamily,
            ),
            themeMode: ThemeMode.light,
            initialRoute: '/',
            routes: {
              '/': (context) => const LoginPage(),
              '/failure': (context) => const LoginFailurePage(),
              '/home': (context) => const HomePage()
            },
          );
        });
  }
}
