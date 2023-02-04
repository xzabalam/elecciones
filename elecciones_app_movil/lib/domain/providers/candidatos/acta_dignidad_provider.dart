import 'package:dio/dio.dart';
import 'package:elecciones_app_movil/data/model/candidato/acta_dignidad.dart';
import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/notifiers/auth/token_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actaDignidadFutureProvider =
    FutureProvider.autoDispose.family<List<ActaDignidad>, Junta>((ref, juntaSeleccionada) async {
  String token = ref.read(authTokenProvider).basicToken;
  String urlApiCliente = ref.read(authTokenProvider).urlApiCliente!;

  try {
    final response = await Dio().get('$urlApiCliente/acta-dignidad/junta/${juntaSeleccionada.id}',
        options: Options(headers: {'Authorization': token}));

    if (response.statusCode == 200) {
      List<ActaDignidad> actasDignidad = (response.data as List).map((actaDignidad) {
        return ActaDignidad.fromMap(actaDignidad);
      }).toList();

      return actasDignidad;
    } else {
      throw Exception(
          'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre}');
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
          'Error al obtener las dignidades de la junta ${juntaSeleccionada.numero} - ${juntaSeleccionada.sexo!.nombre}');
    }
  }
});
