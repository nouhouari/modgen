import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { EventSearchCriteria } from '../../../../models/event.model';


@Component({
  selector: 'app-event-quicksearch',
  templateUrl: './event-quicksearch.component.html'
})
export class EventQuickSearchComponent implements OnInit {

  @Input()
  title: string;
  @Output()
  criteria: EventEmitter<EventSearchCriteria> = new EventEmitter<EventSearchCriteria>();
  @Output()
  clear: EventEmitter<any> = new EventEmitter();
  form: FormGroup;
  searchCriteria: EventSearchCriteria = new EventSearchCriteria();
  
  constructor(private formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      quickSearchQuery: new FormControl('')
    });
  }

  onSearch(){
    this.searchCriteria = this.form.value;
    this.criteria.emit(this.searchCriteria);
  }

  onClear(){
    this.form.reset();
    this.clear.emit();
  }

}
