import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/client/widgets/dropdown_buttons/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistroVotos extends ConsumerWidget {
  const RegistroVotos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                    'Por favor seleccione la ubicación en la que se va a realizar el ingreso de votos.'),
                const Divider(
                  height: 30,
                  color: Colors.transparent,
                ),
                // Dropdown para pais
                const PaisDropdownButtonWidget(),
                // Dropdown para provincia
                if (ubicacionNotifier.paisSeleccionado != null)
                  const ProvinciaDropdownButtonWidget(),
                // Dropdown para canton
                if (ubicacionNotifier.provinciaSeleccionada != null)
                  const CantonDropdownButtonWidget(),
                // Dropdown para parroquia
                if (ubicacionNotifier.cantonSeleccionado != null)
                  const ParroquiaDropdownButtonWidget(),
                // Dropdown para zona
                if (ubicacionNotifier.parroquiaSeleccionada != null)
                  const ZonaDropdownButtonWidget(),
                // Dropdown para recinto
                if (ubicacionNotifier.zonaSeleccionada != null)
                  const RecintoDropdownButtonWidget(),
                // Dropdown para junta
                if (ubicacionNotifier.recintoSeleccionado != null)
                  const JuntaDropdownButtonWidget(),
              ],
            )));
  }
}
