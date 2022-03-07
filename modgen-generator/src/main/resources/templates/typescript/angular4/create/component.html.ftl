<div>
    <h4>Create a new ${entity.name?lower_case}</h4>
    <app-${entity.name?lower_case}-edit (save)="onSave($event)" <#if entity.hasAnnotation("EXTENDABLE")>[schema]="schema"</#if>></app-${entity.name?lower_case}-edit>
</div>