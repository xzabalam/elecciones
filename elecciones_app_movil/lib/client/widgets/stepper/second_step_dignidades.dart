import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondStepDignidadesWidget extends ConsumerWidget {
  const SecondStepDignidadesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (ubicacionNotifier.provinciaSeleccionada != null)
            Text(ubicacionNotifier.provinciaSeleccionada!.nombre),
          if (ubicacionNotifier.cantonSeleccionado != null)
            Text(ubicacionNotifier.cantonSeleccionado!.nombre),
          if (ubicacionNotifier.parroquiaSeleccionada != null)
            Text(ubicacionNotifier.parroquiaSeleccionada!.nombre),
          if (ubicacionNotifier.juntaSeleccionada != null)
            Text(
                'Junta No. ${ubicacionNotifier.juntaSeleccionada!
                    .numero} - ${ubicacionNotifier.juntaSeleccionada!.sexo!
                    .nombre} '),
          const Divider(),
        ],
      ),
    );
  }
}
