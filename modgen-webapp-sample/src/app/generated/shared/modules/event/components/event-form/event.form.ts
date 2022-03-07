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
      // location field
      location: new FormControl('')
    });
  }

  public get form() {
    return this._form;
  }
}
