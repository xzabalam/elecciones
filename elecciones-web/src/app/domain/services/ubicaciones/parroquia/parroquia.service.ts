import { ParroquiaDto } from './../../../model/dto/ubicacion/parroquia_dto';
import { Observable } from 'rxjs';
import { HttpService } from './../../http/http.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class ParroquiaService {
  constructor(private httpService: HttpService) {}

  obtenerPoridCanotn(idCanotn: number): Observable<Array<ParroquiaDto>> {
    return this.httpService.get(`/parroquia/canton/${idCanotn}/all`);
  }
}
