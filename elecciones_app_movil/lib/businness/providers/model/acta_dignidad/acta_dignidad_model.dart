import 'package:elecciones_app_movil/data/model/candidato/dignidad_ubicacion.dart';

class ActaDignidadModel {
  DignidadUbicacion? dignidadUbicacionSeleccionada;
  int? posicionDignidadSeleccionada;

  ActaDignidadModel(
      {this.dignidadUbicacionSeleccionada, this.posicionDignidadSeleccionada});

  ActaDignidadModel copyWith({
    DignidadUbicacion? dignidadUbicacionSeleccionada,
    int? posicionDignidadSeleccionada}) =>
      ActaDignidadModel(
          dignidadUbicacionSeleccionada:
          dignidadUbicacionSeleccionada ?? this.dignidadUbicacionSeleccionada,
          posicionDignidadSeleccionada:
          posicionDignidadSeleccionada ?? this.posicionDignidadSeleccionada);
}
