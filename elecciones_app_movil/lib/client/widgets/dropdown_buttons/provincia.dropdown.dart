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
          return DropdownButton<Provincia>(
            itemHeight: null,
            isExpanded: true,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 14),
            underline: Container(
              height: 1,
              color: Colors.blue,
            ),
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
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}
