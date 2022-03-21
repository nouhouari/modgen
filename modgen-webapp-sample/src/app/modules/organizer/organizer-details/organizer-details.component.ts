import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { OrganizerViewComponent } from 'src/app/generated/shared/modules/organizer/components/organizer-view/organizer-view.component';
import { OrganizerService } from 'src/app/generated/shared/modules/organizer/services/organizer.service';

@Component({
  selector: 'organizer-details',
  templateUrl: './organizer-details.component.html',
  styleUrls: ['./organizer-details.component.scss']
})
export class MyOrganizerDetailsComponent extends OrganizerViewComponent {

}
