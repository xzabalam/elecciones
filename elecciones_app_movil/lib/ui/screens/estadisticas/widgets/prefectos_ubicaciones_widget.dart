import 'package:adaptive_button/adaptive_button.dart';
import 'package:backdrop/backdrop.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/parametros_consulta_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/voto_movimiento_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/estadisticas_provider.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/ubicacion/provincia_widget.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrefectoUbicacionWidget extends ConsumerWidget {
  const PrefectoUbicacionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadisticaNotifier = ref.watch(estadisticaProvider);
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      const ProvinciaWidget(),
      if (estadisticaNotifier.seSeleccionoProvincia!)
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
              ParametrosConsultaDto parametros = ParametrosConsultaDto(idProvincia: provinciaSeleccionada.id);

              // Se debe obtener la sumatoria de votos por provincia y prefecto
              List<VotosMovimientoDto> respuestaSumatoriaVotosPorMovimiento =
                  await ref.read(numeroVotosParaPrefectoPorProvinciaFutureProvider(parametros).future);

              ref.read(estadisticaProvider.notifier).changeSumatoriaVotos(respuestaSumatoriaVotosPorMovimiento);

              Backdrop.of(context).concealBackLayer();
            },
          ),
        )
    ]);
  }
}
