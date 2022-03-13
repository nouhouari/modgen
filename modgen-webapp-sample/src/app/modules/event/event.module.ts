import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { NgxPermissionsModule } from 'ngx-permissions';
import { MaterialModule } from '../../core/material/material-component/material.module';
import { EventCreateComponent } from './event-create/event-create.component';
import { EventDetailsComponent } from './event-details/event-details.component';

import { EventRoutingModule } from './event-routing.module';
import { EventComponent } from './event/event.component';
import { GeneratedEventModule } from '../../generated/shared/modules/event/event.module';
import { EventService } from '../../generated/shared/modules/event/services/event.service';
import { EventEditComponent } from './event-edit/event-edit.component';


@NgModule({
  declarations: [
    EventComponent,
    EventCreateComponent,
    EventDetailsComponent,
    EventEditComponent,
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
    GeneratedEventModule,
    EventRoutingModule
  ],
  providers: [
    EventService
  ]
})
export class EventModule { }
