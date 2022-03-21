import { Component, Input } from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Organizer } from 'src/app/generated/shared/models/organizer.model';
import { OrganizerEditComponent } from 'src/app/generated/shared/modules/organizer/components/organizer-edit/organizer-edit.component';
import { OrganizerService } from 'src/app/generated/shared/modules/organizer/services/organizer.service';
import { Utils } from 'src/app/utils/utils';
import { config } from 'src/app/shared/data/editor-config';
import { FileService } from 'src/app/shared/services/file.service';

@Component({
  selector: 'organizer-edit',
  templateUrl: './organizer-edit.component.html',
  styleUrls: ['./organizer-edit.component.scss']
})
export class MyOrganizerEditComponent extends OrganizerEditComponent {

  editorConfig = config;
  files: File[] = [];
  uploadingFile: boolean;
  picture: String;
  @Input()
  readOnly: boolean;

  constructor(
    protected formBuilder: FormBuilder,
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private organizerService: OrganizerService,
    private fileService: FileService) {
    super(formBuilder)
  }

  ngOnInit(): void {
    this.form =  this.formBuilder.group({
      // id field
      id: new FormControl(''),
      // firstName field
      firstName: new FormControl('', Validators.required),
      // lastName field
      lastName: new FormControl('', Validators.required),
      // picture field
      picture: new FormControl('', Validators.required),
      // aboutme field
      aboutme: new FormControl('')
    });
    let organizerId = this.activatedRoute.snapshot.paramMap.get('id');
    if (organizerId) {
      this.organizerService.getOrganizerById(organizerId).subscribe(
        org => {this.data = org; this.form.patchValue(this.data)}
      )
    }
    this.editorConfig.editable = !this.readOnly;
  }

  onSave(organizer: Organizer) {
    console.log(organizer);
    this.organizerService.save(organizer).subscribe((organizer) => {
      this.router.navigate([Utils.paths.ORGANIZER.LIST]);
    });
  }

  onSelect(event) {
    if (event.addedFiles.length == 0){
      return;
    }
    this.files = [];
    this.files.push(...event.addedFiles);
    this.uploadingFile = true
    this.fileService.uploadFile(event.addedFiles[0]).subscribe(
      response => {
        this.uploadingFile = false;
        this.picture = response.fileName;
        this.form.patchValue({picture: response.fileName});
        this.files = [];
      },
      () => this.uploadingFile = false
    )
  }

  onRemove(event) {
    this.files.splice(this.files.indexOf(event), 1);
  }

  getPath(fileName: String){
    return 'api/file?fileName=' + fileName;
  }

  deletePicture(){
    this.form.patchValue({picture: null});
    this.picture = null;
    this.files = [];
  }

}
