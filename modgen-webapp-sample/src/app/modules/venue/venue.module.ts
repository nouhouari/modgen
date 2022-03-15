import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { VenueComponent } from './venue/venue.component';
import { VenueService } from 'src/app/generated/shared/modules/venue/services/venue.service';
import { RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from 'src/app/core/material/material-component/material.module';
import { NgxPermissionsModule } from 'ngx-permissions';
import { GeneratedVenueModule } from 'src/app/generated/shared/modules/venue/venue.module';
import { VenueRoutingModule } from './venue-routing.module';



@NgModule({
  declarations: [
    VenueComponent
  ],
  imports: [
    // Angular
    CommonModule,
    RouterModule,
    HttpClientModule,
    // 3rd party
    MaterialModule,
    NgxPermissionsModule.forChild(),
    // App
    VenueRoutingModule,
    VenueModule
  ]
})
export class VenueModule { }
