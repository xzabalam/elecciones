import 'package:elecciones_app_movil/data/model/candidato/proceso.dart';
import 'package:elecciones_app_movil/data/model/candidato/tipo_grupo.dart';

class Dignidad {
  Dignidad({
    required this.id,
    required this.nombre,
    required this.proceso,
    required this.tipoGrupo,
    required this.numero,
  });

  int id;
  String nombre;
  Proceso proceso;
  TipoGrupo tipoGrupo;
  int numero;
}
