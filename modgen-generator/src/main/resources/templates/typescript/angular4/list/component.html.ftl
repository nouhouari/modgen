<div *ngxPermissionsOnly="['LIST_${entity.name?upper_case}']">
  
 <table mat-table [dataSource]="dataSource" class="mat-elevation-z">
 <#list entity.attributes as attribute>
  <#if !attribute.reference && !attribute.hasAnnotation('ListHide') && !attribute.hasAnnotation("PK")>
   <#if attribute.hasAnnotation("LOCATION")>
    <ng-container matColumnDef="${attribute.name}">
      <th mat-header-cell *matHeaderCellDef>${attribute.name?cap_first}<span (click)="sort('${attribute.name}', 'DESC')">&#8595;</span> <span (click)="sort('${attribute.name}', 'ASC')">&#8593;</span></th>
      <td mat-cell *matCellDef="let element">{{ element.${attribute.name}?.coordinates | json}}</td>
    </ng-container>
   <#elseif attribute.type == 'Date'>
    <ng-container matColumnDef="${attribute.name}">
      <th mat-header-cell *matHeaderCellDef>${attribute.name?cap_first}<span (click)="sort('${attribute.name}', 'DESC')">&#8595;</span> <span (click)="sort('${attribute.name}', 'ASC')">&#8593;</span></th>
      <td mat-cell *matCellDef="let element">{{ element.${attribute.name} | date: 'short'}}</td>
    </ng-container>
   <#else>
    <ng-container matColumnDef="${attribute.name}">
      <th mat-header-cell *matHeaderCellDef>${attribute.name?cap_first}<span (click)="sort('${attribute.name}', 'DESC')">&#8595;</span> <span (click)="sort('${attribute.name}', 'ASC')">&#8593;</span></th>
      <td mat-cell *matCellDef="let element">{{ element.${attribute.name} }}</td>
    </ng-container>
   </#if>
  </#if>
 </#list>
    <ng-container matColumnDef="action">
      <th mat-header-cell *matHeaderCellDef>Actions</th>
      <td mat-cell *matCellDef="let element; let i = index;">
        <button mat-icon-button [id]="'read-${entity.name?lower_case}-' + i" (click)="onView(element)" *ngxPermissionsOnly="['READ_${entity.name?upper_case}']">
          <mat-icon>visibility</mat-icon>
        </button>
        <button mat-icon-button [id]="'edit-${entity.name?lower_case}-' + i" color="primary" (click)="onUpdate(element)" *ngxPermissionsOnly="['SAVE_${entity.name?upper_case}']">
          <mat-icon>edit</mat-icon>
        </button>
        <button mat-icon-button color="warn" [id]="'delete-${entity.name?lower_case}-' + i" (click)="confirmRemoval(element.id)" *ngxPermissionsOnly="['DELETE_${entity.name?upper_case}']">
          <mat-icon>delete</mat-icon>
        </button>
        <ng-container *ngFor="let action of actions">
          <button mat-icon-button [id]="action.id + '-' + i" (click)="action.callBack(element)" *ngxPermissionsOnly="action.permissions">
            <mat-icon [color]="action.color">{{action.icon}}</mat-icon>
          </button>
        </ng-container>
      </td>
    </ng-container>

    <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
    <tr mat-row *matRowDef="let row; columns: displayedColumns"></tr>
  </table>

   <div class="row">
          <div class="col-12">
            <mat-paginator
            [pageSizeOptions]="pageSizeOptions"
            [length]="page?.totalElements"
            (page)="onChangePage($event)"
            ></mat-paginator>
          </div>
  </div>
 
</div>
