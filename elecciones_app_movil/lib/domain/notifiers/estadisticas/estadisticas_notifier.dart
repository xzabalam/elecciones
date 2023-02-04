import 'package:elecciones_app_movil/data/model/ubicacion/circunscripcion.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/dignidad_dto.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/estadistica_model.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/numero_electores_dto.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/voto_movimiento_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EstadisticaNotifier extends StateNotifier<EstadisticaModel> {
  EstadisticaNotifier()
      : super(EstadisticaModel(
          numeroElectoresDto: NumeroElectoresDto(idUbicacion: -1, nombreUbicacion: "", cantidadElectores: 0),
          respuestaSumatoriaVotosPorMovimiento: const [],
          seGuardoEnProviderDignidades: false,
          posicionDignidadSeleccionada: -1,
          seSeleccionoPrefectos: false,
          seSeleccionoAlcaldes: false,
          seSeleccionoConcejalesUrbanos: false,
          seSeleccionoConcejalesRurales: false,
          seSeleccionoVocalesJuntasParroquiales: false,
          seSeleccionoConcejalesUrbanosPorCircunscripcion: false,
          seSeleccionoProvincia: false,
          seSeleccionoCanton: false,
          seSeleccionoParroquia: false,
          seSeleccionoCircunscripcion: false,
          provinciaSeleccionada: null,
          cantonSeleccionado: null,
          parroquiaSeleccionada: null,
          circunscripcionSeleccionada: null,
        ));

  void resetState() {
    state = EstadisticaModel(
      numeroElectoresDto: NumeroElectoresDto(idUbicacion: -1, nombreUbicacion: "", cantidadElectores: 0),
      respuestaSumatoriaVotosPorMovimiento: const [],
      seGuardoEnProviderDignidades: false,
      posicionDignidadSeleccionada: -1,
      seSeleccionoPrefectos: false,
      seSeleccionoAlcaldes: false,
      seSeleccionoConcejalesUrbanos: false,
      seSeleccionoConcejalesRurales: false,
      seSeleccionoVocalesJuntasParroquiales: false,
      seSeleccionoConcejalesUrbanosPorCircunscripcion: false,
      seSeleccionoProvincia: false,
      seSeleccionoCanton: false,
      seSeleccionoParroquia: false,
      seSeleccionoCircunscripcion: false,
      provinciaSeleccionada: null,
      cantonSeleccionado: null,
      parroquiaSeleccionada: null,
      circunscripcionSeleccionada: null,
    );
  }

  void changeDignidadesDtoState(List<DignidadDto> dignidadesDto) {
    state = state.copyWith(dignidadesDto: dignidadesDto);
  }

  void changeSeGuardoEnProviderDignidades(bool seGuardoEnProviderDignidades) {
    state = state.copyWith(seGuardoEnProviderDignidades: seGuardoEnProviderDignidades);
  }

  void changePosicionDignidadSeleccionadaState(int posicionDignidadSeleccionada) {
    resetState();
    state = state.copyWith(posicionDignidadSeleccionada: posicionDignidadSeleccionada);

    if (posicionDignidadSeleccionada == 2) {
      state = state.copyWith(seSeleccionoPrefectos: true);
    }

    // Se selecciono alcaldes
    if (posicionDignidadSeleccionada == 3) {
      state = state.copyWith(seSeleccionoAlcaldes: true);
    }

    // Se selecciono concejales urbanos
    if (posicionDignidadSeleccionada == 4) {
      state = state.copyWith(seSeleccionoConcejalesUrbanos: true);
    }

    // Se selecciono concejales rurales
    if (posicionDignidadSeleccionada == 5) {
      state = state.copyWith(seSeleccionoConcejalesRurales: true);
    }

    // Se selecciono vocales juntas parroquiales
    if (posicionDignidadSeleccionada == 6) {
      state = state.copyWith(seSeleccionoVocalesJuntasParroquiales: true);
    }
  }

  void changeCantidadTotalElectoresState(int cantidadTotalElectores) {
    state = state.copyWith(cantidadTotalElectores: cantidadTotalElectores);
  }

  void changeProvinciaSeleccionadaState(Provincia provinciaSeleccionada) {
    int posicionDignidadSeleccionada = state.posicionDignidadSeleccionada!;
    bool seSeleccionoPrefectos = state.seSeleccionoPrefectos!;
    bool seSeleccionoAlcaldes = state.seSeleccionoAlcaldes!;
    bool seSeleccionoConcejalesUrbanos = state.seSeleccionoConcejalesUrbanos!;
    bool seSeleccionoConcejalesRurales = state.seSeleccionoConcejalesRurales!;
    bool seSeleccionoVocalesJuntasParroquiales = state.seSeleccionoVocalesJuntasParroquiales!;
    bool seSeleccionoConcejalesUrbanosPorCircunscripcion = state.seSeleccionoConcejalesUrbanosPorCircunscripcion!;

    resetState();

    state = state.copyWith(
        posicionDignidadSeleccionada: posicionDignidadSeleccionada,
        seSeleccionoPrefectos: seSeleccionoPrefectos,
        seSeleccionoAlcaldes: seSeleccionoAlcaldes,
        seSeleccionoConcejalesUrbanos: seSeleccionoConcejalesUrbanos,
        seSeleccionoConcejalesRurales: seSeleccionoConcejalesRurales,
        seSeleccionoVocalesJuntasParroquiales: seSeleccionoVocalesJuntasParroquiales,
        seSeleccionoConcejalesUrbanosPorCircunscripcion: seSeleccionoConcejalesUrbanosPorCircunscripcion,
        seSeleccionoProvincia: true,
        provinciaSeleccionada: provinciaSeleccionada);
  }

  void changeCantonSeleccionadoState(Canton cantonSeleccionado) {
    int posicionDignidadSeleccionada = state.posicionDignidadSeleccionada!;
    bool seSeleccionoPrefectos = state.seSeleccionoPrefectos!;
    bool seSeleccionoAlcaldes = state.seSeleccionoAlcaldes!;
    bool seSeleccionoConcejalesUrbanos = state.seSeleccionoConcejalesUrbanos!;
    bool seSeleccionoConcejalesRurales = state.seSeleccionoConcejalesRurales!;
    bool seSeleccionoVocalesJuntasParroquiales = state.seSeleccionoVocalesJuntasParroquiales!;
    bool seSeleccionoConcejalesUrbanosPorCircunscripcion = state.seSeleccionoConcejalesUrbanosPorCircunscripcion!;
    bool seSeleccionoProvincia = state.seSeleccionoProvincia!;
    Provincia provinciaSeleccionada = state.provinciaSeleccionada!;

    resetState();

    state = state.copyWith(
        posicionDignidadSeleccionada: posicionDignidadSeleccionada,
        seSeleccionoPrefectos: seSeleccionoPrefectos,
        seSeleccionoAlcaldes: seSeleccionoAlcaldes,
        seSeleccionoConcejalesUrbanos: seSeleccionoConcejalesUrbanos,
        seSeleccionoConcejalesRurales: seSeleccionoConcejalesRurales,
        seSeleccionoVocalesJuntasParroquiales: seSeleccionoVocalesJuntasParroquiales,
        seSeleccionoConcejalesUrbanosPorCircunscripcion: seSeleccionoConcejalesUrbanosPorCircunscripcion,
        seSeleccionoProvincia: seSeleccionoProvincia,
        seSeleccionoCanton: true,
        provinciaSeleccionada: provinciaSeleccionada,
        cantonSeleccionado: cantonSeleccionado,
        seSeleccionoCircunscripcion: false,
        circunscripcionSeleccionada: null);
  }

  void changeParroquiaSeleccionadaState(Parroquia parroquiaSeleccionada) {
    state = state.copyWith(parroquiaSeleccionada: parroquiaSeleccionada, seSeleccionoParroquia: true);
  }

  void changeCircunscripcionSeleccionadaState(Circunscripcion circunscripcion) {
    state = state.copyWith(
        circunscripcionSeleccionada: circunscripcion, seSeleccionoConcejalesUrbanosPorCircunscripcion: true);
  }

  void changeNumeroElectoresState(NumeroElectoresDto numeroElectoresDto) {
    state = state.copyWith(numeroElectoresDto: numeroElectoresDto);
  }

  void changeSumatoriaVotos(List<VotosMovimientoDto> respuestaSumatoriaVotosPorMovimiento) {
    state = state.copyWith(respuestaSumatoriaVotosPorMovimiento: respuestaSumatoriaVotosPorMovimiento);
  }
}

final estadisticaProvider = StateNotifierProvider<EstadisticaNotifier, EstadisticaModel>((ref) {
  return EstadisticaNotifier();
});
