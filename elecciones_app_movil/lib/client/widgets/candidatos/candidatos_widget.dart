import 'package:elecciones_app_movil/businness/providers/candidatos/acta_dignidad_provider.dart';
import 'package:elecciones_app_movil/businness/providers/candidatos/voto_provider.dart';
import 'package:elecciones_app_movil/businness/providers/model/voto/voto_seleccionado_model.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/client/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:elecciones_app_movil/data/model/candidato/grupo_candidato.dart';
import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CandidatosStatefullWidget extends ConsumerStatefulWidget {
  const CandidatosStatefullWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CandidatosStatefullWidgetState();
}

class _CandidatosStatefullWidgetState
    extends ConsumerState<CandidatosStatefullWidget> {
  final ScrollController _scrollControllerListView = ScrollController();
  final ScrollController _scrollController = ScrollController();
  List<TextEditingController> textControllers = [];
  List<bool> seGuardoVotoLista = [];

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final votoNotifier = ref.watch(votoProvider);
    final dignidadNotifier = ref.watch(actaDignidadProvider);

    List<Voto> votos = votoNotifier.votos!
        .where((voto) =>
            voto.actaDignidad!.dignidadUbicacion ==
            dignidadNotifier.dignidadUbicacionSeleccionada)
        .toList();

    return Column(
      children: [
        Text(dignidadNotifier.dignidadUbicacionSeleccionada!.dignidad!.nombre,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        movimientoListViewWidget(votos),
      ],
    );
  }

  ListView movimientoListViewWidget(List<Voto> votos) {
    List<GrupoCandidato> grupoCandidatos = votos.map((voto) {
      seGuardoVotoLista.add(false);
      textControllers
          .add(TextEditingController(text: voto.cantidad.toString()));
      return voto.grupoCandidato!;
    }).toList();

    return ListView.builder(
        controller: _scrollControllerListView,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        itemCount: grupoCandidatos.length,
        itemBuilder: (context, index) {
          String? titulo = grupoCandidatos[index]!.movimiento!.nombre;
          // Crear una lista de widgets
          List<Widget> candidatosWidget =
              generarCandidatosWidgets(grupoCandidatos, index);
          return Card(
              elevation: 1,
              shadowColor: Colors.black87,
              color: Colors.white70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Para registrar el numero de votos por el grupo de candidatos
                  registroNumeroVotos(votos![index], index),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Titulo de la tarjeta
                        tituloTarjeta(titulo!),
                        const SizedBox(height: 15),
                        // Listado de candidatos
                        candidatosScrollViewWidget(candidatosWidget)
                      ])
                ],
              ));
        });
  }

  SizedBox tituloTarjeta(String titulo) {
    return SizedBox(
      width: 216,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            textAlign: TextAlign.center,
            titulo!,
            softWrap: true,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          )),
    );
  }

  Widget registroNumeroVotos(Voto voto, int posicion) {
    return Container(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 90,
          height: 115,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'VOTOS',
                  style: TextStyle(color: Colors.white),
                ),
                TextFormField(
                  controller: textControllers[posicion],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  minLines: 1,
                  onEditingComplete: () {
                    setState(() {
                      seGuardoVotoLista[posicion] = true;
                    });
                  },
                ),
                const SizedBox(height: 3),
                if (seGuardoVotoLista[posicion])
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      fixedSize: const Size(90, 20),
                    ),
                    onPressed: () {
                      VotoSeleccionadoModel votoSeleccionadoModel =
                          VotoSeleccionadoModel(
                              cantidadVoto:
                                  int.parse(textControllers[posicion].text),
                              idJunta: ref
                                  .read(ubicacionProvider)
                                  .juntaSeleccionada!
                                  .id,
                              idActaDignidad: voto.actaDignidad!.id,
                              idVoto: voto.id);

                      ref
                          .read(cambiarCantidadVotoFutureProvider
                              .call(votoSeleccionadoModel))
                          .whenData((value) => {print(value)});
                    },
                    child: const Text('Guardar',
                        style: TextStyle(fontSize: 10, color: Colors.white)),
                  )
              ]),
        ),
      ),
    );
  }

  SizedBox candidatosScrollViewWidget(List<Widget> candidatosWidget) {
    return SizedBox(
      width: 200,
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: candidatosWidget,
            )),
      ),
    );
  }

  List<SizedBox> generarCandidatosWidgets(
      List<GrupoCandidato> grupoCandidatos, int index) {
    return grupoCandidatos[index]!
        .candidatos!
        .where((candidato) =>
            candidato!.nombre! != 'BLANCO' && candidato!.nombre! != 'NULO')
        .map((candidato) {
      return SizedBox(
        width: 100,
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_2_rounded,
                size: 20, color: Colors.blueGrey),
            Text(
                textAlign: TextAlign.center,
                candidato!.nombre!,
                style: const TextStyle(fontSize: 10, color: Colors.blueGrey))
          ],
        ),
      );
    }).toList();
  }
}

class BotonGuardar extends ConsumerWidget {
  VotoSeleccionadoModel votoSeleccionadoModel;

  BotonGuardar({Key? key, required this.votoSeleccionadoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cambiarCantidadVotoProvider =
        ref.watch(cambiarCantidadVotoFutureProvider(votoSeleccionadoModel));
    return cambiarCantidadVotoProvider.when(
        data: (data) {
          print(data);
          return Text('ok');
        },
        error: (error, stackTrace) {
          print(error);
          return Text('error');
        },
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
