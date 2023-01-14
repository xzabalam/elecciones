import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/businness/providers/model/voto/voto_model.dart';
import 'package:elecciones_app_movil/businness/providers/model/voto/voto_seleccionado_model.dart';
import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VotoNotifier extends StateNotifier<VotoModel> {
  VotoNotifier() : super(VotoModel());

  void resetState() {
    state = VotoModel();
  }

  void resetVotosModificadosState() {
    state = state.copyWith(votosModificados: {});
  }

  void changeListadoVotosState(List<Voto> votos) {
    state = state.copyWith(votos: votos);
  }

  void changeListadoVotosFiltradosPorDignidadState(List<Voto> votosFiltrados) {
    state = state.copyWith(votosFiltradosPorDignidad: votosFiltrados);
  }

  void updateStateWithNewlyChangedVotes(Voto votoActualizado) {
    state.votos!.where((voto) => voto.id == votoActualizado.id).first.copyWith(cantidad: votoActualizado.cantidad);
  }

  void addVotoModificadoToState(Map<int, VotoModificadoModel> votoModificadoModel) {
    state = state.copyWith(votosModificados: votoModificadoModel);
  }
}

final votoProvider = StateNotifierProvider<VotoNotifier, VotoModel>((ref) {
  return VotoNotifier();
});

final votoFutureProvider = FutureProvider.autoDispose.family<List<Voto>, Junta>((ref, juntaSeleccionada) async {
  String token = ref
      .read(authTokenProvider)
      .basicToken;

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
          'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!
              .nombre} ${response.data['error']}');
    }
  } catch (e) {
    throw Exception(
        'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre} ${e
            .toString()}');
  }
});

final cambiarCantidadVotoFutureProvider =
FutureProvider.autoDispose.family<bool, VotoModificadoModel>((ref, votoSeleccionadoModel) async {
  String token = ref
      .read(authTokenProvider)
      .basicToken;

  final Dio dio = Dio();
  try {
    final response = await dio.post('${Env.clientApiUrl}/voto',
        data: votoSeleccionadoModel, options: Options(headers: {'Authorization': token}));

    return (response.statusCode == 200);
  } catch (e) {
    print(e);
    throw Exception(
        'No fue posible guardar la cantidad de votos para la junta ${votoSeleccionadoModel
            .idJunta} - y la dignidad ${votoSeleccionadoModel.idActaDignidad}');
  }
});
