<form [formGroup]="form" (keydown.enter)="onSearch()">
  <mat-form-field [style.width.%]="100" appearance="standard">
    <mat-label>{{title || 'Search ${entity.name}'}}</mat-label>
    <input matInput placeholder="${entity.name} keyword" formControlName="quickSearchQuery"/>
    <mat-icon matSuffix>search</mat-icon>
  </mat-form-field>
</form>  
