import { Component, Input, SimpleChanges } from '@angular/core';
import { VenueEditComponent } from 'src/app/generated/shared/modules/venue/components/venue-edit/venue-edit.component';
import { AngularEditorConfig } from '@kolkov/angular-editor';
import { countries } from 'src/app/shared/data/countries';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { Point } from 'geojson';
import { FileService } from 'src/app/shared/services/file.service';
import { Media } from 'src/app/generated/shared/models/media.model';
import { MediaService } from 'src/app/generated/shared/modules/media/services/media.service';
import { config } from 'src/app/shared/data/editor-config';

@Component({
  selector: 'venue-edit',
  templateUrl: './venue-edit.component.html',
  styleUrls: ['./venue-edit.component.scss']
})
export class MyVenueEditComponent extends VenueEditComponent {

  countries = countries;
  files: File[] = [];
  uploadingFile: boolean;
  // Map of current local and remote files
  currentFiles:Map<File,any> = new Map<File, any>();
  @Input()
  showPictures: boolean = false;
  @Input()
  pictures: Media[];
  @Input()
  venueLocation: Point;
  editorConfig = config;

  constructor(
    formBuilder: FormBuilder, 
    private fileService: FileService,
    private mediaService: MediaService){
    super(formBuilder);
  }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      // name field
      name: new FormControl('', Validators.required),
      // description field
      description: new FormControl(''),
      // address field
      address: new FormControl(''),
      // city field
      city: new FormControl('', Validators.required),
      // country field
      country: new FormControl('', Validators.required),
      // zipCode field
      zipCode: new FormControl(''),
      // contactNumber field
      contactNumber: new FormControl(''),
      // contactEmail field
      contactEmail: new FormControl(''),
      // website field
      website: new FormControl(''),
      // location field
      location: new FormControl('', Validators.required),
      // List of pictures
      media: new FormControl('')
    });
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes.venueLocation && changes.venueLocation.currentValue){
      this.form.patchValue({location: changes.venueLocation.currentValue});
    }
    if (changes.data && changes.data.currentValue){
      this.form.patchValue(changes.data.currentValue);
    }
  }

  onSelect(event) {
    if (event.addedFiles.length == 0){
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

  rebuildMedia(){
    var medias: Media[] = [];
    this.currentFiles.forEach((value,key)=>{
      var m: Media = new Media;
      if (this.data){
        m.venue = this.data;
      }
      m.filePath = value;
      medias.push(m);
      console.log('Media', medias);
      
      this.form.patchValue({media: medias});
      console.log(this.form.value);
      
    });
  }

  getPath(m: Media){
    return 'api/file?fileName=' + m.filePath;
  }

  delete(m: Media){
    console.log(m.id);
    this.mediaService.deleteMediaById(m.id).subscribe(
      (_)=>this.pictures.splice(this.pictures.indexOf(m),1)
    );
  }

}
