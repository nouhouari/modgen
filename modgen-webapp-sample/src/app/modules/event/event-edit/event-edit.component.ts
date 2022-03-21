import { Component, Input, SimpleChanges } from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Point } from 'geojson';
import { Event } from 'src/app/generated/shared/models/event.model';
import { EventEditComponent } from 'src/app/generated/shared/modules/event/components/event-edit/event-edit.component';
import { EventService } from 'src/app/generated/shared/modules/event/services/event.service';
import { Utils } from 'src/app/utils/utils';
import { config } from 'src/app/shared/data/editor-config';
import { Media } from 'src/app/generated/shared/models/media.model';
import { MediaService } from 'src/app/generated/shared/modules/media/services/media.service';
import { FileService } from 'src/app/shared/services/file.service';
import { Organizer } from 'src/app/generated/shared/models/organizer.model';
import { Venue } from 'src/app/generated/shared/models/venue.model';

@Component({
  selector: 'event-edit',
  templateUrl: './event-edit.component.html',
  styleUrls: ['./event-edit.component.scss']
})
export class MyEventEditComponent extends EventEditComponent {

  @Input()
  event: Event;
  editorConfig = config;
  files: File[] = [];
  uploadingFile: boolean;
  // Map of current local and remote files
  currentFiles: Map<File, any> = new Map<File, any>();
  @Input()
  showPictures: boolean = false;
  @Input()
  pictures: Media[];
  @Input()
  load: boolean;

  organizer: Organizer;
  venue: Venue;

  constructor(
    protected formBuilder: FormBuilder,
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private eventService: EventService,
    private mediaService: MediaService,
    private fileService: FileService) {
    super(formBuilder)
  }

  ngOnInit(): void {
    super.ngOnInit();
    this.form = this.formBuilder.group({
      // id field
      id: new FormControl(''),
      // name field
      name: new FormControl('', Validators.required),
      // description field
      description: new FormControl(''),
      // startDate field
      startDate: new FormControl('', Validators.required),
      // organizer field
      organizer_event: new FormControl(''),
      // endDate field
      endDate: new FormControl(''),
      // type field
      type: new FormControl('', Validators.required),
      // timeZone field
      timeZone: new FormControl('', Validators.required),
      // format field
      format: new FormControl('', Validators.required),
      // active field
      active: new FormControl(''),
      // media
      media: new FormControl(''),
      // venue
      venue_event: new FormControl(''),
    });

    if (this.load) {
      let eventId = this.activatedRoute.snapshot.paramMap.get('id');
      if (eventId) {
        this.eventService.getEventById(eventId).subscribe(
          ev => {
            this.event = ev;
            this.form.patchValue(ev);
            this.organizer = ev.organizer_event;
            this.venue = ev.venue_event;
          }
        )
      }
    }
  }

  ngOnChanges(changes: SimpleChanges): void {
    super.ngOnChanges(changes);
    if (changes.data && changes.data.currentValue) {
      this.organizer = changes.data.currentValue.organizer_event;
      this.venue = changes.data.currentValue.venue_event;
    }
  }

  onSave(event: Event) {
    console.log(event);
    this.eventService.save(event).subscribe((event) => {
      this.router.navigate([Utils.paths.EVENT.LIST]);
    });
  }

  onSelect(event) {
    if (event.addedFiles.length == 0) {
      return;
    }
    this.files.push(...event.addedFiles);
    this.uploadingFile = true
    this.fileService.uploadFile(event.addedFiles[0]).subscribe(
      response => {
        this.uploadingFile = false;
        this.currentFiles.set(event.addedFiles[0], response.fileName);
        this.rebuildMedia();
      },
      () => this.uploadingFile = false
    )
  }

  onRemove(event) {
    this.files.splice(this.files.indexOf(event), 1);
    this.currentFiles.delete(event);
    this.rebuildMedia();
  }

  rebuildMedia() {
    var medias: Media[] = [];
    this.currentFiles.forEach((value, key) => {
      var m: Media = new Media;
      if (this.data) {
        m.event = this.data;
      }
      m.filePath = value;
      medias.push(m);
      this.form.patchValue({ media: medias });
    });
  }

  getPath(m: Media) {
    return 'api/file?fileName=' + m.filePath;
  }

  delete(m: Media) {
    this.mediaService.deleteMediaById(m.id).subscribe(
      (_) => this.pictures.splice(this.pictures.indexOf(m), 1)
    );
  }

  onOrganizerSelected(organizer: Organizer) {
    this.form.patchValue({ organizer_event: organizer });
  }

  onVenueSelected(venue: Venue) {
    console.log('Venue selected', venue);
    
    this.form.patchValue({ venue_event: venue });
  }

}
