import { ProvinciaDto } from './../../../model/dto/ubicacion/provincia_dto';
import { HttpService } from '../../http/http.service';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ProvinciaService {
  constructor(private httpService: HttpService) {}

  obtenerPoridPais(idPais: number): Observable<Array<ProvinciaDto>> {
    return this.httpService.get(`/provincia/pais/${idPais}/all`);
  }
}
