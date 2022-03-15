import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { EventSearchCriteria } from '../../../../models/event.model';
import { EventType } from '../../../../models/eventtype.enum';
import { EventFormat } from '../../../../models/eventformat.enum';

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
  public typeValues: any[] = [
    {
        label: 'CONFERENCE',
        value: EventType.CONFERENCE,
    },
    {
        label: 'TRADE_SHOW',
        value: EventType.TRADE_SHOW,
    },
    {
        label: 'WORKSHOP',
        value: EventType.WORKSHOP,
    },
    ];
  public formatValues: any[] = [
    {
        label: 'ONLINE',
        value: EventFormat.ONLINE,
    },
    {
        label: 'ONSITE',
        value: EventFormat.ONSITE,
    },
    ];

  constructor(private formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
         name: new FormControl(''),
         type: new FormControl(''),
         format: new FormControl(''),
         active: new FormControl('')
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
