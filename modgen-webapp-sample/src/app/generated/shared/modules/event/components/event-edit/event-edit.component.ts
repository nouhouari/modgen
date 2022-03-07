import { Component, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Event } from '../../../../models/event.model';
import { EventForm } from '../event-form/event.form';
import { JsonSchemaFormComponent } from '@ajsf/core';

@Component({
  selector: 'app-event-edit',
  templateUrl: './event-edit.component.html'
})
export class EventEditComponent implements OnInit, OnChanges {

  public form: FormGroup;
  @Input()
  public data: Event;
  @Output()
  public save: EventEmitter<Event> = new EventEmitter<Event>();
  @Input()
  public schema: any;
  // JSON extension configuration
  @ViewChild(JsonSchemaFormComponent, {static: true})
  public extensionForm: JsonSchemaFormComponent;
  public extensionValid: boolean;
  options = {addSubmit: false};

  constructor(protected formBuilder: FormBuilder) { }

  ngOnChanges(changes: SimpleChanges): void {
    if (this.form){
      this.form.patchValue(changes.data.currentValue);
      this.extensionForm.setFormValues(changes.data.currentValue.extension.extension);
    }
  }

  ngOnInit(): void {
    this.form = new EventForm(this.formBuilder).form;
      if (this.data) {
        this.form.patchValue(this.data);
      }
  }

  public submit(){
    let event: Event = this.form.value;
    // Extension
    if (this.extensionForm){
      this.extensionForm.submitForm();
      event.extension = {extension: this.extensionForm.value};
    }  
    this.save.emit(event);
  }
  
  public isExtensionValid(isValid: boolean){
    this.extensionValid = isValid;
  }
}
