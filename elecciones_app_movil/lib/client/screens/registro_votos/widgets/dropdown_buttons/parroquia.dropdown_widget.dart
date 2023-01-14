import 'package:elecciones_app_movil/businness/providers/ubicacion/parroquia_provider.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/client/widgets/commons/circular_progress_indicator_widget.dart';
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
          return DropdownButton<Parroquia>(
            itemHeight: null,
            isExpanded: true,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 14),
            underline: Container(
              height: 1,
              color: Colors.blue,
            ),
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
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
