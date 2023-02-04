import 'package:elecciones_app_movil/data/model/candidato/dignidad_ubicacion.dart';
import 'package:elecciones_app_movil/domain/model/acta_dignidad/acta_dignidad_model.dart';
import 'package:riverpod/riverpod.dart';

class ActaDignidadNotifier extends StateNotifier<ActaDignidadModel> {
  ActaDignidadNotifier() : super(ActaDignidadModel());

  void resetState() {
    state = ActaDignidadModel();
  }

  void changeDignidadUbicacionSeleccionadaState(DignidadUbicacion dignidadUbicacion) {
    state = state.copyWith(dignidadUbicacionSeleccionada: dignidadUbicacion);
  }

  void changePosicionDignidadSeleccionadaState(int posicion) {
    state = state.copyWith(posicionDignidadSeleccionada: posicion);
  }

  void changeListaDiginidadesState(List<DignidadUbicacion> dignidades) {
    state = state.copyWith(dignidadUbicaciones: dignidades);
  }
}

final actaDignidadProvider = StateNotifierProvider<ActaDignidadNotifier, ActaDignidadModel>((ref) {
  return ActaDignidadNotifier();
});
