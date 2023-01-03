import 'package:elecciones_app_movil/businness/providers/ubicacion/provincia_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/provincia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvinciaDropdownButtonWidget extends ConsumerWidget {
  const ProvinciaDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final provinciaNotifier = ref
        .watch(provinciaFutureProvider(ubicacionNotifier.paisSeleccionado!.id));

    return provinciaNotifier.when(
        data: (provincias) {
          return Center(
            child: DropdownButton<Provincia>(
              isExpanded: true,
              value: ubicacionNotifier.provinciaSeleccionada,
              hint: const Text('Seleccione una provincia.'),
              onChanged: (provincia) {
                ref
                    .read(ubicacionProvider.notifier)
                    .changeProvinciaSeleccionadaSatate(provincia!);
              },
              items: provincias
                  .map((provincia) => DropdownMenuItem(
                        value: provincia,
                        child: Text(provincia.nombre),
                      ))
                  .toList(),
            ),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}
