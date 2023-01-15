import 'package:elecciones_app_movil/domain/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/ui/screens/registro_votos/widgets/dropdown_buttons/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstStepUbicacionWidget extends ConsumerWidget {
  const FirstStepUbicacionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);

    return Center(
      child: Column(
        children: [
          const Text('Por favor, seleccione la ubicación en la que se va a realizar el registro de votos.'),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Dropdown para provincia
                  const ProvinciaDropdownButtonWidget(),
                  // Dropdown para canton
                  if (ubicacionNotifier.provinciaSeleccionada != null) const CantonDropdownButtonWidget(),
                  // Dropdown para parroquia
                  if (ubicacionNotifier.cantonSeleccionado != null) const ParroquiaDropdownButtonWidget(),
                  // Dropdown para zona
                  if (ubicacionNotifier.parroquiaSeleccionada != null) const ZonaDropdownButtonWidget(),
                  // Dropdown para recinto
                  if (ubicacionNotifier.zonaSeleccionada != null) const RecintoDropdownButtonWidget(),
                  // Dropdown para junta
                  if (ubicacionNotifier.recintoSeleccionado != null) const JuntaDropdownButtonWidget(),
                ],
              )),
        ],
      ),
    );
  }
}
