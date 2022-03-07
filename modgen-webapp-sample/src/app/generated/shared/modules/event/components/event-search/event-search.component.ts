import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { EventSearchCriteria } from '../../../../models/event.model';

@Component({
  selector: 'app-event-search',
  templateUrl: './event-search.component.html'
})
export class EventSearchComponent implements OnInit {

  @Output()
  criteria: EventEmitter<EventSearchCriteria> = new EventEmitter<EventSearchCriteria>();
  @Output()
  clear: EventEmitter<EventSearchCriteria> = new EventEmitter();
  form: FormGroup;
  searchCriteria: EventSearchCriteria = new EventSearchCriteria();

  constructor(private formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
         name: new FormControl('')
    });
  }

  onSearch(){
    this.searchCriteria = this.form.value;
    this.criteria.emit(this.searchCriteria);
  }

  onClear(){
    this.form.reset();
    this.clear.emit(new EventSearchCriteria());
  }

}
