import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/estadisticas_provider.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/parroquia_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParroquiaWidget extends ConsumerWidget {
  const ParroquiaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadisticaNotifier = ref.watch(estadisticaProvider);
    final parroquiaNotifier = ref.watch(parroquiaFutureProvider(estadisticaNotifier.cantonSeleccionado!.id));

    return parroquiaNotifier.when(
        data: (parroquias) {
          return DropdownButton<Parroquia>(
            itemHeight: null,
            isExpanded: true,
            value: estadisticaNotifier.parroquiaSeleccionada,
            hint: const Text('Seleccione una parroquia.'),
            onChanged: (parroquia) {
              ref.read(estadisticaProvider.notifier).changeParroquiaSeleccionadaState(parroquia!);
            },
            items: parroquias
                .map((parroquia) => DropdownMenuItem(
                      value: parroquia,
                      child: Text(parroquia.nombre),
                    ))
                .toList(),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
