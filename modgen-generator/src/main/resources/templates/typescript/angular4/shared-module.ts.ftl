import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxPermissionsModule } from 'ngx-permissions';
import { DialogComponent } from '../shared/components/dialog/dialog.component';
import { MaterialModule } from 'src/app/core/material/material-component/material.module';
import { JsonSchemaFormModule } from '@ajsf/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    DialogComponent,
  ],
  exports: [
    DialogComponent,
    JsonSchemaFormModule,
    MaterialModule,
    FormsModule, 
    ReactiveFormsModule,
    NgxPermissionsModule
  ],
  imports: [
    CommonModule,
    JsonSchemaFormModule,
    MaterialModule,
    FormsModule,
    ReactiveFormsModule,
    NgxPermissionsModule.forChild(),
  ]
})
export class GeneratedSharedModule { }
