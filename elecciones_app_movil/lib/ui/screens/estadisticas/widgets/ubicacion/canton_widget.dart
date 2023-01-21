import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/estadisticas_provider.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/canton_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CantonWidget extends ConsumerWidget {
  const CantonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadisticaNotifier = ref.watch(estadisticaProvider);
    final cantonNotifier = ref.watch(cantonFutureProvider(estadisticaNotifier.provinciaSeleccionada!.id));

    return cantonNotifier.when(
        data: (listaCantones) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<Canton>(
                  itemHeight: null,
                  isExpanded: true,
                  value: estadisticaNotifier.cantonSeleccionado,
                  hint: const Text('Seleccione un cantón.'),
                  onChanged: (canton) {
                    ref.read(estadisticaProvider.notifier).changeCantonSeleccionadoState(canton!);
                  },
                  items: listaCantones
                      .map((canton) => DropdownMenuItem(
                            value: canton,
                            child: Text(canton.nombre),
                          ))
                      .toList(),
                ),
              ]);
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
