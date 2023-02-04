import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/notifiers/ubicacion/ubicacion_notifier.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/recinto_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecintoDropdownButtonWidget extends ConsumerWidget {
  const RecintoDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final recintoNotifier = ref.watch(recintoFutureProvider(ubicacionNotifier.zonaSeleccionada!.id));

    return recintoNotifier.when(
        data: (recintos) {
          return DropdownButton<Recinto>(
            itemHeight: null,
            isExpanded: true,
            value: ubicacionNotifier.recintoSeleccionado,
            hint: const Text('Seleccione un recinto.'),
            onChanged: (recinto) {
              ref.read(ubicacionProvider.notifier).changeRecintoSeleccionadoSatate(recinto!);
            },
            items: recintos
                .map((recinto) => DropdownMenuItem(
                      value: recinto,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(recinto.nombre),
                      ),
                    ))
                .toList(),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
