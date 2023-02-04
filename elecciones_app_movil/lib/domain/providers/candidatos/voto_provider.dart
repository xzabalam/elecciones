import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/model/voto/voto_seleccionado_model.dart';
import 'package:elecciones_app_movil/domain/notifiers/auth/token_notifier.dart';
import 'package:elecciones_app_movil/domain/notifiers/candidatos/voto_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ------------------------------------------------------------------
/// Permite obtener los votos por la junta
/// ------------------------------------------------------------------
final votoFutureProvider = FutureProvider.autoDispose.family<List<Voto>, Junta>((ref, juntaSeleccionada) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio()
        .get('$urlApiCliente/voto/junta/${juntaSeleccionada.id}', options: Options(headers: {'Authorization': token}));

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
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception(
          'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre} ${e.toString()}');
    }
  }
});

/// ------------------------------------------------------------------
/// Permite actualizar en base de datos la cantidad de votos por acta
/// ------------------------------------------------------------------
final cambiarCantidadVotoFutureProvider =
    FutureProvider.autoDispose.family<bool, List<VotoModificadoModel>>((ref, votosSeleccionadoModel) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio()
        .post('$urlApiCliente/voto', data: votosSeleccionadoModel, options: Options(headers: {'Authorization': token}));

    return (response.statusCode == 200);
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception("Usuario no autorizado.");
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.other) {
      throw Exception("Error de conexión, intente de nuevo más tarde.");
    } else {
      throw Exception('No fue posible guardar los votos.');
    }
  }
});
