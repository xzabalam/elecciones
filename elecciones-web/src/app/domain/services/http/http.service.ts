import { UsuarioMapper } from './../../model/mapper/usuario_mapper';
import { UsuarioDto } from './../../model/dto/usuario/usuario_dto';
import { HttpErrorService } from './http-error.service';
import { Observable, catchError, throwError } from 'rxjs';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class HttpService {
  usuario: UsuarioDto | undefined;
  urlApiClient: String;
  constructor(
    private http: HttpClient,
    public router: Router,
    public httpError: HttpErrorService
  ) {
    var jsonDatosUsuario = localStorage.getItem('datosUsuario');
    this.usuario =
      jsonDatosUsuario == null
        ? undefined
        : UsuarioMapper.toUsuarioDto(jsonDatosUsuario ?? '');
    this.urlApiClient =
      this.usuario == undefined ? '' : this.usuario.contrato.url;
  }

  get(urlServicio: string): Observable<any>;

  get(urlServicio: string, token: string): Observable<any>;

  get(urlServicio: string, token?: string): Observable<any> {
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        Authorization: `Basic ${token ?? localStorage.getItem('token')}`,
      }),
    };

    return this.http.get(this.urlApiClient + urlServicio, httpOptions).pipe(
      catchError((error) => {
        let errorMsg: string;
        if (error.error instanceof ErrorEvent) {
          errorMsg = `Error: ${error.error.message}`;
        } else {
          errorMsg = this.httpError.getServerErrorMessage(error);
        }

        return throwError(() => new Error(errorMsg));
      })
    );
  }
}
