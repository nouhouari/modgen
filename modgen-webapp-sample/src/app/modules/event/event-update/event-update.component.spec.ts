import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MyEventUpdateComponent } from './event-update.component';

describe('EventUpdateComponent', () => {
  let component: MyEventUpdateComponent;
  let fixture: ComponentFixture<MyEventUpdateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MyEventUpdateComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MyEventUpdateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
