import { Component, OnInit } from '@angular/core';
import { KeycloakService } from 'keycloak-angular';
import { icon, Marker } from 'leaflet';
import { NgxPermissionsService } from 'ngx-permissions';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})


export class AppComponent implements OnInit{

  title = 'event-webapp';

  constructor(private keycloakService :KeycloakService,
    private permissionsService: NgxPermissionsService){

  }

  ngOnInit() {
    // console.log(this.permissionsService.getPermissions());
    // console.log(this.keycloakService.getUserRoles());
    // console.log(this.keycloakService.logout);
    this.permissionsService.loadPermissions(this.keycloakService.getUserRoles());

    const iconRetinaUrl = 'marker-icon-2x.png';
    const iconUrl = 'marker-icon.png';
    const shadowUrl = 'marker-shadow.png';
    Marker.prototype.options.icon = icon({
      iconRetinaUrl,
      iconUrl,
      shadowUrl,
      iconSize: [25, 41],
      iconAnchor: [12, 41],
      popupAnchor: [1, -34],
      tooltipAnchor: [16, -28],
      shadowSize: [41, 41]
    });
  }
}

