import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { NgxPermissionsModule } from 'ngx-permissions';
import { MaterialModule } from '../../core/material/material-component/material.module';
// import { OrganizerCreateComponent } from './organizer-create/organizer-create.component';
// import { OrganizerDetailsComponent } from './organizer-details/organizer-details.component';

import { OrganizerRoutingModule } from './organizer-routing.module';
import { MyOrganizerComponent } from './organizer/organizer.component';
import { GeneratedOrganizerModule } from '../../generated/shared/modules/organizer/organizer.module';
import { OrganizerService } from '../../generated/shared/modules/organizer/services/organizer.service';
// import { MyOrganizerEditComponent } from './organizer-edit/organizer-edit.component';
import { GeneratedSharedModule } from 'src/app/generated/shared/modules/shared/shared.module';
import { AngularEditorModule } from '@kolkov/angular-editor';
import { SharedModule } from 'src/app/shared/shared.module';
import { OwlDateTimeModule, OwlNativeDateTimeModule } from '@danielmoncada/angular-datetime-picker';
import { MyOrganizerCreateComponent } from './organizer-create/organizer-create.component';
import { MyOrganizerEditComponent } from './organizer-edit/organizer-edit.component';
import { NgxDropzoneModule } from 'ngx-dropzone';
import { MyOrganizerListComponent } from './organizer-list/organizer.component';
import { MyOrganizerUpdateComponent } from './organizer-update/organizer-update.component';
import { MyOrganizerDetailsComponent } from './organizer-details/organizer-details.component';

@NgModule({
  declarations: [
    MyOrganizerComponent,
    MyOrganizerCreateComponent,
    MyOrganizerEditComponent,
    MyOrganizerListComponent,
    MyOrganizerUpdateComponent,
    MyOrganizerDetailsComponent
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
    NgxPermissionsModule.forChild(),
    NgxDropzoneModule,
    // App
    GeneratedOrganizerModule,
    OrganizerRoutingModule,
    SharedModule
  ],
  providers: [
    OrganizerService
  ]
})
export class MyOrganizerModule { }
