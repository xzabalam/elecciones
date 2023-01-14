import 'package:elecciones_app_movil/businness/providers/ubicacion/canton_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/client/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/canton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CantonDropdownButtonWidget extends ConsumerWidget {
  const CantonDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final cantonNotifier = ref.watch(
        cantonFutureProvider(ubicacionNotifier.provinciaSeleccionada!.id));

    return cantonNotifier.when(
        data: (cantones) {
          return DropdownButton<Canton>(
            itemHeight: null,
            isExpanded: true,
            value: ubicacionNotifier.cantonSeleccionado,
            hint: const Text('Seleccione un cantón.'),
            onChanged: (canton) {
              ref
                  .read(ubicacionProvider.notifier)
                  .changeCantonSeleccionadoSatate(canton!);
            },
            items: cantones
                .map((canton) => DropdownMenuItem(
                      value: canton,
                      child: Text(canton.nombre),
                    ))
                .toList(),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
