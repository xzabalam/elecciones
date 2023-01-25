import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: ` <ngx-loading-bar
      color="#FFFFFF"
      [includeSpinner]="false"
      height="4px"
    ></ngx-loading-bar>
    <router-outlet></router-outlet>`,
})
export class AppComponent {}
