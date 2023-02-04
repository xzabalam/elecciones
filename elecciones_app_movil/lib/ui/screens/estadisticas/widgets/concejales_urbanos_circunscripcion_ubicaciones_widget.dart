import 'package:adaptive_button/adaptive_button.dart';
import 'package:backdrop/backdrop.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/circunscripcion.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/parametros_consulta_dto.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/voto_movimiento_dto.dart';
import 'package:elecciones_app_movil/domain/notifiers/estadisticas/estadisticas_notifier.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/estadisticas_provider.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/ubicacion/canton_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/ubicacion/circunscripcion_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/ubicacion/provincia_widget.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConcejalesUrbanosCircunscripcionUbicacionWidget extends ConsumerWidget {
  const ConcejalesUrbanosCircunscripcionUbicacionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadisticaNotifier = ref.watch(estadisticaProvider);
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      const ProvinciaWidget(),
      if (estadisticaNotifier.seSeleccionoProvincia!) const CantonWidget(),
      if (estadisticaNotifier.seSeleccionoCanton!) const CircunscripcionWidget(),
      if (estadisticaNotifier.seSeleccionoConcejalesUrbanosPorCircunscripcion!)
        Center(
          child: AdaptiveButton(
            width: 125,
            borderRadius: BorderRadius.circular(5),
            enabledLoading: true,
            loadingWidget: const SizedBox(width: 20, height: 20, child: CircularProgessIndicatorCustomWidget()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.filter_alt_outlined),
                Text("Filtrar"),
              ],
            ),
            onPressed: () async {
              Provincia provinciaSeleccionada = estadisticaNotifier.provinciaSeleccionada!;
              Canton cantonSeleccionado = estadisticaNotifier.cantonSeleccionado!;
              int dignidad = estadisticaNotifier.posicionDignidadSeleccionada!;
              Circunscripcion circunscripcion = estadisticaNotifier.circunscripcionSeleccionada!;
              ParametrosConsultaDto parametros = ParametrosConsultaDto(
                  idProvincia: provinciaSeleccionada.id,
                  idCanton: cantonSeleccionado.id!,
                  idDignidad: dignidad,
                  idCircunscripcion: circunscripcion.id);

              // Se debe obtener la sumatoria de votos por provincia y prefecto
              List<VotosMovimientoDto> respuestaSumatoriaVotosPorMovimiento = await ref.read(
                  numeroVotosParaConcejalesUrbanosPorProvinciaCantonDignidadCircunscripcionFutureProvider(parametros)
                      .future);

              ref.read(estadisticaProvider.notifier).changeSumatoriaVotos(respuestaSumatoriaVotosPorMovimiento);

              Backdrop.of(context).concealBackLayer();
            },
          ),
        )
    ]);
  }
}
