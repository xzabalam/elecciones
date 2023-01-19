import 'package:elecciones_app_movil/data/model/ubicacion/index.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/dignidad_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/numero_electores_dto.dart';
import 'package:elecciones_app_movil/domain/providers/estadisticas/dto/voto_movimiento_dto.dart';
import 'package:equatable/equatable.dart';

class EstadisticaModel extends Equatable {
  List<DignidadDto>? dignidadesDto;

  List<Provincia>? provincias;
  bool? seGuardoListadoProvincia = false;

  Map<int, List<Canton>>? listadoCantonesPorProvincia = {};
  Map<int, List<Parroquia>>? listadoParroquiasPorCanton = {};

  bool? seGuardoEnProviderDignidades = false;

  int? posicionDignidadSeleccionada = -1;

  bool? seSeleccionoPrefectos = false;
  bool? seSeleccionoAlcaldes = false;
  bool? seSeleccionoConcejalesUrbanos = false;
  bool? seSeleccionoConcejalesRurales = false;
  bool? seSeleccionoVocalesJuntasParroquiales = false;
  bool? seSeleccionoTodosLosFiltros = false;

  Provincia? provinciaSeleccionada;
  bool? seSeleccionoProvincia = false;

  Canton? cantonSeleccionado;
  bool? seSeleccionoCanton = false;

  Parroquia? parroquiaSeleccionada;
  bool? seSeleccionoParroquia = false;

  int? cantidadTotalElectores;

  NumeroElectoresDto? numeroElectoresDto;
  List<VotosMovimientoDto>? respuestaSumatoriaVotosPorMovimiento;

  EstadisticaModel(
      {this.dignidadesDto,
      this.provincias,
      this.seGuardoListadoProvincia,
      this.listadoCantonesPorProvincia,
      this.listadoParroquiasPorCanton,
      this.seGuardoEnProviderDignidades,
      this.posicionDignidadSeleccionada,
      this.seSeleccionoPrefectos,
      this.seSeleccionoAlcaldes,
      this.seSeleccionoConcejalesUrbanos,
      this.seSeleccionoConcejalesRurales,
      this.seSeleccionoVocalesJuntasParroquiales,
      this.seSeleccionoTodosLosFiltros,
      this.provinciaSeleccionada,
      this.seSeleccionoProvincia,
      this.cantonSeleccionado,
      this.seSeleccionoCanton,
      this.parroquiaSeleccionada,
      this.seSeleccionoParroquia,
      this.cantidadTotalElectores,
      this.numeroElectoresDto,
      this.respuestaSumatoriaVotosPorMovimiento});

  EstadisticaModel copyWith(
          {List<DignidadDto>? dignidadesDto,
          List<Provincia>? provincias,
          bool? seGuardoListadoProvincia,
          Map<int, List<Canton>>? listadoCantonesPorProvincia,
          Map<int, List<Parroquia>>? listadoParroquiasPorCanton,
          bool? seGuardoEnProviderDignidades,
          int? posicionDignidadSeleccionada,
          bool? seSeleccionoPrefectos,
          bool? seSeleccionoAlcaldes,
          bool? seSeleccionoConcejalesUrbanos,
          bool? seSeleccionoConcejalesRurales,
          bool? seSeleccionoVocalesJuntasParroquiales,
          bool? seSeleccionoTodosLosFiltros,
          Provincia? provinciaSeleccionada,
          bool? seSeleccionoProvincia,
          Canton? cantonSeleccionado,
          bool? seSeleccionoCanton,
          Parroquia? parroquiaSeleccionada,
          bool? seSeleccionoParroquia,
          int? cantidadTotalElectores,
          NumeroElectoresDto? numeroElectoresDto,
          List<VotosMovimientoDto>? respuestaSumatoriaVotosPorMovimiento}) =>
      EstadisticaModel(
          dignidadesDto: dignidadesDto ?? this.dignidadesDto,
          provincias: provincias ?? this.provincias,
          seGuardoListadoProvincia: seGuardoListadoProvincia ?? this.seGuardoEnProviderDignidades,
          listadoCantonesPorProvincia: listadoCantonesPorProvincia ?? this.listadoCantonesPorProvincia,
          listadoParroquiasPorCanton: listadoParroquiasPorCanton ?? this.listadoParroquiasPorCanton,
          seGuardoEnProviderDignidades: seGuardoEnProviderDignidades ?? this.seGuardoEnProviderDignidades,
          posicionDignidadSeleccionada: posicionDignidadSeleccionada ?? this.posicionDignidadSeleccionada,
          seSeleccionoPrefectos: seSeleccionoPrefectos ?? this.seSeleccionoPrefectos,
          seSeleccionoAlcaldes: seSeleccionoAlcaldes ?? this.seSeleccionoAlcaldes,
          seSeleccionoConcejalesUrbanos: seSeleccionoConcejalesUrbanos ?? this.seSeleccionoConcejalesUrbanos,
          seSeleccionoConcejalesRurales: seSeleccionoConcejalesRurales ?? this.seSeleccionoConcejalesRurales,
          seSeleccionoVocalesJuntasParroquiales:
              seSeleccionoVocalesJuntasParroquiales ?? this.seSeleccionoVocalesJuntasParroquiales,
          seSeleccionoTodosLosFiltros: seSeleccionoTodosLosFiltros ?? this.seSeleccionoTodosLosFiltros,
          provinciaSeleccionada: provinciaSeleccionada ?? this.provinciaSeleccionada,
          seSeleccionoProvincia: seSeleccionoProvincia ?? this.seSeleccionoProvincia,
          cantonSeleccionado: cantonSeleccionado ?? this.cantonSeleccionado,
          seSeleccionoCanton: seSeleccionoCanton ?? this.seSeleccionoCanton,
          parroquiaSeleccionada: parroquiaSeleccionada ?? this.parroquiaSeleccionada,
          seSeleccionoParroquia: seSeleccionoParroquia ?? this.seSeleccionoParroquia,
          cantidadTotalElectores: cantidadTotalElectores ?? this.cantidadTotalElectores,
          numeroElectoresDto: numeroElectoresDto ?? this.numeroElectoresDto,
          respuestaSumatoriaVotosPorMovimiento:
              respuestaSumatoriaVotosPorMovimiento ?? this.respuestaSumatoriaVotosPorMovimiento);

  @override
  List<Object?> get props => [
        dignidadesDto,
        provincias,
        seGuardoListadoProvincia,
        listadoCantonesPorProvincia,
        listadoParroquiasPorCanton,
        seGuardoEnProviderDignidades,
        posicionDignidadSeleccionada,
        seSeleccionoPrefectos,
        seSeleccionoAlcaldes,
        seSeleccionoConcejalesUrbanos,
        seSeleccionoConcejalesRurales,
        seSeleccionoVocalesJuntasParroquiales,
        seSeleccionoTodosLosFiltros,
        provinciaSeleccionada,
        seSeleccionoProvincia,
        cantonSeleccionado,
        seSeleccionoCanton,
        parroquiaSeleccionada,
        seSeleccionoParroquia,
        cantidadTotalElectores,
        numeroElectoresDto,
        respuestaSumatoriaVotosPorMovimiento
      ];
}
