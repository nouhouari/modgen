import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Point } from 'geojson';
import { Organizer } from 'src/app/generated/shared/models/organizer.model';
import { OrganizerService } from 'src/app/generated/shared/modules/organizer/services/organizer.service';
import { Utils } from 'src/app/utils/utils';

@Component({
  selector: 'organizer-create',
  templateUrl: './organizer-create.component.html',
  styleUrls: ['./organizer-create.component.scss']
})
export class MyOrganizerCreateComponent implements OnInit {

  organizer: Organizer;
  isUpdate: boolean;
  location: Point;

  constructor(private router: Router,
              private organizerService: OrganizerService) { }

  ngOnInit(): void {
    this.isUpdate = !!history.state.data?.record;
    if (this.isUpdate) {
      this.organizer = history.state.data.record;
    } else {
      this.organizer = new Organizer();
    }
  }

  onSave(organizer: Organizer) {
    // organizer.location = this.location;
    organizer.id = null;
    this.organizerService.save(organizer).subscribe((organizer) => {
      this.router.navigate([Utils.paths.ORGANIZER.LIST]);
    });
  }

  onClickMap($organizer: Point) {
    this.location = $organizer;
  }
}
