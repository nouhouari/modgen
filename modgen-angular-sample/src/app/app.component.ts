import { PlatformLocation, ɵBrowserPlatformLocation } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { KeycloakService } from 'keycloak-angular';
import { KeycloakProfile } from 'keycloak-js';
import { NgxPermissionsService } from 'ngx-permissions';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  logged: boolean;
  public userProfile: KeycloakProfile | null = null;

  constructor(
    private keycloak: KeycloakService,
    private platform: PlatformLocation,
    private ngxPermissionService: NgxPermissionsService
  ) {}

  ngOnInit(): void {
    this.isLogged();
  }

  async isLogged() {
    this.logged = await this.keycloak.isLoggedIn();

    if (this.logged) {
      this.userProfile = await this.keycloak.loadUserProfile();
      this.loadPermissionsFromKeycloak();
    }
  }

  logout() {
    let baseRoute = (this.platform as any).location.origin;
    this.keycloak.logout(baseRoute);
    // Remove all the permissions
    this.ngxPermissionService.flushPermissions();
  }

  login() {
    this.keycloak.login().then(() => {
      this.loadPermissionsFromKeycloak();
    });
  }

  private loadPermissionsFromKeycloak() {
    var permissions = this.keycloak.getUserRoles();
    this.ngxPermissionService.loadPermissions(permissions);
  }
}
