import 'package:elecciones_app_movil/businness/providers/ubicacion/parroquia_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParroquiaDropdownButtonWidget extends ConsumerWidget {
  const ParroquiaDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final parroquiaNotifier = ref.watch(
        parroquiaFutureProvider(ubicacionNotifier.cantonSeleccionado!.id));

    return parroquiaNotifier.when(
        data: (parroquias) {
          return Center(
            child: DropdownButton<Parroquia>(
              isExpanded: true,
              value: ubicacionNotifier.parroquiaSeleccionada,
              hint: const Text('Seleccione una parroquia.'),
              onChanged: (parroquia) {
                ref
                    .read(ubicacionProvider.notifier)
                    .changeParroquiaSeleccionadaSatate(parroquia!);
              },
              items: parroquias
                  .map((canton) => DropdownMenuItem(
                        value: canton,
                        child: Text(canton.nombre),
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
