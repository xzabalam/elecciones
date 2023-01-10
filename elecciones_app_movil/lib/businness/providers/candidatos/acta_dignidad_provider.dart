import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/businness/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/businness/providers/model/acta_dignidad/acta_dignidad_model.dart';
import 'package:elecciones_app_movil/config/env/env.dart';
import 'package:elecciones_app_movil/data/model/candidato/acta_dignidad.dart';
import 'package:elecciones_app_movil/data/model/candidato/dignidad_ubicacion.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ActaDignidadNotifier extends StateNotifier<ActaDignidadModel> {
  ActaDignidadNotifier() : super(ActaDignidadModel());

  void resetState() {
    state = ActaDignidadModel();
  }

  void changeDignidadUbicacionSeleccionadaState(
      DignidadUbicacion dignidadUbicacion) {
    state = state.copyWith(dignidadUbicacionSeleccionada: dignidadUbicacion);
  }

  void changePosicionDignidadSeleccionadaState(int posicion) {
    state = state.copyWith(posicionDignidadSeleccionada: posicion);
  }
}

@riverpod
final actaDignidadProvider =
    StateNotifierProvider<ActaDignidadNotifier, ActaDignidadModel>((ref) {
  return ActaDignidadNotifier();
});

@riverpod
final actaDignidadFutureProvider = FutureProvider.autoDispose
    .family<List<ActaDignidad>, Junta>((ref, juntaSeleccionada) async {
  String token = ref.read(authTokenProvider).basicToken;

  final Dio dio = Dio();
  try {
    final response = await dio.get(
        '${Env.clientApiUrl}/acta-dignidad/junta/${juntaSeleccionada.id}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      List<ActaDignidad> actasDignidad =
          (response.data as List).map((actaDignidad) {
        return ActaDignidad.fromMap(actaDignidad);
      }).toList();

      return actasDignidad;
    } else {
      throw Exception(
          'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre} ${response.data['error']}');
    }
  } catch (e) {
    throw Exception(
        'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre} ${e.toString()}');
  }
});
