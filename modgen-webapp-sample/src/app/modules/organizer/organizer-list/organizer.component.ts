import { Component} from '@angular/core';

import { OrganizerListComponent } from 'src/app/generated/shared/modules/organizer/components/organizer-list/organizer.component';

@Component({
  selector: 'organizer-list',
  templateUrl: './organizer.component.html',
  styleUrls: ['./organizer.component.scss']
})
export class MyOrganizerListComponent extends OrganizerListComponent {

  displayedColumns: string[] = ['picture', 'firstName','lastName','action'];

  getPath(fileName: String){
    return 'api/file?fileName=' + fileName;
  }

}
