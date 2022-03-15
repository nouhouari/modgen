import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MyVenueComponent } from './venue.component';

describe('VenueComponent', () => {
  let component: MyVenueComponent;
  let fixture: ComponentFixture<MyVenueComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MyVenueComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MyVenueComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
