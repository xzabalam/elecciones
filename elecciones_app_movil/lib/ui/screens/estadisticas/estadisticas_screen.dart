import 'package:backdrop/backdrop.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/dignidad_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/voto_movimiento_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/estadisticas_provider.dart';
import 'package:elecciones_app_movil/domain/providers/model/estadisticas/estadistica_model.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/alcaldes_ubicaciones_widget.dart';
import 'package:elecciones_app_movil/ui/screens/estadisticas/widgets/concejales_rurales_ubicaciones_widget.dart';
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
              title: Text("Filtros"),
            ),
            stickyFrontLayer: false,
            revealBackLayerAtStart: true,
            backLayer: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Text("Dignidades", style: TextStyle(color: Colors.white, fontSize: 20)),
                    ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: dignidadesDto.length,
                        itemBuilder: (contextListView, index) {
                          String? titulo = dignidadesDto[index]!.nombre;

                          return Card(
                            child: ListTile(
                              tileColor: posicionDignidadSeleccionada == index ? Colors.amber : null,
                              leading: const Icon(Icons.people_alt_outlined),
                              title: Text(titulo!, style: const TextStyle(fontSize: 16)),
                              onTap: () {
                                ref.read(estadisticaProvider.notifier).changePosicionDignidadSeleccionadaState(index);
                                setState(() {
                                  posicionDignidadSeleccionada = index;
                                });
                                cambiarDignidadSeleccionada(dignidadesDto[index].id!, ref);
                              },
                            ),
                          );
                        }),
                    SizedBox(height: 20),
                    const Text("Ubicaciones", style: TextStyle(color: Colors.white, fontSize: 20)),
                    if (estadisticasNotifier.seSeleccionoPrefectos!)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: const [
                              PrefectoUbicacionWidget(),
                            ],
                          ),
                        ),
                      ),
                    if (estadisticasNotifier.seSeleccionoAlcaldes!)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: const [
                              // Dropdown para provincia
                              AlcaldeUbicacionWidget()
                            ],
                          ),
                        ),
                      ),
                    if (estadisticasNotifier.seSeleccionoConcejalesUrbanos!)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: const [
                              // Dropdown para provincia
                              ConcejalesUrbanosUbicacionWidget()
                            ],
                          ),
                        ),
                      ),
                    if (estadisticasNotifier.seSeleccionoConcejalesRurales!)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: const [
                              // Dropdown para provincia
                              ConcejalesRuralesUbicacionWidget()
                            ],
                          ),
                        ),
                      ),
                    if (estadisticasNotifier.seSeleccionoVocalesJuntasParroquiales!)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: const [
                              // Dropdown para provincia
                              VocalesJuntasParroquialesUbicacionWidget()
                            ],
                          ),
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
      titulo = dignidadesDto[estadisticasNotifier.posicionDignidadSeleccionada!].nombre!;
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
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Column(
            children: [
              Center(
                  child: Column(
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text(subtitulo, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  Text('Votos totales ${numeroVotos}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
                ],
              )),
              SizedBox(
                height: 520,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                        labelPosition: ChartDataLabelPosition.outside,
                        labelStyle: const TextStyle(fontSize: 9, color: Colors.black),
                        labelRotation: 270,
                        labelAlignment: LabelAlignment.start,
                        majorGridLines: const MajorGridLines(width: 0),
                        majorTickLines: const MajorTickLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift),
                    primaryYAxis: NumericAxis(
                        minimum: 0,
                        majorGridLines: const MajorGridLines(
                          width: 0,
                        )),
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                    ),
                    isTransposed: true,
                    series: <ChartSeries<VotosMovimientoDto, String>>[
                      BarSeries<VotosMovimientoDto, String>(
                          dataSource: estadisticasNotifier.respuestaSumatoriaVotosPorMovimiento!,
                          xValueMapper: (VotosMovimientoDto dignidades, _) =>
                              "${dignidades.movimiento!}. Votos:  ${dignidades.sumatoria!}",
                          yValueMapper: (VotosMovimientoDto dignidades, _) =>
                              double.parse(((dignidades.sumatoria! * 100) / numeroVotos).toStringAsFixed(2)),
                          isVisibleInLegend: true,
                          dataLabelSettings: const DataLabelSettings(
                              labelPosition: ChartDataLabelPosition.outside,
                              overflowMode: OverflowMode.shift,
                              isVisible: true,
                              labelAlignment: ChartDataLabelAlignment.outer),
                          emptyPointSettings: EmptyPointSettings(
                              // Mode of empty point
                              mode: EmptyPointMode.average)),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void cambiarDignidadSeleccionada(int idDignidad, WidgetRef ref) {
    // Se selecciono prefecto
    if (idDignidad == 2) {
      ref.read(estadisticaProvider.notifier).changeSeSeleccionoPrefectosState(true);
    }

    // Se selecciono alcaldes
    if (idDignidad == 3) {
      ref.read(estadisticaProvider.notifier).changeSeSeleccionoAlcaldesState(true);
    }

    // Se selecciono concejales urbanos
    if (idDignidad == 4) {
      ref.read(estadisticaProvider.notifier).changeSeSeleccionoConcejalesUrbanosState(true);
    }

    // Se selecciono concejales rurales
    if (idDignidad == 5) {
      ref.read(estadisticaProvider.notifier).changeSeSeleccionoConcejalesRuralesState(true);
    }

    // Se selecciono vocales juntas parroquiales
    if (idDignidad == 6) {
      ref.read(estadisticaProvider.notifier).changeSeSeleccionoVocalesJuntasParroquialesState(true);
    }
  }
}
