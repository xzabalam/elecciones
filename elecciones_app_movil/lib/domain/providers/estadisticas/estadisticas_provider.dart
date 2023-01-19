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

class EstadisticaNotifier extends StateNotifier<EstadisticaModel> {
  EstadisticaNotifier()
      : super(EstadisticaModel(
          numeroElectoresDto: NumeroElectoresDto(idUbicacion: -1, nombreUbicacion: "", cantidadElectores: 0),
          respuestaSumatoriaVotosPorMovimiento: const [],
          seGuardoListadoProvincia: false,
          listadoCantonesPorProvincia: const {},
          listadoParroquiasPorCanton: const {},
          seGuardoEnProviderDignidades: false,
          posicionDignidadSeleccionada: -1,
          seSeleccionoPrefectos: false,
          seSeleccionoAlcaldes: false,
          seSeleccionoConcejalesUrbanos: false,
          seSeleccionoConcejalesRurales: false,
          seSeleccionoVocalesJuntasParroquiales: false,
          seSeleccionoTodosLosFiltros: false,
          seSeleccionoProvincia: false,
          seSeleccionoCanton: false,
          seSeleccionoParroquia: false,
          provinciaSeleccionada: null,
          cantonSeleccionado: null,
          parroquiaSeleccionada: null,
        ));

  void resetState() {
    state = EstadisticaModel(
      numeroElectoresDto: NumeroElectoresDto(idUbicacion: -1, nombreUbicacion: "", cantidadElectores: 0),
      respuestaSumatoriaVotosPorMovimiento: const [],
      seGuardoListadoProvincia: false,
      listadoCantonesPorProvincia: const {},
      listadoParroquiasPorCanton: const {},
      seGuardoEnProviderDignidades: false,
      posicionDignidadSeleccionada: -1,
      seSeleccionoPrefectos: false,
      seSeleccionoAlcaldes: false,
      seSeleccionoConcejalesUrbanos: false,
      seSeleccionoConcejalesRurales: false,
      seSeleccionoVocalesJuntasParroquiales: false,
      seSeleccionoTodosLosFiltros: false,
      seSeleccionoProvincia: false,
      seSeleccionoCanton: false,
      seSeleccionoParroquia: false,
      provinciaSeleccionada: null,
      cantonSeleccionado: null,
      parroquiaSeleccionada: null,
    );
  }

  void changeDignidadesDtoState(List<DignidadDto> dignidadesDto) {
    state = state.copyWith(dignidadesDto: dignidadesDto);
  }

  void changeListadoProvinciaState(List<Provincia> provincia) {
    state = state.copyWith(provincias: provincia, seGuardoListadoProvincia: true);
  }

  void addListadoCantonesPorProvincia(int idProvincia, List<Canton> listadoCantones) {
    state = state.copyWith(listadoCantonesPorProvincia: {
      ...state.listadoCantonesPorProvincia!,
      ...{idProvincia: listadoCantones}
    });
  }

  void addListadoParroquiasPorCanton(int idCanton, List<Parroquia> listadoParroquia) {
    state = state.copyWith(listadoParroquiasPorCanton: {
      ...state.listadoParroquiasPorCanton!,
      ...{idCanton: listadoParroquia}
    });
  }

  void changeSeGuardoEnProviderDignidades(bool seGuardoEnProviderDignidades) {
    state = state.copyWith(seGuardoEnProviderDignidades: seGuardoEnProviderDignidades);
  }

  void changePosicionDignidadSeleccionadaState(int posicionDignidadSeleccionada) {
    resetState();
    state = state.copyWith(posicionDignidadSeleccionada: posicionDignidadSeleccionada);
  }

  void changeSeSeleccionoPrefectosState(bool seSeleccionoPrefectos) {
    state = state.copyWith(
        seSeleccionoPrefectos: seSeleccionoPrefectos,
        seSeleccionoAlcaldes: false,
        seSeleccionoConcejalesRurales: false,
        seSeleccionoConcejalesUrbanos: false,
        seSeleccionoVocalesJuntasParroquiales: false);
  }

  void changeSeSeleccionoAlcaldesState(bool seSeleccionoAlcaldes) {
    state = state.copyWith(
        seSeleccionoPrefectos: false,
        seSeleccionoAlcaldes: seSeleccionoAlcaldes,
        seSeleccionoConcejalesRurales: false,
        seSeleccionoConcejalesUrbanos: false,
        seSeleccionoVocalesJuntasParroquiales: false);
  }

  void changeSeSeleccionoConcejalesUrbanosState(bool seSeleccionoConcejalesUrbanos) {
    state = state.copyWith(
        seSeleccionoPrefectos: false,
        seSeleccionoAlcaldes: false,
        seSeleccionoConcejalesRurales: seSeleccionoConcejalesUrbanos,
        seSeleccionoConcejalesUrbanos: false,
        seSeleccionoVocalesJuntasParroquiales: false);
  }

  void changeSeSeleccionoConcejalesRuralesState(bool seSeleccionoConcejalesRurales) {
    state = state.copyWith(
        seSeleccionoPrefectos: false,
        seSeleccionoAlcaldes: false,
        seSeleccionoConcejalesRurales: false,
        seSeleccionoConcejalesUrbanos: seSeleccionoConcejalesRurales,
        seSeleccionoVocalesJuntasParroquiales: false);
  }

  void changeSeSeleccionoVocalesJuntasParroquialesState(bool seSeleccionoVocalesJuntasParroquiales) {
    state = state.copyWith(
        seSeleccionoPrefectos: false,
        seSeleccionoAlcaldes: false,
        seSeleccionoConcejalesRurales: false,
        seSeleccionoConcejalesUrbanos: false,
        seSeleccionoVocalesJuntasParroquiales: seSeleccionoVocalesJuntasParroquiales);
  }

  void changeSeSeleccionoTodosLosFiltrosState(bool seSeleccionoTodosLosFiltros) {
    state = state.copyWith(seSeleccionoTodosLosFiltros: seSeleccionoTodosLosFiltros);
  }

  void changeProvinciaSeleccionadaState(Provincia provinciaSeleccionada) {
    state = state.copyWith(
        provinciaSeleccionada: provinciaSeleccionada, cantonSeleccionado: null, parroquiaSeleccionada: null);
  }

  void changeCantonSeleccionadoState(Canton cantonSeleccionado) {
    state = state.copyWith(cantonSeleccionado: cantonSeleccionado, parroquiaSeleccionada: null);
  }

  void changeParroquiaSeleccionadaState(Parroquia parroquiaSeleccionada) {
    state = state.copyWith(parroquiaSeleccionada: parroquiaSeleccionada);
  }

  void changeCantidadTotalElectoresState(int cantidadTotalElectores) {
    state = state.copyWith(cantidadTotalElectores: cantidadTotalElectores);
  }

  void changeSeSeleccionoProvincia() {
    state = state.copyWith(
        seSeleccionoProvincia: true,
        seSeleccionoCanton: false,
        seSeleccionoParroquia: false,
        listadoCantonesPorProvincia: {},
        listadoParroquiasPorCanton: {});
  }

  void changeSeSeleccionoCanton() {
    state = state.copyWith(seSeleccionoCanton: true, seSeleccionoParroquia: false, listadoParroquiasPorCanton: {});
  }

  void changeSeSeleccionoParroquia() {
    state = state.copyWith(seSeleccionoParroquia: true);
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
      throw Exception('Error al obtener las dignidades configuradas. ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas. ${e.toString()}');
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
      print(response.data);
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas. ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas. ${e.toString()}');
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
      print(response);
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas. ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas. ${e.toString()}');
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
      throw Exception('Error al obtener las dignidades configuradas. ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas. ${e.toString()}');
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
      throw Exception('Error al obtener las dignidades configuradas. ${response.data['error']}');
    }
  } catch (e) {
    throw Exception('Error al obtener las dignidades configuradas. ${e.toString()}');
  }
}
