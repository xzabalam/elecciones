import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/domain/providers/model/voto/voto_model.dart';
import 'package:elecciones_app_movil/domain/providers/model/voto/voto_seleccionado_model.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

/// ------------------------------------------------------------------
/// Permite obtener los votos por la junta
/// ------------------------------------------------------------------
final votoFutureProvider = FutureProvider.autoDispose.family<List<Voto>, Junta>((ref, juntaSeleccionada) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = Dio();
  try {
    final response = await dio.get('${Env.clientApiUrl}/voto/junta/${juntaSeleccionada.id}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      List<Voto> votos = (response.data as List).map((voto) {
        return Voto.fromMap(voto);
      }).toList();

      ref.read(votoProvider.notifier).changeListadoVotosState(votos);

      return votos;
    } else {
      throw Exception(
          'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre} ${response.data['error']}');
    }
  } catch (e) {
    throw Exception(
        'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre} ${e.toString()}');
  }
});

/// ------------------------------------------------------------------
/// Permite actualizar en base de datos la cantidad de votos por acta
/// ------------------------------------------------------------------
final cambiarCantidadVotoFutureProvider =
    FutureProvider.autoDispose.family<bool, List<VotoModificadoModel>>((ref, votosSeleccionadoModel) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = Dio();
  try {
    final response = await dio.post('${Env.clientApiUrl}/voto',
        data: votosSeleccionadoModel, options: Options(headers: {'Authorization': token}));

    return (response.statusCode == 200);
  } catch (e) {
    throw Exception('No fue posible guardar los votos.');
  }
});
