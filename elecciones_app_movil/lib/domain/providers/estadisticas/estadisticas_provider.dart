// Obtener el listado de dignidades
import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/providers/auth/token_provider.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/dignidad_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/numero_electores_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/parametros_consulta_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/voto_movimiento_dto.dart';
import 'package:elecciones_app_movil/domain/providers/model/estadisticas/estadistica_model.dart';
import 'package:elecciones_app_movil/env/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final EstadisticaModel estadisticaModelInicial = EstadisticaModel(
  numeroElectoresDto: NumeroElectoresDto(idUbicacion: -1, nombreUbicacion: "", cantidadElectores: 0),
  respuestaSumatoriaVotosPorMovimiento: const [],
  seGuardoEnProviderDignidades: false,
  posicionDignidadSeleccionada: -1,
  seSeleccionoPrefectos: false,
  seSeleccionoAlcaldes: false,
  seSeleccionoConcejalesUrbanos: false,
  seSeleccionoConcejalesRurales: false,
  seSeleccionoVocalesJuntasParroquiales: false,
  seSeleccionoProvincia: false,
  seSeleccionoCanton: false,
  seSeleccionoParroquia: false,
  provinciaSeleccionada: null,
  cantonSeleccionado: null,
  parroquiaSeleccionada: null,
);

class EstadisticaNotifier extends StateNotifier<EstadisticaModel> {
  EstadisticaNotifier() : super(estadisticaModelInicial);

  void resetState() {
    state = estadisticaModelInicial;
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

    if (posicionDignidadSeleccionada == 0) {
      state = state.copyWith(seSeleccionoPrefectos: true);
    }

    // Se selecciono alcaldes
    if (posicionDignidadSeleccionada == 1) {
      state = state.copyWith(seSeleccionoAlcaldes: true);
    }

    // Se selecciono concejales urbanos
    if (posicionDignidadSeleccionada == 2) {
      state = state.copyWith(seSeleccionoConcejalesUrbanos: true);
    }

    // Se selecciono concejales rurales
    if (posicionDignidadSeleccionada == 3) {
      state = state.copyWith(seSeleccionoConcejalesRurales: true);
    }

    // Se selecciono vocales juntas parroquiales
    if (posicionDignidadSeleccionada == 4) {
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

    resetState();

    state = state.copyWith(
        posicionDignidadSeleccionada: posicionDignidadSeleccionada,
        seSeleccionoPrefectos: seSeleccionoPrefectos,
        seSeleccionoAlcaldes: seSeleccionoAlcaldes,
        seSeleccionoConcejalesUrbanos: seSeleccionoConcejalesUrbanos,
        seSeleccionoConcejalesRurales: seSeleccionoConcejalesRurales,
        seSeleccionoVocalesJuntasParroquiales: seSeleccionoVocalesJuntasParroquiales,
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
        seSeleccionoProvincia: seSeleccionoProvincia,
        seSeleccionoCanton: true,
        provinciaSeleccionada: provinciaSeleccionada,
        cantonSeleccionado: cantonSeleccionado);
  }

  void changeParroquiaSeleccionadaState(Parroquia parroquiaSeleccionada) {
    state = state.copyWith(parroquiaSeleccionada: parroquiaSeleccionada, seSeleccionoParroquia: true);
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

// Obtiene el listado de dinidades configuradas
final dignidadesFutureProvider = FutureProvider((ref) async {
  String token = ref.read(authTokenProvider).basicToken;

  try {
    final response =
        await Dio().get('${Env.clientApiUrl}/dignidad/all', options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      List<DignidadDto> dignidades = (response.data as List).map((dignidad) {
        return DignidadDto.fromJson(dignidad);
      }).toList();

      return dignidades;
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas.');
  }
});

// Obtener el numero de electores por provincia
final numeroElectoresPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<NumeroElectoresDto, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String token = ref.read(authTokenProvider).basicToken;

  try {
    final response = await Dio().get('${Env.clientApiUrl}/numero-electores/provincia/${parametrosConsulta.idProvincia}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas.');
  }
});

// Obtener el numero de electores por provincia y canton
final numeroElectoresPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<NumeroElectoresDto, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String token = ref.read(authTokenProvider).basicToken;

  try {
    final response = await Dio().get(
        '${Env.clientApiUrl}/numero-electores/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas.');
  }
});

// Obtener el numero de electores por provincia y canton y parroquia
final numeroElectoresPorProvinciaYCantonYParroquiaFutureProvider =
    FutureProvider.autoDispose.family<NumeroElectoresDto, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String token = ref.read(authTokenProvider).basicToken;

  try {
    final response = await Dio().get(
        '${Env.clientApiUrl}/numero-electores/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}/parroquia/${parametrosConsulta.idParroquia}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas.');
  }
});

// Obtener el conteo de votos para prefectos por provincia
final numeroVotosParaPrefectoPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url = '${Env.clientApiUrl}/estadisticas/prefectos/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para alcaldes por provincia
final numeroVotosParaAlcaldesPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url = '${Env.clientApiUrl}/estadisticas/alcaldes/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para alcaldes por provincia y canton
final numeroVotosParaAlcaldesPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url =
      '${Env.clientApiUrl}/estadisticas/alcaldes/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales urbanos por provincia
final numeroVotosParaConcejalesUrbanosPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url = '${Env.clientApiUrl}/estadisticas/concejales/urbanos/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales urbanos por provincia y canton
final numeroVotosParaConcejalesUrbanosPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url =
      '${Env.clientApiUrl}/estadisticas/concejales/urbanos/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales rurales por provincia
final numeroVotosParaConcejalesRuralesPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url = '${Env.clientApiUrl}/estadisticas/concejales/rurales/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales rurales por provincia y canton
final numeroVotosParaConcejalesRuralesPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url =
      '${Env.clientApiUrl}/estadisticas/concejales/rurales/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para vocales de juntas parroquiales por provincia
final numeroVotosParaVocalesJuntasParroquialesPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url = '${Env.clientApiUrl}/estadisticas/vocales/juntas/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para vocales de juntas parroquiales por provincia y canton
final numeroVotosParaVocalesJuntasParroquialesPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url =
      '${Env.clientApiUrl}/estadisticas/vocales/juntas/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para vocales de juntas parroquiales por provincia y canton y parroquia
final numeroVotosParaVocalesJuntasParroquialesPorProvinciaYCantonYParroquiaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String url =
      '${Env.clientApiUrl}/estadisticas/vocales/juntas/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}/parroquia/${parametrosConsulta.idParroquia}';
  return await consumirServicioRest(ref, url);
});

Future<List<VotosMovimientoDto>> consumirServicioRest(
    AutoDisposeFutureProviderRef<List<VotosMovimientoDto>> ref, String url) async {
  String token = ref.read(authTokenProvider).basicToken;

  try {
    final response = await Dio().get(url, options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      List<VotosMovimientoDto> votosMovimientoDto = (response.data as List).map((votoMovimiento) {
        return VotosMovimientoDto.fromJson(votoMovimiento);
      }).toList();

      return votosMovimientoDto;
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas.');
  }
}
