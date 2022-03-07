import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxPermissionsModule } from 'ngx-permissions';
import { DialogComponent } from '../shared/components/dialog/dialog.component';
import { MaterialModule } from 'src/app/core/material/material-component/material.module';

@NgModule({
  declarations: [
    DialogComponent,
  ],
  exports: [
    DialogComponent,
  ],
  imports: [
    CommonModule,
    MaterialModule,
    NgxPermissionsModule.forChild(),
  ]
})
export class GeneratedSharedModule { }
