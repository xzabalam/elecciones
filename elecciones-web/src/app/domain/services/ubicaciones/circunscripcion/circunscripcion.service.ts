import { CircunscripcionDto } from './../../../model/dto/ubicacion/circunscripcion_dto';
import { Observable } from 'rxjs';
import { HttpService } from './../../http/http.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class CircunscripcionService {
  constructor(private httpService: HttpService) {}

  obtenerPorContratoDignidad(
    idContrato: number,
    idDignidad: number
  ): Observable<Array<CircunscripcionDto>> {
    return this.httpService.get(
      `/circunscripcion/contrato/${idContrato}/dignidad/${idDignidad}`
    );
  }
}
