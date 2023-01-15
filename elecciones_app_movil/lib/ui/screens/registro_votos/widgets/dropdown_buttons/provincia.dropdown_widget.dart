import 'package:elecciones_app_movil/data/model/ubicacion/provincia.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/provincia_provider.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvinciaDropdownButtonWidget extends ConsumerWidget {
  const ProvinciaDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final provinciaNotifier = ref.watch(provinciaFutureProvider(1));

    return provinciaNotifier.when(
        data: (provincias) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<Provincia>(
                  itemHeight: null,
                  isExpanded: true,
                  value: ubicacionNotifier.provinciaSeleccionada,
                  hint: const Text('Seleccione una provincia.'),
                  onChanged: (provincia) {
                    ref.read(ubicacionProvider.notifier).changeProvinciaSeleccionadaSatate(provincia!);
                  },
                  items: provincias
                      .map((provincia) => DropdownMenuItem(
                            value: provincia,
                            child: Text(provincia.nombre),
                          ))
                      .toList(),
                )
              ]);
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
