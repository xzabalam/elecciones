import 'package:backdrop/backdrop.dart';
import 'package:elecciones_app_movil/domain/extensions/hex_color_extension.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/dignidad_dto.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/estadistica_model.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/voto_movimiento_dto.dart';
import 'package:elecciones_app_movil/domain/notifiers/estadisticas/estadisticas_notifier.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/estadisticas_provider.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/alcaldes_ubicaciones_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/concejales_rurales_ubicaciones_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/concejales_urbanos_circunscripcion_ubicaciones_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/concejales_urbanos_ubicaciones_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/prefectos_ubicaciones_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/vocales_juntas_parroquiales_ubicaciones_widget.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EstadisticasPage extends ConsumerStatefulWidget {
  const EstadisticasPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EstadisticasPageState();
}

class _EstadisticasPageState extends ConsumerState<EstadisticasPage> {
  final ScrollController _scrollController = ScrollController();

  int? posicionDignidadSeleccionada;

  @override
  void initState() {
    posicionDignidadSeleccionada = -1;
    super.initState();
  }

  @override
  void dispose() {
    ref.read(estadisticaProvider.notifier).resetState();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dignidadesNotifier = ref.watch(dignidadesFutureProvider);
    final estadisticasNotifier = ref.watch(estadisticaProvider);

    return dignidadesNotifier.when(
        data: (dignidades) {
          List<DignidadDto> dignidadesDto = dignidades.where((dignidad) => dignidad.id != 1).toList();

          return BackdropScaffold(
            appBar: BackdropAppBar(
              title: const Text("Filtros"),
            ),
            stickyFrontLayer: false,
            revealBackLayerAtStart: true,
            backLayerBackgroundColor: Colors.white54,
            backLayer: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Text("Dignidades", style: TextStyle(fontSize: 20)),
                    ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: dignidadesDto.length,
                        itemBuilder: (contextListView, index) {
                          return Card(
                            child: ListTile(
                              tileColor:
                                  posicionDignidadSeleccionada == index ? Theme.of(context).secondaryHeaderColor : null,
                              title: Text(dignidadesDto[index].nombre!, style: const TextStyle(fontSize: 16)),
                              onTap: () {
                                ref
                                    .read(estadisticaProvider.notifier)
                                    .changePosicionDignidadSeleccionadaState(dignidadesDto[index].id!);

                                setState(() {
                                  posicionDignidadSeleccionada = index;
                                });
                              },
                            ),
                          );
                        }),
                    const SizedBox(height: 20),
                    const Text("Ubicaciones", style: TextStyle(fontSize: 20)),
                    if (posicionDignidadSeleccionada == 0)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            PrefectoUbicacionWidget(),
                          ],
                        ),
                      ),
                    if (posicionDignidadSeleccionada == 1)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            // Dropdown para provincia
                            AlcaldeUbicacionWidget()
                          ],
                        ),
                      ),
                    if (posicionDignidadSeleccionada == 2)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            // Dropdown para provincia
                            ConcejalesUrbanosUbicacionWidget()
                          ],
                        ),
                      ),
                    if (posicionDignidadSeleccionada == 3)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            // Dropdown para provincia
                            ConcejalesRuralesUbicacionWidget()
                          ],
                        ),
                      ),
                    if (posicionDignidadSeleccionada == 4)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            // Dropdown para provincia
                            VocalesJuntasParroquialesUbicacionWidget()
                          ],
                        ),
                      ),
                    if (posicionDignidadSeleccionada == 5)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            // Dropdown para provincia
                            ConcejalesUrbanosCircunscripcionUbicacionWidget()
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            frontLayer: chartEstadisticas(estadisticasNotifier, dignidadesDto),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }

  Padding chartEstadisticas(EstadisticaModel estadisticasNotifier, List<DignidadDto> dignidadesDto) {
    String titulo = '';

    if (estadisticasNotifier.posicionDignidadSeleccionada! > -1) {
      // Se le resta 2 porque se elimino del array la primera posicion y porque se est[a el id
      // estadisticasNotifier.posicionDignidadSeleccionada es el id de la base de datos que va del 1 al 7
      titulo = dignidadesDto[estadisticasNotifier.posicionDignidadSeleccionada! - 2].nombre!;
    }

    String subtitulo = '';
    if (estadisticasNotifier.seSeleccionoProvincia!) {
      subtitulo = estadisticasNotifier.provinciaSeleccionada!.nombre;
    }

    if (estadisticasNotifier.seSeleccionoCanton!) {
      subtitulo = '$subtitulo - ${estadisticasNotifier.cantonSeleccionado!.nombre}';
    }

    if (estadisticasNotifier.seSeleccionoParroquia!) {
      subtitulo = '$subtitulo - ${estadisticasNotifier.parroquiaSeleccionada!.nombre}';
    }

    int numeroVotos = estadisticasNotifier.respuestaSumatoriaVotosPorMovimiento!
        .fold(0, (int previousValue, VotosMovimientoDto voto) => previousValue + voto.sumatoria!);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
                child: Column(
              children: [
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Text(subtitulo, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('Votos totales $numeroVotos', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
              ],
            )),
            if (numeroVotos == 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 50),
                  Center(child: Text("No se han registrado datos para esta dignidad en la ubicación seleccionada.")),
                ],
              ),
            if (numeroVotos > 0)
              SizedBox(
                height: 500,
                child: SfCartesianChart(
                    isTransposed: false,
                    enableAxisAnimation: true,
                    tooltipBehavior: TooltipBehavior(
                      animationDuration: 5,
                      tooltipPosition: TooltipPosition.auto,
                    ),
                    primaryXAxis: CategoryAxis(
                      maximumLabelWidth: 80,
                      title: AxisTitle(
                          text: 'Movimiento',
                          textStyle: const TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          )),
                      labelPosition: ChartDataLabelPosition.outside,
                      labelAlignment: LabelAlignment.center,
                      labelRotation: 0,
                      labelStyle: const TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                      ),
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: const MajorTickLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      autoScrollingMode: AutoScrollingMode.start,
                      labelFormat: '{value}%',
                      title: AxisTitle(
                          text: '% de Votos',
                          textStyle: const TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          )),
                      anchorRangeToVisiblePoints: false,
                      labelStyle: const TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                      ),
                    ),
                    series: [
                      BarSeries<VotosMovimientoDto, String>(
                          dataSource: estadisticasNotifier.respuestaSumatoriaVotosPorMovimiento!,
                          xValueMapper: (VotosMovimientoDto dignidades, _) {
                            String tituloMovimiento;

                            if (dignidades.movimiento == 'NULO' || dignidades.movimiento == 'BLANCO') {
                              tituloMovimiento = "${dignidades.movimiento} (${dignidades.sumatoria})";
                            } else {
                              String numeroMovimiento =
                                  (dignidades.numeroMovimiento == null) ? 'S/N' : dignidades.numeroMovimiento!;
                              tituloMovimiento =
                                  "Lista $numeroMovimiento (${dignidades.sumatoria}) ${dignidades.movimiento} \n ${dignidades.nombreCandidato}";
                            }

                            return tituloMovimiento;
                          },
                          yValueMapper: (VotosMovimientoDto dignidades, _) =>
                              double.parse(((dignidades.sumatoria! * 100) / numeroVotos).toStringAsFixed(2)),
                          isVisibleInLegend: true,
                          isTrackVisible: true,
                          sortFieldValueMapper: (VotosMovimientoDto dignidades, _) => dignidades.sumatoria,
                          pointColorMapper: (VotosMovimientoDto dignidades, _) =>
                              HexColor.fromHex(dignidades.colorMovimiento!),
                          dataLabelSettings: const DataLabelSettings(
                              labelPosition: ChartDataLabelPosition.inside,
                              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                              showZeroValue: true,
                              angle: 0,
                              alignment: ChartAlignment.center,
                              isVisible: true,
                              labelAlignment: ChartDataLabelAlignment.auto),
                          emptyPointSettings: EmptyPointSettings(
                              // Mode of empty point
                              mode: EmptyPointMode.zero)),
                    ]),
              ),
          ],
        ),
      ),
    );
  }
}
