import { HttpService } from './../http/http.service';
import { environment } from './../../../../environments/environment.prod';
import { Observable, catchError, throwError } from 'rxjs';
import { HttpErrorService } from '../http/http-error.service';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class DignidadService {
  constructor(private httpService: HttpService) {}

  obtenerDignidades(): Observable<any> {
    return this.httpService.get('/dignidad/all');
  }
}
