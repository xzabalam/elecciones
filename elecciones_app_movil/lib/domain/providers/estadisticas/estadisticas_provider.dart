// Obtener el listado de dignidades
import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/circunscripcion.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/dignidad_dto.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/numero_electores_dto.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/parametros_circusncripcion.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/parametros_consulta_dto.dart';
import 'package:elecciones_app_movil/domain/model/estadisticas/voto_movimiento_dto.dart';
import 'package:elecciones_app_movil/domain/notifiers/auth/token_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Obtiene el listado de dinidades configuradas
final dignidadesFutureProvider = FutureProvider((ref) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  int idContrato = ref.read(authTokenProvider).usuario!.contrato!.id;
  try {
    final response = await Dio()
        .get('$urlApiCliente/dignidad/contrato/$idContrato', options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      List<DignidadDto> dignidades = (response.data as List).map((dignidad) {
        return DignidadDto.fromJson(dignidad);
      }).toList();
      return dignidades;
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  }
});

// Obtener el numero de electores por provincia
final numeroElectoresPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<NumeroElectoresDto, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio().get('$urlApiCliente/numero-electores/provincia/${parametrosConsulta.idProvincia}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  }
});

// Obtener el numero de electores por provincia y canton
final numeroElectoresPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<NumeroElectoresDto, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio().get(
        '$urlApiCliente/numero-electores/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  }
});

// Obtener el numero de electores por provincia y canton y parroquia
final numeroElectoresPorProvinciaYCantonYParroquiaFutureProvider =
    FutureProvider.autoDispose.family<NumeroElectoresDto, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio().get(
        '$urlApiCliente/numero-electores/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}/parroquia/${parametrosConsulta.idParroquia}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      return NumeroElectoresDto.fromJson(response.data);
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  }
});

// Obtener el conteo de votos para prefectos por provincia
final numeroVotosParaPrefectoPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url = '$urlApiCliente/estadisticas/prefectos/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para alcaldes por provincia
final numeroVotosParaAlcaldesPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url = '$urlApiCliente/estadisticas/alcaldes/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para alcaldes por provincia y canton
final numeroVotosParaAlcaldesPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url =
      '$urlApiCliente/estadisticas/alcaldes/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales urbanos por provincia
final numeroVotosParaConcejalesUrbanosPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url = '$urlApiCliente/estadisticas/concejales/urbanos/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales urbanos por provincia y canton
final numeroVotosParaConcejalesUrbanosPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url =
      '$urlApiCliente/estadisticas/concejales/urbanos/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales urbanos por provincia, canton, dignidad, circunscripcion
final numeroVotosParaConcejalesUrbanosPorProvinciaCantonDignidadCircunscripcionFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url =
      '$urlApiCliente/estadisticas/concejales/urbanos/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}/dignidad/${parametrosConsulta.idDignidad}/circunscripcion/${parametrosConsulta.idCircunscripcion}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales urbanos circunscripcion por provincia y canton
final numeroVotosParaConcejalesUrbanosCircunscripcionPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url =
      '$urlApiCliente/estadisticas/concejales/urbanos/circunscripcion/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales rurales por provincia
final numeroVotosParaConcejalesRuralesPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url = '$urlApiCliente/estadisticas/concejales/rurales/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para concejales rurales por provincia y canton
final numeroVotosParaConcejalesRuralesPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url =
      '$urlApiCliente/estadisticas/concejales/rurales/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para vocales de juntas parroquiales por provincia
final numeroVotosParaVocalesJuntasParroquialesPorProvinciaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url = '$urlApiCliente/estadisticas/vocales/juntas/provincia/${parametrosConsulta.idProvincia}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para vocales de juntas parroquiales por provincia y canton
final numeroVotosParaVocalesJuntasParroquialesPorProvinciaYCantonFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url =
      '$urlApiCliente/estadisticas/vocales/juntas/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}';
  return await consumirServicioRest(ref, url);
});

// Obtener el conteo de votos para vocales de juntas parroquiales por provincia y canton y parroquia
final numeroVotosParaVocalesJuntasParroquialesPorProvinciaYCantonYParroquiaFutureProvider =
    FutureProvider.autoDispose.family<List<VotosMovimientoDto>, ParametrosConsultaDto>((ref, parametrosConsulta) async {
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url =
      '$urlApiCliente/estadisticas/vocales/juntas/provincia/${parametrosConsulta.idProvincia}/canton/${parametrosConsulta.idCanton}/parroquia/${parametrosConsulta.idParroquia}';
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
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  }
}

//Obtener circunscripciones por contrato y por dignidad seleccionada
final circunscripcionesContratoDignidadProvider =
    FutureProvider.autoDispose.family<List<Circunscripcion>, ParametrosBusquedaCircunscripcion>((ref, parametro) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;
  String url = '$urlApiCliente/circunscripcion/contrato/${parametro.idContrato}/dignidad/${parametro.idDignidad}';

  try {
    final response = await Dio().get(url, options: Options(headers: {'Authorization': token}));
    if (response.statusCode == 200) {
      List<Circunscripcion> circunscripciones = (response.data as List).map((circunscripcion) {
        return Circunscripcion.fromJson(circunscripcion);
      }).toList();

      return circunscripciones;
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('Error al obtener las dignidades configuradas.');
    }
  }
});
