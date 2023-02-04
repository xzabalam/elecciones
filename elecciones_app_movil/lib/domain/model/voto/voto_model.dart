import 'package:elecciones_app_movil/data/model/candidato/voto.dart';
import 'package:elecciones_app_movil/domain/model/voto/voto_seleccionado_model.dart';
import 'package:flutter/material.dart';

class VotoModel {
  // Cuando se selecciona la junta, se realiza la busqueda de todas la dignidades, movimientos, candidatos y votos,
  // registrados en esa junta y eso se muestra en pantalla.
  List<Voto>? votos;

  // Cuando se selecciona una dignidad, se filtra los votos totales para que se muestre en el listado de
  // candidatos los seleccionados.
  List<Voto>? votosFiltradosPorDignidad;

  // Aqui se va a almacenar temporalmente por cada una de las digidades seleccionada, el idDignidad y el objeto con todos los datos
  // de votos para cada uno de los movimientos que tengan esa dignidad.
  Map<int, VotoModificadoModel>? votosModificados;

  // Se debe crear un listado
  List<TextEditingController>? textEditingController;

  VotoModel({this.votos, this.votosFiltradosPorDignidad, this.votosModificados, this.textEditingController});

  VotoModel copyWith(
          {List<Voto>? votos,
          List<Voto>? votosFiltradosPorDignidad,
          Map<int, VotoModificadoModel>? votosModificados,
          List<TextEditingController>? textEditingController}) =>
      VotoModel(
          votos: votos ?? this.votos,
          votosFiltradosPorDignidad: votosFiltradosPorDignidad ?? this.votosFiltradosPorDignidad,
          votosModificados: votosModificados ?? this.votosModificados,
          textEditingController: textEditingController ?? this.textEditingController);
}
