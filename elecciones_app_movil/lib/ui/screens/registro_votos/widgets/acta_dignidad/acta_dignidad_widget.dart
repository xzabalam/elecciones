import 'package:elecciones_app_movil/data/model/candidato/dignidad_ubicacion.dart';
import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:elecciones_app_movil/domain/providers/candidatos/acta_dignidad_provider.dart';
import 'package:elecciones_app_movil/domain/providers/candidatos/voto_provider.dart';
import 'package:elecciones_app_movil/domain/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActaDignidadWidget extends ConsumerWidget {
  const ActaDignidadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final posicion = ref.watch(actaDignidadProvider).posicionDignidadSeleccionada ?? -1;
    final votosFutureProvider = ref.watch(votoFutureProvider(ubicacionNotifier.juntaSeleccionada!));

    return votosFutureProvider.when(
        data: (votos) {
          List<DignidadUbicacion>? dignidadUbicaciones =
              votos.map((voto) => voto.actaDignidad!.dignidadUbicacion).toSet().toList();

          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              itemCount: dignidadUbicaciones.length,
              itemBuilder: (context, index) {
                String? titulo = dignidadUbicaciones[index]!.dignidad.nombre;
                String icono = dignidadUbicaciones[index]!.dignidad!.tipoGrupo!.nombre;
                return Card(
                  child: ListTile(
                    tileColor: posicion == index ? Theme.of(context).secondaryHeaderColor : null,
                    leading: icono == 'INDIVIDUAL'
                        ? const Icon(Icons.person_2_outlined)
                        : const Icon(Icons.people_alt_outlined),
                    title: Text(titulo!, style: const TextStyle(fontSize: 16)),
                    onTap: () {
                      ref.read(votoProvider.notifier).resetVotosModificadosYTextControllerState();

                      var actaDignidadNotifierProvider = ref.read(actaDignidadProvider.notifier);
                      actaDignidadNotifierProvider.changePosicionDignidadSeleccionadaState(index);
                      actaDignidadNotifierProvider
                          .changeDignidadUbicacionSeleccionadaState(dignidadUbicaciones[index]!);

                      List<Voto> votosFiltrados = votos
                          .where((voto) => voto.actaDignidad!.dignidadUbicacion == dignidadUbicaciones[index]!)
                          .toList();

                      ref.read(votoProvider.notifier).changeListadoVotosFiltradosPorDignidadState(votosFiltrados);
                    },
                  ),
                );
              });
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgessIndicatorCustomWidget());
  }
}
