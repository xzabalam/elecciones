import { CantonDto } from './../../../model/dto/ubicacion/canton_dto';
import { Observable } from 'rxjs';
import { HttpService } from './../../http/http.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class CantonService {
  constructor(private httpService: HttpService) {}

  obtenerPoridProvincia(idProvincia: number): Observable<Array<CantonDto>> {
    return this.httpService.get(`/canton/provincia/${idProvincia}/all`);
  }
}
