import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:elecciones_app_movil/domain/model/voto/voto_model.dart';
import 'package:elecciones_app_movil/domain/model/voto/voto_seleccionado_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class VotoNotifier extends StateNotifier<VotoModel> {
  VotoNotifier() : super(VotoModel(textEditingController: []));

  void resetState() {
    state = VotoModel();
  }

  void resetVotosModificadosState() {
    state = state.copyWith(votosModificados: {});
  }

  void resetVotosModificadosYTextControllerState() {
    if (state.textEditingController != null && state.textEditingController!.isNotEmpty) {
      for (var controller in state.textEditingController!) {
        controller.clear();
        controller.dispose();
      }
    }

    state = state.copyWith(votosModificados: {}, textEditingController: []);
  }

  void changeListadoVotosState(List<Voto> votos) {
    state = state.copyWith(votos: votos);
  }

  void changeListadoVotosFiltradosPorDignidadState(List<Voto> votosFiltrados) {
    List<TextEditingController> textEditingController = [];
    for (Voto voto in votosFiltrados) {
      textEditingController.add(TextEditingController(text: voto.cantidad.toString()));
    }
    state = state.copyWith(votosFiltradosPorDignidad: votosFiltrados, textEditingController: textEditingController);
  }

  void updateStateWithNewlyChangedVotes(int idVoto, int cantidad) {
    state.votosFiltradosPorDignidad!.firstWhere((voto) => voto.id == idVoto).cantidad = cantidad;
  }

  void addVotoModificadoToState(Map<int, VotoModificadoModel> votoModificadoModel) {
    state = state.copyWith(votosModificados: votoModificadoModel);
  }
}

final votoProvider = StateNotifierProvider<VotoNotifier, VotoModel>((ref) {
  return VotoNotifier();
});
