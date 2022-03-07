import { Component, OnInit } from '@angular/core';
import { KeycloakService } from 'keycloak-angular';
import { DynamicMenu, initialNavigation } from '../menu/menu';

@Component({
  selector: 'app-side-nav',
  templateUrl: './side-nav.component.html',
  styleUrls: ['./side-nav.component.scss']
})
export class SideNavComponent implements OnInit {

  menuList:DynamicMenu[]=initialNavigation;
  firstname: String;
  lastname: String;
  email: String;

  constructor(private keycloakService :KeycloakService) { }

  ngOnInit(): void {
    this.keycloakService.loadUserProfile().then(
      profile => {
        this.firstname = profile.firstName;
        this.lastname  = profile.lastName;
        this.email     = profile.email;
      }
    );
  }
  closide(){

  }
  logout(){
    this.keycloakService.logout();
  }
}
