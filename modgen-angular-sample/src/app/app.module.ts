import { BrowserModule } from '@angular/platform-browser';
import { APP_INITIALIZER, NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { KeycloakService } from 'keycloak-angular';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialDesignFrameworkModule } from '@ajsf/material';
import { MaterialModule } from './material-component.module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { NgxPermissionsModule, NgxPermissionsService } from 'ngx-permissions';

// Generated code
import { EventEditComponent } from './generated/shared/modules/event/components/event-edit/event-edit.component';
import { EventCreateComponent } from './generated/shared/modules/event/components/event-create/event-create.component';
import { EventUpdateComponent } from './generated/shared/modules/event/components/event-update/event-update.component';
import { EventSearchComponent } from './generated/shared/modules/event/components/event-search/event-search.component';
import {EventListComponent} from './generated/shared/modules/event/components/event-list/event.component';

import { EventService } from './generated/shared/modules/event/services/event.service';
import { DialogComponent } from './generated/shared/modules/shared/components/dialog/dialog.component';


export function initializeKeycloak(keycloak: KeycloakService) {
  return () =>
    keycloak.init({
      config: {
        url: 'http://localhost:8080/auth',
        realm: 'demo',
        clientId: 'webapp'
      },
      initOptions: {
        onLoad: 'check-sso',
        silentCheckSsoRedirectUri: window.location.origin + '/assets/silent-check-sso.html',
      }
    });
}


@NgModule({
  declarations: [
    AppComponent,
    // Generated components
    EventEditComponent,
    EventCreateComponent,
    EventSearchComponent,
    EventUpdateComponent,
    EventListComponent,
    DialogComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    FormsModule,
    MaterialDesignFrameworkModule,
    BrowserAnimationsModule,
    MaterialModule,
    FlexLayoutModule,
    NgxPermissionsModule.forRoot(),
  ],
  providers: [
    {
      provide: APP_INITIALIZER,
      useFactory: initializeKeycloak,
      multi: true,
      deps: [KeycloakService]
    },
    KeycloakService,
    NgxPermissionsService,
    EventService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
