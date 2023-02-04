import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/notifiers/estadisticas/estadisticas_notifier.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/provincia_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvinciaWidget extends ConsumerWidget {
  const ProvinciaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provinciaNotifier = ref.watch(provinciaFutureProvider(1));
    final estadisticaNotifier = ref.watch(estadisticaProvider);

    return provinciaNotifier.when(
        data: (listaProvincias) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<Provincia>(
                  itemHeight: null,
                  isExpanded: true,
                  value: estadisticaNotifier.provinciaSeleccionada,
                  hint: const Text('Seleccione una provincia.'),
                  onChanged: (provincia) {
                    ref.read(estadisticaProvider.notifier).changeProvinciaSeleccionadaState(provincia!);
                  },
                  items: listaProvincias
                      .map((provincia) => DropdownMenuItem(
                            value: provincia,
                            child: Text(provincia.nombre),
                          ))
                      .toList(),
                ),
              ]);
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
