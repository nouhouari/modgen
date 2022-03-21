import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MyVenueEditComponent } from './venue-edit.component';

describe('VenueEditComponent', () => {
  let component: MyVenueEditComponent;
  let fixture: ComponentFixture<MyVenueEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MyVenueEditComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MyVenueEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
