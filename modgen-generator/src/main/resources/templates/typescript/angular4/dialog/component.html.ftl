<h2 mat-dialog-title>{{data.title}}</h2>
<mat-dialog-content class="mat-typography">
  <p>{{data.content}}</p>
</mat-dialog-content>
<mat-dialog-actions align="end">
  <button mat-button mat-dialog-close>Cancel</button>
  <button mat-button [mat-dialog-close]="true" cdkFocusInitial>OK</button>
</mat-dialog-actions>