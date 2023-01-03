import 'package:elecciones_app_movil/data/model/candidato/dignidad_ubicacion.dart';

class ActaDignidad {
  ActaDignidad({
    required this.id,
    required this.dignidadUbicacion,
    required this.identificacion,
    required this.actaArchivo,
    required this.actaNombre,
    required this.actaDescripcion,
  });

  int id;
  DignidadUbicacion dignidadUbicacion;
  String identificacion;
  dynamic actaArchivo;
  String actaNombre;
  String actaDescripcion;
}
