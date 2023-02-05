import { HttpService } from './../http/http.service';
import { Observable } from 'rxjs';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class DignidadService {
  constructor(private httpService: HttpService) {}

  obtenerDignidades(): Observable<any> {
    return this.httpService.get('/dignidad/all');
  }

  obtenerDignidadesPorContrato(idContrato: number): Observable<any> {
    return this.httpService.get(`/dignidad/contrato/${idContrato}`);
  }
}
