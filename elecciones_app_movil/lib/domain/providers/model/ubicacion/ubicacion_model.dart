import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';

class UbicacionModel {
  Pais? paisSeleccionado;
  Provincia? provinciaSeleccionada;
  Canton? cantonSeleccionado;
  Parroquia? parroquiaSeleccionada;
  Zona? zonaSeleccionada;
  Recinto? recintoSeleccionado;
  Junta? juntaSeleccionada;

  UbicacionModel(
      {this.paisSeleccionado,
      this.provinciaSeleccionada,
      this.cantonSeleccionado,
      this.parroquiaSeleccionada,
      this.zonaSeleccionada,
      this.recintoSeleccionado,
      this.juntaSeleccionada});

  UbicacionModel copyWith(
          {Pais? paisSeleccionado,
          Provincia? provinciaSeleccionada,
          Canton? cantonSeleccionado,
          Parroquia? parroquiaSeleccionada,
          Zona? zonaSeleccionada,
          Recinto? recintoSeleccionado,
          Junta? juntaSeleccionada}) =>
      UbicacionModel(
        paisSeleccionado: paisSeleccionado ?? this.paisSeleccionado,
        provinciaSeleccionada:
            provinciaSeleccionada ?? this.provinciaSeleccionada,
        cantonSeleccionado: cantonSeleccionado ?? this.cantonSeleccionado,
        parroquiaSeleccionada:
            parroquiaSeleccionada ?? this.parroquiaSeleccionada,
        zonaSeleccionada: zonaSeleccionada ?? this.zonaSeleccionada,
        recintoSeleccionado: recintoSeleccionado ?? this.recintoSeleccionado,
        juntaSeleccionada: juntaSeleccionada ?? this.juntaSeleccionada,
      );
}
