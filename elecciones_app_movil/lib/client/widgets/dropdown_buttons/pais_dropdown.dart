import 'package:elecciones_app_movil/businness/providers/ubicacion/pias_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/pais.dart';
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
          return Center(
            child: DropdownButton<Pais>(
              isExpanded: true,
              value: ubicacionNotifier.paisSeleccionado,
              hint: const Text('Seleccione un país.'),
              elevation: 16,
              onChanged: (pais) {
                ref
                    .read(ubicacionProvider.notifier)
                    .changePaisSeleccionadoSatate(pais!);
              },
              items: paises
                  .map((pais) => DropdownMenuItem(
                        value: pais,
                        child: Text(pais.nombre),
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
