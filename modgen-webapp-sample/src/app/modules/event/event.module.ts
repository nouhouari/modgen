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
import { MyEventEditComponent } from './event-edit/event-edit.component';
import { GeneratedSharedModule } from 'src/app/generated/shared/modules/shared/shared.module';
import { AngularEditorModule } from '@kolkov/angular-editor';
import { SharedModule } from 'src/app/shared/shared.module';
import { OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { MyEventUpdateComponent } from './event-update/event-update.component';
import { MediaService } from 'src/app/generated/shared/modules/media/services/media.service';
import { NgxDropzoneModule } from 'ngx-dropzone';
import { FlexLayoutModule } from '@angular/flex-layout';
import { MyOrganizerModule } from '../organizer/organizer.module';
import { OrganizerSelectComponent } from './organizer-select/organizer-select.component';
import { VenueSelectComponent } from './venue-select/venue-select.component';


@NgModule({
  declarations: [
    EventComponent,
    EventCreateComponent,
    EventDetailsComponent,
    MyEventEditComponent,
    MyEventUpdateComponent,
    OrganizerSelectComponent,
    VenueSelectComponent,
  ],
  imports: [
    // Angular
    CommonModule,
    RouterModule,
    HttpClientModule,
    GeneratedSharedModule,
    // 3rd party
    MaterialModule,
    AngularEditorModule,
    OwlDateTimeModule, 
    OwlNativeDateTimeModule,
    FlexLayoutModule,
    NgxPermissionsModule.forChild(),
    NgxDropzoneModule,
    // App
    GeneratedEventModule,
    EventRoutingModule,
    SharedModule
  ],
  providers: [
    EventService,
    MediaService
  ]
})
export class EventModule { }
