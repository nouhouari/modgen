import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrganizerDetailsComponent } from './organizer-details.component';

describe('OrganizerDetailsComponent', () => {
  let component: OrganizerDetailsComponent;
  let fixture: ComponentFixture<OrganizerDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OrganizerDetailsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OrganizerDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
