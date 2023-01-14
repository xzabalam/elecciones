import 'package:elecciones_app_movil/businness/providers/candidatos/acta_dignidad_provider.dart';
import 'package:elecciones_app_movil/businness/providers/candidatos/voto_provider.dart';
import 'package:elecciones_app_movil/businness/providers/model/voto/voto_seleccionado_model.dart';
import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/client/screens/registro_votos/widgets/candidatos/widgets/escribir_texto_widget.dart';
import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
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
    final ubicacionNotifier = ref.watch(ubicacionProvider);
    final votoNotifier = ref.watch(votoProvider);

    int idJunta = ubicacionNotifier.juntaSeleccionada!.id;
    List<Voto> votos = votoNotifier.votosFiltradosPorDignidad!;

    print('pagina candidatos $votos');

    return Column(
      children: [
        Text(dignidadNotifier.dignidadUbicacionSeleccionada!.dignidad!.nombre,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
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
                          height: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('VOTOS'),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: null,
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
                                    initialValue:
                                        votos[index].cantidad == null ? '0' : votos[index].cantidad!.toString(),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        ref.read(votoProvider.notifier).addVotoModificadoToState({
                                          ...votoNotifier.votosModificados!,
                                          ...{
                                            votos[index].id!: VotoModificadoModel(
                                                idVoto: votos[index].id!,
                                                idActaDignidad: votos[index].actaDignidad!.id!,
                                                idJunta: idJunta,
                                                cantidadVoto: int.parse(text))
                                          }
                                        });
                                      }
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
                            SizedBox(
                              width: 210,
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Scrollbar(
                                  controller: _scrollController,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: votos[index]!
                                            .grupoCandidato!
                                            .candidatos!
                                            .where((candidato) =>
                                                candidato!.nombre! != 'BLANCO' && candidato!.nombre! != 'NULO')
                                            .map((candidato) {
                                          return SizedBox(
                                            width: 100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.person_2_rounded, size: 20),
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
                            ),
                          ])
                    ],
                  ));
            }),
        // -----------------------------------
        // Boton para guardar los cambios en los votos
        // -----------------------------------
        ElevatedButton.icon(
            onPressed: votoNotifier.votosModificados!.isEmpty
                ? null
                : () {
                    print(votoNotifier.votosModificados!.length);
                    print(votoNotifier.votosModificados!);
                  },
            icon: const Icon(Icons.save_outlined),
            label: const Text('Guardar'))
      ],
    );
  }
}
