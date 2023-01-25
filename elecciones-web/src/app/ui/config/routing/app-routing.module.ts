import { EstadisticasComponent } from '../../components/estadisticas/estadisticas.component';
import { AuthGuardService } from '../../../domain/services/auth/auth-guard.service';
import { LoginComponent } from '../../components/login/login.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'estadisticas',
    component: EstadisticasComponent,
    pathMatch: 'full',
    canActivate: [AuthGuardService],
  },
  { path: 'login', component: LoginComponent, pathMatch: 'full' },
  { path: '**', redirectTo: 'estadisticas', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
