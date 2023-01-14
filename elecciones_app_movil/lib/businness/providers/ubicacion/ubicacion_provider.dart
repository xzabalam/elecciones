import 'package:elecciones_app_movil/businness/providers/model/ubicacion/ubicacion_model.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UbicacionNotifier extends StateNotifier<UbicacionModel> {
  UbicacionNotifier() : super(UbicacionModel());

  void resetState() {
    state = UbicacionModel();
  }

  void changePaisSeleccionadoSatate(Pais pais) {
    state = UbicacionModel(paisSeleccionado: pais);
  }

  void changeProvinciaSeleccionadaSatate(Provincia provincia) {
    state = UbicacionModel(
        paisSeleccionado: state.paisSeleccionado,
        provinciaSeleccionada: provincia);
  }

  void changeCantonSeleccionadoSatate(Canton canton) {
    state = UbicacionModel(
        paisSeleccionado: state.paisSeleccionado,
        provinciaSeleccionada: state.provinciaSeleccionada,
        cantonSeleccionado: canton);
  }

  void changeParroquiaSeleccionadaSatate(Parroquia parroquia) {
    state = UbicacionModel(
        paisSeleccionado: state.paisSeleccionado,
        provinciaSeleccionada: state.provinciaSeleccionada,
        cantonSeleccionado: state.cantonSeleccionado,
        parroquiaSeleccionada: parroquia);
  }

  void changeZonaSeleccionadaSatate(Zona zona) {
    state = UbicacionModel(
        paisSeleccionado: state.paisSeleccionado,
        provinciaSeleccionada: state.provinciaSeleccionada,
        cantonSeleccionado: state.cantonSeleccionado,
        parroquiaSeleccionada: state.parroquiaSeleccionada,
        zonaSeleccionada: zona);
  }

  void changeRecintoSeleccionadoSatate(Recinto recinto) {
    state = UbicacionModel(
        paisSeleccionado: state.paisSeleccionado,
        provinciaSeleccionada: state.provinciaSeleccionada,
        cantonSeleccionado: state.cantonSeleccionado,
        parroquiaSeleccionada: state.parroquiaSeleccionada,
        zonaSeleccionada: state.zonaSeleccionada,
        recintoSeleccionado: recinto);
  }

  void changeJuntaSeleccionadaSatate(Junta junta) {
    state = UbicacionModel(
        paisSeleccionado: state.paisSeleccionado,
        provinciaSeleccionada: state.provinciaSeleccionada,
        cantonSeleccionado: state.cantonSeleccionado,
        parroquiaSeleccionada: state.parroquiaSeleccionada,
        zonaSeleccionada: state.zonaSeleccionada,
        recintoSeleccionado: state.recintoSeleccionado,
        juntaSeleccionada: junta);
  }
}

final ubicacionProvider =
    StateNotifierProvider<UbicacionNotifier, UbicacionModel>((ref) {
  return UbicacionNotifier();
});
