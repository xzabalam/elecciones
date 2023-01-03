import 'package:elecciones_app_movil/data/model/candidato/dignidad.dart';
import 'package:elecciones_app_movil/data/model/candidato/tipo_ubicacion.dart';

class DignidadUbicacion {
  DignidadUbicacion({
    required this.id,
    required this.dignidad,
    required this.tipoUbicacion,
    required this.tablaUbicacion,
    required this.idTablaUbicacion,
    required this.cargo,
    required this.siglaCircunscripcion,
  });

  int id;
  Dignidad dignidad;
  TipoUbicacion tipoUbicacion;
  String tablaUbicacion;
  int idTablaUbicacion;
  String cargo;
  String siglaCircunscripcion;
}
