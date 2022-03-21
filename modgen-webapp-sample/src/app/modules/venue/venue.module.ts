import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MyVenueComponent } from './venue/venue.component';
import { RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from 'src/app/core/material/material-component/material.module';
import { NgxPermissionsModule } from 'ngx-permissions';
import { MyVenueRoutingModule } from './venue-routing.module';
import { GeneratedVenueModule } from 'src/app/generated/shared/modules/venue/venue.module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { MyVenueCreateComponent } from './venue-create/venue-create.component';
import { MyVenueEditComponent } from './venue-edit/venue-edit.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AngularEditorModule } from '@kolkov/angular-editor';
import { NominatimService } from 'src/app/shared/services/nominatim.service';
import { NgxDropzoneModule } from 'ngx-dropzone';
import { SharedModule } from 'src/app/shared/shared.module';
import { FileService } from 'src/app/shared/services/file.service';
import { MyVenueUpdateComponent } from './venue-update/venue-update.component';
import { MediaService } from 'src/app/generated/shared/modules/media/services/media.service';


@NgModule({
  declarations: [
    MyVenueComponent,
    MyVenueEditComponent,
    MyVenueCreateComponent,
    MyVenueUpdateComponent,
  ],
  imports: [
    // Angular
    CommonModule,
    RouterModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    AngularEditorModule,
    SharedModule,
    // 3rd party
    MaterialModule,
    NgxPermissionsModule.forChild(),
    // App
    MyVenueRoutingModule,
    GeneratedVenueModule,
    FlexLayoutModule,
    NgxDropzoneModule
  ],
  providers: [
    NominatimService,
    FileService,
    MediaService
  ]
})
export class MyVenueModule { }
