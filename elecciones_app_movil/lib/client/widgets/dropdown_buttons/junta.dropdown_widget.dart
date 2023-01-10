import 'package:elecciones_app_movil/businness/providers/candidatos/acta_dignidad_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/junta_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/client/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JuntaDropdownButtonWidget extends ConsumerWidget {
  const JuntaDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final juntaNotifier = ref
        .watch(juntaFutureProvider(ubicacionNotifier.recintoSeleccionado!.id));

    return juntaNotifier.when(
        data: (juntas) {
          return DropdownButton<Junta>(
            itemHeight: null,
            isExpanded: true,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 14),
            underline: Container(
              height: 1,
              color: Colors.blue,
            ),
            value: ubicacionNotifier.juntaSeleccionada,
            hint: const Text('Seleccione una junta.'),
            onChanged: (junta) {
              ref
                  .read(ubicacionProvider.notifier)
                  .changeJuntaSeleccionadaSatate(junta!);

              // Reseteamos el estado de la pesta;a 3 "Candidatos"
              ref.read(actaDignidadProvider.notifier).resetState();
            },
            items: juntas
                .map((junta) =>
                DropdownMenuItem(
                  value: junta,
                  child: Text(
                      ' ${junta.numero.toString()} - ${junta.sexo!.nombre}'),
                ))
                .toList(),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
