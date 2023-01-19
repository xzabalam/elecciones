import 'package:elecciones_app_movil/data/model/candidato/dignidad_ubicacion.dart';

class ActaDignidadModel {
  List<DignidadUbicacion>? dignidadUbicaciones;
  DignidadUbicacion? dignidadUbicacionSeleccionada;
  int? posicionDignidadSeleccionada;

  ActaDignidadModel({this.dignidadUbicaciones, this.dignidadUbicacionSeleccionada, this.posicionDignidadSeleccionada});

  ActaDignidadModel copyWith(
          {List<DignidadUbicacion>? dignidadUbicaciones,
          DignidadUbicacion? dignidadUbicacionSeleccionada,
          int? posicionDignidadSeleccionada}) =>
      ActaDignidadModel(
          dignidadUbicaciones: dignidadUbicaciones ?? this.dignidadUbicaciones,
          dignidadUbicacionSeleccionada: dignidadUbicacionSeleccionada ?? this.dignidadUbicacionSeleccionada,
          posicionDignidadSeleccionada: posicionDignidadSeleccionada ?? this.posicionDignidadSeleccionada);
}
