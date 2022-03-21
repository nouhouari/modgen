import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MyOrganizerComponent } from './organizer.component';

describe('OrganizerComponent', () => {
  let component: MyOrganizerComponent;
  let fixture: ComponentFixture<MyOrganizerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MyOrganizerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MyOrganizerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
