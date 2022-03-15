import { FormBuilder, FormControl, FormGroup } from '@angular/forms';


export class EventForm {
  private _form: FormGroup;

  constructor(formBuilder: FormBuilder) {
    this._form = formBuilder.group({
      // id field
      id: new FormControl(''),
      // name field
      name: new FormControl(''),
      // description field
      description: new FormControl(''),
      // startDate field
      startDate: new FormControl(''),
      // organizer field
      organizer: new FormControl(''),
      // endDate field
      endDate: new FormControl(''),
      // type field
      type: new FormControl(''),
      // timeZone field
      timeZone: new FormControl(''),
      // format field
      format: new FormControl(''),
      // active field
      active: new FormControl(''),
    });
  }

  public get form() {
    return this._form;
  }
}
