import { Component, OnInit, Input} from '@angular/core';
import { Event } from '../../../../models/event.model';
import { EventService } from '../../services/event.service';

@Component({
  selector: 'app-event-create',
  templateUrl: './event-create.component.html'
})
export class EventCreateComponent implements OnInit {

  @Input()
  public schema: any;

  constructor(protected eventService: EventService) { }

  ngOnInit(): void {
  }

  onSave(event: Event){
    this.eventService.save(event).subscribe(
      console.log
    );
  }

}
