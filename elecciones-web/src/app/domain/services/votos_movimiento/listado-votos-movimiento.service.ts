import { VotosMovimientoDto } from './../../model/dto/estaditicas/votos_movimiento_dto';
import { Observable } from 'rxjs';
import { HttpService } from './../http/http.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class ListadoVotosMovimientoService {
  constructor(private httpService: HttpService) {}

  numeroVotosParaPrefectoPorProvincia(
    idProvincia: number
  ): Observable<Array<VotosMovimientoDto>> {
    return this.httpService.get(
      `/estadisticas/prefectos/provincia/${idProvincia}`
    );
  }

  numeroVotosParaAlcaldesPorProvinciaYCanton(
    idProvincia: number,
    idCanton: number
  ): Observable<Array<VotosMovimientoDto>> {
    return this.httpService.get(
      `/estadisticas/alcaldes/provincia/${idProvincia}/canton/${idCanton}`
    );
  }

  numeroVotosParaConcejalesUrbanosPorProvinciaYCanton(
    idProvincia: number,
    idCanton: number
  ): Observable<Array<VotosMovimientoDto>> {
    return this.httpService.get(
      `/estadisticas/concejales/urbanos/provincia/${idProvincia}/canton/${idCanton}`
    );
  }

  numeroVotosParaConcejalesRuralesPorProvinciaYCanton(
    idProvincia: number,
    idCanton: number
  ): Observable<Array<VotosMovimientoDto>> {
    return this.httpService.get(
      `/estadisticas/concejales/rurales/provincia/${idProvincia}/canton/${idCanton}`
    );
  }

  numeroVotosParaVocalesJuntasParroquialesPorProvinciaYCantonYParroquia(
    idProvincia: number,
    idCanton: number,
    idParroquia: number
  ): Observable<Array<VotosMovimientoDto>> {
    return this.httpService.get(
      `/estadisticas/vocales/juntas/provincia/${idProvincia}/canton/${idCanton}/parroquia/${idParroquia}`
    );
  }

  numeroVotosParaConcejalesUrbanosPorProvinciaCantonDignidadCircunscripcion(
    idProvincia: number,
    idCanton: number,
    idDignidad: number,
    idCircunscripcion: number
  ): Observable<Array<VotosMovimientoDto>> {
    return this.httpService.get(
      `/estadisticas/concejales/urbanos/provincia/${idProvincia}/canton/${idCanton}/dignidad/${idDignidad}/circunscripcion/${idCircunscripcion}`
    );
  }
}
