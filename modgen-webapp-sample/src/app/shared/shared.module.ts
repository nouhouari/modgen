import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FileTypeFilterPipe } from './pipes/file-type-filter.pipe';
import { TimezoneComponent } from './components/timezone/timezone.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';



@NgModule({
  declarations: [
    FileTypeFilterPipe,
    TimezoneComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    MatFormFieldModule,
    MatSelectModule,
    ReactiveFormsModule
  ],
  exports:[
    FileTypeFilterPipe,
    TimezoneComponent
  ]
})
export class SharedModule { }
