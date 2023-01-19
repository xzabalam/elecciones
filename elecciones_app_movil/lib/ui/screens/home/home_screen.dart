import 'package:elecciones_app_movil/domain/providers/ubicacion/ubicacion_provider.dart';
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

  static final List<Widget> _widgetOptions = <Widget>[
    Center(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/foto_archivo_2.jpg'),
        SizedBox(height: 50),
        Text('¡Bienvenido!', style: TextStyle(fontSize: 18)),
      ]),
    ),
    const RegistroVotosWidget(),
    const EstadisticasPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      ref.read(ubicacionProvider.notifier).resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elecciones 2023'),
        automaticallyImplyLeading: false,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
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
