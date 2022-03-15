import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MyVenueComponent } from './venue/venue.component';
import { RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from 'src/app/core/material/material-component/material.module';
import { NgxPermissionsModule } from 'ngx-permissions';
import { MyVenueRoutingModule } from './venue-routing.module';
import { GeneratedVenueModule } from 'src/app/generated/shared/modules/venue/venue.module';



@NgModule({
  declarations: [
    MyVenueComponent
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
    MyVenueRoutingModule,
    GeneratedVenueModule
  ]
})
export class MyVenueModule { }
