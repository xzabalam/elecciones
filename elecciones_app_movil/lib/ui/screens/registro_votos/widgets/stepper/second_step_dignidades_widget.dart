import 'package:elecciones_app_movil/domain/notifiers/ubicacion/ubicacion_notifier.dart';
import 'package:elecciones_app_movil/ui/screens/registro_votos/widgets/acta_dignidad/acta_dignidad_widget.dart';
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
          if (ubicacionNotifier.provinciaSeleccionada != null) Text(ubicacionNotifier.provinciaSeleccionada!.nombre),
          if (ubicacionNotifier.cantonSeleccionado != null) Text(ubicacionNotifier.cantonSeleccionado!.nombre),
          if (ubicacionNotifier.parroquiaSeleccionada != null) Text(ubicacionNotifier.parroquiaSeleccionada!.nombre),
          if (ubicacionNotifier.juntaSeleccionada != null)
            Text(
                'Junta No. ${ubicacionNotifier.juntaSeleccionada!.numero} - ${ubicacionNotifier.juntaSeleccionada!.sexo!.nombre} '),
          const SizedBox(height: 30),
          const Text(
            'Seleccione una dignidad para ingresar los votos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Añadir la lista de dignidades a elegir
          if (ubicacionNotifier.juntaSeleccionada != null) const ActaDignidadWidget(),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
