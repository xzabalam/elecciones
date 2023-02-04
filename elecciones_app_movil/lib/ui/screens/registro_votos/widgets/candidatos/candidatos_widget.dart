import 'package:adaptive_button/adaptive_button.dart';
import 'package:elecciones_app_movil/data/model/candidato/candidato.dart';
import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:elecciones_app_movil/domain/model/voto/voto_seleccionado_model.dart';
import 'package:elecciones_app_movil/domain/notifiers/candidatos/acta_dignidad_notifier.dart';
import 'package:elecciones_app_movil/domain/notifiers/candidatos/voto_notifier.dart';
import 'package:elecciones_app_movil/domain/providers/candidatos/voto_provider.dart';
import 'package:elecciones_app_movil/ui/screens/registro_votos/widgets/candidatos/widgets/escribir_texto_widget.dart';
import 'package:elecciones_app_movil/ui/widgets/commons/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CandidatoWidget extends ConsumerWidget {
  const CandidatoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController _scrollController = ScrollController();

    final dignidadNotifier = ref.watch(actaDignidadProvider);
    final votoNotifier = ref.watch(votoProvider);

    List<Voto> votos = votoNotifier.votosFiltradosPorDignidad!;

    return Column(children: [
      Center(
        child: Text(dignidadNotifier.dignidadUbicacionSeleccionada!.dignidad!.nombre,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 28),
      ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          itemCount: votos.length,
          itemBuilder: (context, index) {
            String? titulo = votos[index]!.grupoCandidato!.movimiento!.nombre;
            String? subtitulo = votos[index]!.grupoCandidato!.movimiento!.numero;
            List<Candidato?> candidatos = votos[index]!
                .grupoCandidato!
                .candidatos!
                .where((candidato) => candidato!.nombre! != 'BLANCO' && candidato!.nombre! != 'NULO')
                .toList();
            return Card(
                elevation: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // -----------------------------------
                    // Para registrar el numero de votos por el grupo de candidatos
                    // -----------------------------------
                    Container(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      child: SizedBox(
                        width: 110,
                        height: 178,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('VOTOS'),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: ref.read(votoProvider).textEditingController![index],
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(counterText: '', contentPadding: EdgeInsets.zero),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  minLines: 1,
                                  maxLength: 4,
                                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                  onTap: () => ref.read(votoProvider).textEditingController![index].selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset:
                                              ref.read(votoProvider).textEditingController![index].value.text.length),
                                  onChanged: (texto) {
                                    Map<int, VotoModificadoModel> votosModel = ref.read(votoProvider).votosModificados!;
                                    votosModel[votos[index].id!] = VotoModificadoModel(
                                        idVoto: votos[index].id!,
                                        idActaDignidad: votos[index].actaDignidad!.id!,
                                        cantidadVoto:
                                            int.parse(ref.read(votoProvider).textEditingController![index].text));
                                    ref.read(votoProvider.notifier).addVotoModificadoToState(votosModel);
                                  },
                                ),
                                const SizedBox(height: 3),
                              ]),
                        ),
                      ),
                    ),
                    // -----------------------------------
                    // Datos del movimiento y de la lista
                    // -----------------------------------
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // N[umero de la lista
                          if (titulo! != 'BLANCO' && titulo! != 'NULO')
                            EscribirTextoWidget(texto: 'Lista ${subtitulo!}'),

                          // Nombre del movimiento
                          EscribirTextoWidget(texto: titulo!),

                          // Listado de candidatos
                          if (candidatos!.isNotEmpty)
                            SizedBox(
                              width: 210,
                              height: 88,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: candidatos!.map((candidato) {
                                        return SizedBox(
                                          width: 125,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.person_2_rounded,
                                                size: 16,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(
                                                    textAlign: TextAlign.center,
                                                    candidato!.nombre!,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              ),
                            ),
                        ])
                  ],
                ));
          }),
      // -----------------------------------
      // Boton para guardar los cambios en los votos
      // -----------------------------------
      AdaptiveButton(
        width: 125,
        borderRadius: BorderRadius.circular(5),
        enabledLoading: true,
        loadingWidget: const SizedBox(width: 20, height: 20, child: CircularProgessIndicatorCustomWidget()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.save_outlined),
            Text("Guardar"),
          ],
        ),
        onPressed: () async {
          if (votoNotifier.votosModificados!.isEmpty) {
            mostrarMensaje(context, "Antes de guardar, primero debe modificar los votos.");
            return;
          }

          List<VotoModificadoModel> votosModificados =
              ref.read(votoProvider).votosModificados!.entries.map((e) => e.value).toList();

          final bool seGuardo = await ref.read(cambiarCantidadVotoFutureProvider(votosModificados).future);

          if (seGuardo) {
            for (VotoModificadoModel votoModificadoModel in votosModificados) {
              ref
                  .read(votoProvider.notifier)
                  .updateStateWithNewlyChangedVotes(votoModificadoModel.idVoto!, votoModificadoModel.cantidadVoto!);
            }
          } else {
            mostrarMensaje(context, "Hubo un error al guardar los votos.");
          }

          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Los datos se guardaron correctamente."),
              );
            },
          );
        },
      ),
    ]);
  }

  void mostrarMensaje(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
