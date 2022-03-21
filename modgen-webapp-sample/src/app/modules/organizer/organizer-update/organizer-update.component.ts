import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Organizer } from 'src/app/generated/shared/models/organizer.model';
import { OrganizerUpdateComponent } from 'src/app/generated/shared/modules/organizer/components/organizer-update/organizer-update.component';
import { OrganizerService } from 'src/app/generated/shared/modules/organizer/services/organizer.service';
import { Utils } from 'src/app/utils/utils';

@Component({
  selector: 'app-organizer-update',
  templateUrl: './organizer-update.component.html',
  styleUrls: ['./organizer-update.component.scss']
})
export class MyOrganizerUpdateComponent extends OrganizerUpdateComponent {

  constructor(protected organizerService: OrganizerService,
    private router: Router){
    super(organizerService);
  }

  onSave(organizer: Organizer) {
    this.organizerService.save(organizer).subscribe((_) => {
      this.router.navigate([Utils.paths.ORGANIZER.LIST]);
    });
  }
}
