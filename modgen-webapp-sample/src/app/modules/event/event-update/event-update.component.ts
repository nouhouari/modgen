import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Event } from 'src/app/generated/shared/models/event.model';
import { Media, MediaSearchCriteria } from 'src/app/generated/shared/models/media.model';
import { EventUpdateComponent } from 'src/app/generated/shared/modules/event/components/event-update/event-update.component';
import { EventService } from 'src/app/generated/shared/modules/event/services/event.service';
import { MediaService } from 'src/app/generated/shared/modules/media/services/media.service';
import { Utils } from 'src/app/utils/utils';

@Component({
  selector: 'event-update',
  templateUrl: './event-update.component.html',
  styleUrls: ['./event-update.component.scss']
})
export class MyEventUpdateComponent extends EventUpdateComponent {

  mediaSearchCriteria: MediaSearchCriteria = new MediaSearchCriteria();
  medias: Media[];

  constructor(
    protected eventService: EventService,
    protected mediaService: MediaService,
    protected router: Router,
    protected activatedRoute: ActivatedRoute){
    super(eventService);
  }

  ngOnInit(): void {
    let eventId = this.activatedRoute.snapshot.paramMap.get('id');
    this.mediaSearchCriteria.eventId = eventId;
    this.eventService.getEventById(eventId).subscribe(
      event => {
        this.data = event;
      }
    )
    this.mediaService.find(this.mediaSearchCriteria).subscribe(
      page => this.medias = page.content
    )
  }

  onSave(event: any){
    event.id = this.data.id;
    this.eventService.save(event).subscribe(
      (_) => {
        this.router.navigate([Utils.paths.EVENT.LIST]);
      }
    );

    if(event.media){
      // Saving pictures
      event.media.forEach(m =>{
        this.mediaService.save(m).subscribe(
          m => console.log
        );
      })
    }
  }

}
