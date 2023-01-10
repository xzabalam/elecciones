import 'package:elecciones_app_movil/data/model/candidato/voto.dart';

class VotoModel {
  List<Voto>? votos;

  VotoModel({this.votos});

  VotoModel copyWith({List<Voto>? votos, int? dignidadSeleccionada}) =>
      VotoModel(votos: votos ?? this.votos);
}
