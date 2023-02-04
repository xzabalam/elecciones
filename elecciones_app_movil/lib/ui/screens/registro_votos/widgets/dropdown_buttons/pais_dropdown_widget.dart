import 'package:elecciones_app_movil/data/model/ubicacion/pais.dart';
import 'package:elecciones_app_movil/domain/notifiers/ubicacion/ubicacion_notifier.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/pais_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaisDropdownButtonWidget extends ConsumerWidget {
  const PaisDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final paisNotifier = ref.watch(paisFutureProvider);

    return paisNotifier.when(
        data: (paises) {
          return DropdownButton<Pais>(
            itemHeight: null,
            isExpanded: true,
            value: ubicacionNotifier.paisSeleccionado,
            hint: const Text('Seleccione un país.'),
            onChanged: (pais) {
              ref.read(ubicacionProvider.notifier).changePaisSeleccionadoSatate(pais!);
            },
            items: paises
                .map((pais) => DropdownMenuItem(
                      value: pais,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(pais.nombre),
                      ),
                    ))
                .toList(),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
