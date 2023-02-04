import 'package:elecciones_app_movil/data/model/auth/usuario.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/circunscripcion.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/parametros_circusncripcion.dart';
import 'package:elecciones_app_movil/domain/notifiers/auth/token_notifier.dart';
import 'package:elecciones_app_movil/domain/notifiers/estadisticas/estadisticas_notifier.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/estadisticas_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircunscripcionWidget extends ConsumerWidget {
  const CircunscripcionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadisticaNotifier = ref.watch(estadisticaProvider);
    final Usuario usuario = ref.read(authTokenProvider).usuario!;
    final circunscripcionNotifier = ref.watch(circunscripcionesContratoDignidadProvider(
        ParametrosBusquedaCircunscripcion(
            idContrato: usuario.contrato!.id!, idDignidad: estadisticaNotifier.posicionDignidadSeleccionada)));

    return circunscripcionNotifier.when(
        data: (circunscripciones) {
          return DropdownButton<Circunscripcion>(
            itemHeight: null,
            isExpanded: true,
            value: estadisticaNotifier.circunscripcionSeleccionada,
            hint: const Text('Seleccione una circunscripción.'),
            onChanged: (circunscripcion) {
              ref.read(estadisticaProvider.notifier).changeCircunscripcionSeleccionadaState(circunscripcion!);
            },
            items: circunscripciones
                .map((circunscripcion) => DropdownMenuItem(
                      value: circunscripcion,
                      child: Text(circunscripcion.nombre!),
                    ))
                .toList(),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
