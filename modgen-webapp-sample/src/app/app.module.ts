import { APP_INITIALIZER, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { environment } from '../environments/environment';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FooterComponent } from './core/layout/footer/footer.component';
import { HeaderComponent } from './core/layout/header/header.component';
import { SideNavComponent } from './core/layout/side-nav/side-nav.component';

import { MaterialModule } from './core/material/material-component/material.module';
import { MenuComponent } from './core/layout/menu/menu.component';
import { LayoutComponent } from './core/layout/layout/layout.component';
import { KeycloakService } from 'keycloak-angular';
import { NgxPermissionsModule } from 'ngx-permissions';
import { BreadcrumbModule } from 'xng-breadcrumb';
import { EventModule } from './modules/event/event.module';
import { AppConfigService } from './shared/services/app-config.service';
import { NgxMatomoTrackerModule } from '@ngx-matomo/tracker';
import { NgxMatomoRouterModule } from '@ngx-matomo/router';
import { MyVenueModule } from './modules/venue/venue.module';
import { registerLocaleData } from '@angular/common';
import en from '@angular/common/locales/en';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { MyOrganizerModule } from './modules/organizer/organizer.module';

registerLocaleData(en);

export function initialize(keycloak: KeycloakService, appConfig: AppConfigService) {
  return () => appConfig.loadAppConfig().then(() =>
    keycloak.init({
      config: {
        url: appConfig.config.keycloakUrl,
        realm: environment.realm,
        clientId: environment.clientId
      },
      initOptions: {
        onLoad: 'login-required'
        // silentCheckSsoRedirectUri: window.location.origin + '/assets/silent-check-sso.html',
      }
    }))
}

@NgModule({
  declarations: [
    AppComponent,
    FooterComponent,
    HeaderComponent,
    SideNavComponent,
    MenuComponent,
    LayoutComponent
  ],
  imports: [
    // Angular
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    // 3rd party
    MaterialModule,
    NgxPermissionsModule.forRoot(),
    BreadcrumbModule,
    // App
    EventModule,
    MyVenueModule,
    NgxMatomoTrackerModule.forRoot({
      siteId: environment.siteId, // your Matomo's site ID (find it in your Matomo's settings)
      trackerUrl: environment.trackerUrl, // your matomo server root url
    }),
    NgxMatomoRouterModule,
    FormsModule,
    HttpClientModule,
    MyOrganizerModule
  ],
  providers: [
    KeycloakService,
    AppConfigService,
    {
      provide: APP_INITIALIZER,
      useFactory: initialize,
      multi: true,
      deps: [KeycloakService, AppConfigService]
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
