import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/zona_provider.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ZonaDropdownButtonWidget extends ConsumerWidget {
  const ZonaDropdownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final zonaNotifier = ref
        .watch(zonaFutureProvider(ubicacionNotifier.parroquiaSeleccionada!.id));

    return zonaNotifier.when(
        data: (zonas) {
          return DropdownButton<Zona>(
            itemHeight: null,
            isExpanded: true,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 14),
            underline: Container(
              height: 1,
              color: Colors.blue,
            ),
            value: ubicacionNotifier.zonaSeleccionada,
            hint: const Text('Seleccione una zona.'),
            onChanged: (zona) {
              ref
                  .read(ubicacionProvider.notifier)
                  .changeZonaSeleccionadaSatate(zona!);
            },
            items: zonas
                .map((zona) => DropdownMenuItem(
                      value: zona,
                      child: Text(zona.nombre),
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
