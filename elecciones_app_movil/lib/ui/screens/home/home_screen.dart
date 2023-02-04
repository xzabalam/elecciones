import 'dart:convert';

import 'package:elecciones_app_movil/data/model/auth/usuario.dart';
import 'package:elecciones_app_movil/domain/notifiers/auth/token_notifier.dart';
import 'package:elecciones_app_movil/domain/notifiers/estadisticas/estadisticas_notifier.dart';
import 'package:elecciones_app_movil/domain/notifiers/ubicacion/ubicacion_notifier.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/estadisticas_screen.dart';
import 'package:elecciones_app_movil/ui/screens/registro_votos/registro_votos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (mounted) {
        _selectedIndex = index;
        ref.read(ubicacionProvider.notifier).resetState();
        ref.read(estadisticaProvider.notifier).resetState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Usuario usuario = ref.read(authTokenProvider).usuario!;

    final List<Widget> widgetOptions = <Widget>[
      Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(base64Decode(usuario.contrato!.fotoArchivo)),
              const SizedBox(height: 50),
              const Text('¡Bienvenido!', style: TextStyle(fontSize: 18)),
              Text(usuario.entidad!.nombre!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(usuario.contrato!.nombre!, style: const TextStyle(fontSize: 16)),
            ]),
      ),
      const RegistroVotosWidget(),
      const EstadisticasPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Elecciones 2023 - ${usuario.contrato!.nombre!}'),
        automaticallyImplyLeading: false,
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        elevation: 16,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_add),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Estadísticas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
