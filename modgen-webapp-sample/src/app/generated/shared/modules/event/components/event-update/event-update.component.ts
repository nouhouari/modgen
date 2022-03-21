import { Component, Input, OnInit } from '@angular/core';
import { Event } from '../../../../models/event.model';
import { EventService } from '../../services/event.service';

@Component({
  selector: 'app-event-update',
  templateUrl: './event-update.component.html'
})
export class EventUpdateComponent implements OnInit {

  @Input()
  data: Event;
  @Input()
  public schema: any;

  constructor(protected eventService: EventService) { }
  
  ngOnInit(): void { }
  
  onSave(event: Event){
    this.eventService.save(event).subscribe(
      console.log
    );
  }

}
