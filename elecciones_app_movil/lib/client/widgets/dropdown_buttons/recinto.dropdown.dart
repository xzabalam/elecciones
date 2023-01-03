import 'package:elecciones_app_movil/businness/providers/ubicacion/recinto_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecintoDropdownButtonWidget extends ConsumerWidget {
  const RecintoDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final recintoNotifier = ref
        .watch(recintoFutureProvider(ubicacionNotifier.zonaSeleccionada!.id));

    return recintoNotifier.when(
        data: (recintos) {
          return Center(
            child: DropdownButton<Recinto>(
              isExpanded: true,
              value: ubicacionNotifier.recintoSeleccionado,
              hint: const Text('Seleccione un recinto.'),
              onChanged: (recinto) {
                ref
                    .read(ubicacionProvider.notifier)
                    .changeRecintoSeleccionadoSatate(recinto!);
              },
              items: recintos
                  .map((recinto) => DropdownMenuItem(
                        value: recinto,
                        child: Text(recinto.nombre),
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
