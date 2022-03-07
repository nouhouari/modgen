<div>
    <h4>Update a ${entity.name?lower_case}</h4>
    <app-${entity.name?lower_case}-edit (save)="onSave($event)" [data]="data" <#if entity.hasAnnotation("EXTENDABLE")>[schema]="schema"</#if>></app-${entity.name?lower_case}-edit>
</div>

