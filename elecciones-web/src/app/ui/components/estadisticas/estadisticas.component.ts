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
import { Component, OnInit } from '@angular/core';
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
  seSeleccionoDignidad = false;

  posicionDignidadSeleccionada: number = -1;

  seSeleccionoPrefectos = false;
  seSeleccionoAlcaldes = false;
  seSeleccionoConcejalesUrbanos = false;
  seSeleccionoConcejalesRurales = false;
  seSeleccionoVocalesJuntasParroquiales = false;

  provincias: Array<ProvinciaDto> = [];
  provinciaSeleccionada: ProvinciaDto | undefined;
  seSeleccionoProvincia = false;

  cantones: Array<CantonDto> = [];
  cantonSeleccionado: CantonDto | undefined;
  seSeleccionoCanton = false;

  parroquias: Array<ParroquiaDto> = [];
  parroquiaSeleccionada: ParroquiaDto | undefined;
  seSeleccionoParroquia = false;

  cantidadTotalElectores: number = 0;
  respuestaSumatoriaVotosPorMovimiento: Array<VotosMovimientoDto> = [];

  public chart: any;

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

    if (this.chart) {
      this.chart.destroy();
    }

    if (this.seSeleccionoPrefectos) {
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
    if (this.chart) {
      this.chart.destroy();
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
    } else {
      this.obtenerParroquias(this.cantonSeleccionado!.id);
    }
  }

  onChangeSelectParroquia() {
    this.seSeleccionoParroquia = true;
    this.cantidadTotalElectores = 0;
    if (this.chart) {
      this.chart.destroy();
    }
    this.obtenerSumatoriaVotosPorVocalesJuntasParroquiales(
      this.provinciaSeleccionada!.id,
      this.cantonSeleccionado!.id,
      this.parroquiaSeleccionada!.id
    );
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
        'Lista ' + votos.numeroMovimiento + '. Votos: ' + votos.sumatoria
    );
    var datos: number[] = votosPorMovimiento.map((votos) => votos.sumatoria);
    this.cantidadTotalElectores = datos.reduce(
      (result, votos) => result + votos,
      0
    );

    this.chart = new Chart('MyChart', {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [
          {
            data: datos,
            backgroundColor: '#3f51b5',
          },
        ],
      },
      options: {
        aspectRatio: 1,
        responsive: true,
        plugins: {
          legend: {
            display: false,
            position: 'top',
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
