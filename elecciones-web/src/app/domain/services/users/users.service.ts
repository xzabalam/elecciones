import { HttpService } from './../http/http.service';
import { UsuarioMapper } from './../../../domain/model/mapper/usuario_mapper';
import { Router } from '@angular/router';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class UsersService {
  constructor(private httpService: HttpService, private router: Router) {}

  public login(user: any): Observable<any> {
    var token = window.btoa(`${user.username}:${user.password}`);
    localStorage.setItem('token', token);
    return this.httpService.get('/auth', token);
  }

  public isAuthenticated(): boolean {
    const token = localStorage.getItem('token');
    const datosUsuario = localStorage.getItem('datosUsuario');

    return (
      token != null &&
      token != undefined &&
      datosUsuario != null &&
      datosUsuario != undefined
    );
  }

  public authenticate(datosUsuario: string) {
    localStorage.setItem('datosUsuario', datosUsuario);
    this.router.navigate(['estadisticas']);
  }

  public logout() {
    localStorage.clear();
    this.router.navigate(['login']);
  }

  public getToken() {
    return localStorage.getItem('token');
  }

  public getDatosUsuario(): any {
    var jsonDatosUsuario = localStorage.getItem('datosUsuario');
    return jsonDatosUsuario == null
      ? null
      : UsuarioMapper.toUsuarioDto(jsonDatosUsuario ?? '');
  }
}
