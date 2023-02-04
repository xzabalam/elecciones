import {
  FormControl,
  Validators,
  FormGroupDirective,
  NgForm,
} from '@angular/forms';
import { UsersService } from './../../../domain/services/users/users.service';
import { Component } from '@angular/core';
import { ErrorStateMatcher } from '@angular/material/core';
import { Router } from '@angular/router';

export class MyErrorStateMatcher implements ErrorStateMatcher {
  isErrorState(
    control: FormControl | null,
    form: FormGroupDirective | NgForm | null
  ): boolean {
    const isSubmitted = form && form.submitted;
    return !!(
      control &&
      control.invalid &&
      (control.dirty || control.touched || isSubmitted)
    );
  }
}

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  isLoading: boolean = false;
  usernameFormControl = new FormControl('', [
    Validators.required,
    Validators.min(3),
    Validators.max(20),
  ]);
  passwordFormControl = new FormControl('', [
    Validators.required,
    Validators.min(4),
    Validators.max(20),
  ]);
  errorMsg: string = '';
  matcher = new MyErrorStateMatcher();

  constructor(public userService: UsersService, public router: Router) {}

  login() {
    this.isLoading = true;
    this.errorMsg = '';
    const user = {
      username: this.usernameFormControl.value,
      password: this.passwordFormControl.value,
    };

    this.userService.login(user).subscribe({
      next: (data) => {
        console.log(data);
        this.userService.authenticate(JSON.stringify(data));
      },
      error: (e) => {
        console.log(e);
        this.errorMsg = e.message;
        this.userService.logout();
      },
    });
  }
}
