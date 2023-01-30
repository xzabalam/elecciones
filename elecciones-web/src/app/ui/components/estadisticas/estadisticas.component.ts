import { colors } from './../../../domain/util/color_util';
import { VotosMovimientoDto } from './../../../domain/model/dto/estaditicas/votos_movimiento_dto';
import { ListadoVotosMovimientoService } from './../../../domain/services/votos_movimiento/listado-votos-movimiento.service';
import { ParroquiaDto } from './../../../domain/model/dto/ubicacion/parroquia_dto';
import { CantonDto } from './../../../domain/model/dto/ubicacion/canton_dto';
import { ParroquiaService } from './../../../domain/services/ubicaciones/parroquia/parroquia.service';
import { CantonService } from './../../../domain/services/ubicaciones/canton/canton.service';
import { ProvinciaDto } from './../../../domain/model/dto/ubicacion/provincia_dto';
import { ProvinciaService } from './../../../domain/services/ubicaciones/provincia/provincia.service';
import { DignidadService } from './../../../domain/services/dignidades/dignidad.service';
import { UsuarioDto } from './../../../domain/model/dto/usuario/usuario_dto';
import { UsersService } from './../../../domain/services/users/users.service';
import { Component } from '@angular/core';
import { DignidadesDto } from 'src/app/domain/model/dto/dignidad/dignidad_dto';
import { MatSelectionListChange } from '@angular/material/list';
import Chart from 'chart.js/auto';

@Component({
  selector: 'app-estadisticas',
  templateUrl: './estadisticas.component.html',
  styleUrls: ['./estadisticas.component.css'],
})
export class EstadisticasComponent {
  // Datos del usuario para la barra de herramientas.
  datosUsuarioDto: UsuarioDto;

  dignidadesDto: Array<DignidadesDto> = [];
  dignidadSeleccionada: DignidadesDto | undefined;
  posicionDignidadSeleccionada: number = -1;

  provincias: Array<ProvinciaDto> = [];
  provinciaSeleccionada: ProvinciaDto | undefined;
  cantones: Array<CantonDto> = [];
  cantonSeleccionado: CantonDto | undefined;
  parroquias: Array<ParroquiaDto> = [];
  parroquiaSeleccionada: ParroquiaDto | undefined;
  cantidadTotalElectores: number = 0;
  respuestaSumatoriaVotosPorMovimiento: Array<VotosMovimientoDto> = [];
  chart: any;

  seSeleccionoDignidad: boolean = false;
  seSeleccionoPrefectos: boolean = false;
  seSeleccionoAlcaldes: boolean = false;
  seSeleccionoConcejalesUrbanos: boolean = false;
  seSeleccionoConcejalesRurales: boolean = false;
  seSeleccionoVocalesJuntasParroquiales: boolean = false;
  seSeleccionoTodosLosFiltros: boolean = false;
  seSeleccionoProvincia: boolean = false;
  seSeleccionoCanton: boolean = false;
  seSeleccionoParroquia: boolean = false;

  constructor(
    private userService: UsersService,
    private dignidadService: DignidadService,
    private provinciaService: ProvinciaService,
    private cantonService: CantonService,
    private parroquiaService: ParroquiaService,
    private listadoVotosMovimientoService: ListadoVotosMovimientoService
  ) {
    this.datosUsuarioDto = userService.getDatosUsuario();

    this.dignidadService.obtenerDignidades().subscribe({
      next: (data) => {
        this.dignidadesDto = data;
        this.dignidadesDto = this.dignidadesDto.filter(
          (dignidad) => dignidad.id != 1
        );
      },
      error: (error) => {
        console.log(error);
      },
    });
  }

  logout() {
    this.userService.logout();
  }

  onDignidadChange(change: MatSelectionListChange) {
    this.seSeleccionoDignidad = true;
    this.seSeleccionoTodosLosFiltros = false;
    this.posicionDignidadSeleccionada = change.options[0].value.id;
    this.dignidadSeleccionada = change.options[0].value;
    this.cantidadTotalElectores = 0;

    if (this.posicionDignidadSeleccionada == 2) {
      // Se selecciono PREFECTO y VICIPREFECTO
      this.prefectoSeleccionado();
    }

    if (this.posicionDignidadSeleccionada == 3) {
      // Se selecciono ALCALDES MUNICIPALES
      this.alcaldeSeleccionado();
    }

    if (this.posicionDignidadSeleccionada == 4) {
      // Se selecciono CONCEJALES URBANOS
      this.concejalUrbanoSeleccionado();
    }

    if (this.posicionDignidadSeleccionada == 5) {
      // Se selecciono CONCEJALES RURALES
      this.concejalRuralSeleccionado();
    }

    if (this.posicionDignidadSeleccionada == 6) {
      // Se selecciono VOCALES DE JUNTAS PARROQUIALES
      this.vocalJuntasSeleccionado();
    }

    this.provinciaSeleccionada = undefined;
    this.cantonSeleccionado = undefined;
    this.parroquiaSeleccionada = undefined;

    this.seSeleccionoProvincia = false;
    this.seSeleccionoCanton = false;
    this.seSeleccionoParroquia = false;

    if (this.chart) {
      this.chart.destroy();
    }

    // se debe filtrar solo por provincia
    this.obtenerProvincia(1);
  }

  onChangeSelectProvincia() {
    this.seSeleccionoProvincia = true;
    this.seSeleccionoCanton = false;
    this.seSeleccionoParroquia = false;
    this.cantidadTotalElectores = 0;
    this.seSeleccionoTodosLosFiltros = false;

    if (this.chart) {
      this.chart.destroy();
    }

    if (this.seSeleccionoPrefectos) {
      this.seSeleccionoTodosLosFiltros = true;
      this.obtenerSumatoriaVotosPorPrefectoYProvincia(
        this.provinciaSeleccionada!.id
      );
    } else {
      this.obtenerCantones(this.provinciaSeleccionada!.id);
    }
  }

  onChangeSelectCanton() {
    this.seSeleccionoCanton = true;
    this.seSeleccionoParroquia = false;
    this.cantidadTotalElectores = 0;
    this.seSeleccionoTodosLosFiltros = false;
    if (this.chart) {
      this.chart.destroy();
    }

    if (
      this.seSeleccionoAlcaldes ||
      this.seSeleccionoConcejalesUrbanos ||
      this.seSeleccionoConcejalesRurales
    ) {
      this.seSeleccionoTodosLosFiltros = true;
      this.obtenerSumatoriaVotosPorProvinciaYCanton(
        this.provinciaSeleccionada!.id,
        this.cantonSeleccionado!.id
      );
    } else {
      this.obtenerParroquias(this.cantonSeleccionado!.id);
    }
  }

  onChangeSelectParroquia() {
    this.seSeleccionoParroquia = true;
    this.cantidadTotalElectores = 0;
    this.seSeleccionoTodosLosFiltros = true;
    if (this.chart) {
      this.chart.destroy();
    }
    this.obtenerSumatoriaVotosPorVocalesJuntasParroquiales(
      this.provinciaSeleccionada!.id,
      this.cantonSeleccionado!.id,
      this.parroquiaSeleccionada!.id
    );
  }

  onClickActualizarGrafico() {
    this.cantidadTotalElectores = 0;
    if (this.chart) {
      this.chart.destroy();
    }
    if (this.seSeleccionoPrefectos) {
      this.obtenerSumatoriaVotosPorPrefectoYProvincia(
        this.provinciaSeleccionada!.id
      );
    }
    if (
      this.seSeleccionoAlcaldes ||
      this.seSeleccionoConcejalesUrbanos ||
      this.seSeleccionoConcejalesRurales
    ) {
      this.obtenerSumatoriaVotosPorProvinciaYCanton(
        this.provinciaSeleccionada!.id,
        this.cantonSeleccionado!.id
      );
    }
    if (this.seSeleccionoVocalesJuntasParroquiales) {
      this.obtenerSumatoriaVotosPorVocalesJuntasParroquiales(
        this.provinciaSeleccionada!.id,
        this.cantonSeleccionado!.id,
        this.parroquiaSeleccionada!.id
      );
    }
  }

  private obtenerSumatoriaVotosPorPrefectoYProvincia(idProvincia: number) {
    this.respuestaSumatoriaVotosPorMovimiento = [];
    this.listadoVotosMovimientoService
      .numeroVotosParaPrefectoPorProvincia(idProvincia)
      .subscribe({
        next: (data) => {
          this.respuestaSumatoriaVotosPorMovimiento = data;
          this.createChart(this.respuestaSumatoriaVotosPorMovimiento);
        },
        error: (error) => {
          console.log(error);
        },
      });
  }

  private obtenerSumatoriaVotosPorProvinciaYCanton(
    idProvincia: number,
    idCanton: number
  ) {
    this.respuestaSumatoriaVotosPorMovimiento = [];

    var observable;

    if (this.seSeleccionoAlcaldes) {
      observable =
        this.listadoVotosMovimientoService.numeroVotosParaAlcaldesPorProvinciaYCanton(
          idProvincia,
          idCanton
        );
    }

    if (this.seSeleccionoConcejalesUrbanos) {
      observable =
        this.listadoVotosMovimientoService.numeroVotosParaConcejalesUrbanosPorProvinciaYCanton(
          idProvincia,
          idCanton
        );
    }

    if (this.seSeleccionoConcejalesRurales) {
      observable =
        this.listadoVotosMovimientoService.numeroVotosParaConcejalesRuralesPorProvinciaYCanton(
          idProvincia,
          idCanton
        );
    }

    if (observable != undefined) {
      observable.subscribe({
        next: (data) => {
          this.respuestaSumatoriaVotosPorMovimiento = data;
          this.createChart(this.respuestaSumatoriaVotosPorMovimiento);
        },
        error: (error) => {
          console.log(error);
        },
      });
    }
  }

  private obtenerSumatoriaVotosPorVocalesJuntasParroquiales(
    idProvincia: number,
    idCanton: number,
    idParroquia: number
  ) {
    this.respuestaSumatoriaVotosPorMovimiento = [];
    this.listadoVotosMovimientoService
      .numeroVotosParaVocalesJuntasParroquialesPorProvinciaYCantonYParroquia(
        idProvincia,
        idCanton,
        idParroquia
      )
      .subscribe({
        next: (data) => {
          this.respuestaSumatoriaVotosPorMovimiento = data;
          this.createChart(this.respuestaSumatoriaVotosPorMovimiento);
        },
        error: (error) => {
          console.log(error);
        },
      });
  }

  private createChart(votosPorMovimiento: Array<VotosMovimientoDto>) {
    var labels: string[] = votosPorMovimiento.map(
      (votos) =>
        'Lista ' + votos.numeroMovimiento + ' ( ' + votos.nombreCandidato + ' )'
    );
    var datos: number[] = votosPorMovimiento.map((votos) => votos.sumatoria);

    var colores: string[] = votosPorMovimiento.map(
      (voto) => voto.colorMovimiento
    );

    this.cantidadTotalElectores = datos.reduce(
      (result, votos) => result + votos,
      0
    );

    const innerBarText = {
      id: 'innerBarText',
      afterDataSetsDraw(chart: any, args: any, pluginOptions: any) {
        const {
          ctx,
          data,
          charArea: { left },
          scales: { x, y },
        } = chart;
        ctx.save();
        data.datasets[0].data.forEach((dataPoint: any, index: any) => {
          ctx.font = 'bolder 12px sans-serif';
          (ctx.fillStyle = 'gray'),
            ctx.fillText(
              `${data.labels[0]}: ${dataPoint}`,
              left + 10,
              y * index
            );
        });
      },
    };

    this.chart = new Chart('MyChart', {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [
          {
            data: datos,
            backgroundColor: colores,
          },
        ],
      },
      options: {
        indexAxis: 'y',
        maintainAspectRatio: true,
        scales: {
          x: {
            display: true,
            beginAtZero: true,

            ticks: {
              display: false,
            },
          },
          y: {
            display: true,
            beginAtZero: true,
          },
        },

        plugins: {
          legend: {
            labels: {
              font: {
                size: 16,
                weight: 'bold',
                family: "'Roboto', 'Helvetica', 'Arial', sans-serif",
              },
            },
            display: false,
            position: 'right',
          },
          title: {
            display: false,
            text: 'Estadisticas 2023',
          },
        },
      },
    });
    this.chart.update();
  }

  private obtenerProvincia(idPais: number) {
    this.cantones = [];
    this.parroquias = [];

    if (this.provincias.length == 0) {
      this.provinciaService.obtenerPoridPais(idPais).subscribe({
        next: (data) => {
          this.provincias = data;
        },
        error: (error) => {
          console.log(error);
        },
      });
    }
  }

  private obtenerCantones(idProvincia: number) {
    this.parroquias = [];

    this.cantonService.obtenerPoridProvincia(idProvincia).subscribe({
      next: (data) => {
        this.cantones = data;
      },
      error: (error) => {
        console.log(error);
      },
    });
  }

  private obtenerParroquias(idCanton: number) {
    this.parroquiaService.obtenerPoridCanotn(idCanton).subscribe({
      next: (data) => {
        this.parroquias = data;
      },
      error: (error) => {
        console.log(error);
      },
    });
  }

  private prefectoSeleccionado() {
    this.cambiarSeleccionDignidad(true, false, false, false, false);
  }
  private alcaldeSeleccionado() {
    this.cambiarSeleccionDignidad(false, true, false, false, false);
  }
  private concejalUrbanoSeleccionado() {
    this.cambiarSeleccionDignidad(false, false, true, false, false);
  }
  private concejalRuralSeleccionado() {
    this.cambiarSeleccionDignidad(false, false, false, true, false);
  }
  private vocalJuntasSeleccionado() {
    this.cambiarSeleccionDignidad(false, false, false, false, true);
  }

  private cambiarSeleccionDignidad(
    seSeleccionoPrefectos: boolean,
    seSeleccionoAlcaldes: boolean,
    seSeleccionoConcejalesUrbanos: boolean,
    seSeleccionoConcejalesRurales: boolean,
    seSeleccionoVocalesJuntasParroquiales: boolean
  ) {
    this.seSeleccionoPrefectos = seSeleccionoPrefectos;
    this.seSeleccionoAlcaldes = seSeleccionoAlcaldes;
    this.seSeleccionoConcejalesUrbanos = seSeleccionoConcejalesUrbanos;
    this.seSeleccionoConcejalesRurales = seSeleccionoConcejalesRurales;
    this.seSeleccionoVocalesJuntasParroquiales =
      seSeleccionoVocalesJuntasParroquiales;
  }
}
