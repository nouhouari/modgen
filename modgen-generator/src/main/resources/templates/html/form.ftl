<!-- 
 @author Nourreddine HOUARI (nourreddine.houari@sicpa.com)
 @author Venkaiah Chowdary Koneru <VenkaiahChowdary.Koneru@sicpa.com>
 Generated by : ${generator}
 Version      : ${version}
 Date         : ${today}
-->
<div>
    <div class="panel panel-body">
<#list entity.attributes as attribute>
		<#if attribute.type == "Date">
		<div>
			<md-input-container>
               <label>${attribute.name?cap_first}</label>
               <md-datepicker ng-model="$parent.${entity.name?lower_case}Obj.${attribute.name?uncap_first}"></md-datepicker>
            </md-input-container>
         </div>   
         <#elseif attribute.type == "Boolean">
         <div>
          <md-checkbox ng-model="$parent.${entity.name?lower_case}Obj.${attribute.name?uncap_first}" aria-label="${attribute.name?cap_first}"></md-checkbox>
         </div>
         <#elseif attribute.enumerate>
      <!-- ENUM -->
      <div>
        <md-input-container>
          <label>${attribute.name}</label>
          <md-select ng-model="$parent.${entity.name?lower_case}Obj.${attribute.name?uncap_first}">
           <md-option><em>None</em></md-option>
           <md-option ng-repeat="${attribute.name} in ${attribute.name}_items" ng-value="{{${attribute.name}.label}}" ng-disabled="$index === 1">
            {{${attribute.name}.label}}
           </md-option>
          </md-select>
        </md-input-container>
      </div>
      <#elseif attribute.reference>
         <#if attribute.model.hasAnnotation("UDT")>
         	<div class="panel panel-default">
      			<div class="panel-heading">${attribute.name?cap_first}</div>
      				<div class="panel-body">
           <#list attribute.model.entity.attributes as udtAttribute>
           
           <#if udtAttribute.type == "Date">
		   <div>
              <label for="${udtAttribute.name?cap_first}Datetimepicker">${attribute.name?cap_first}.${udtAttribute.name?cap_first}</label>  
			  <div class='input-group date' id='${udtAttribute.name?cap_first}Datetimepicker'>
                <input type='text' class="form-control" placeholder="${udtAttribute.name?cap_first}" ng-model="$parent.${entity.name?lower_case}Obj.${attribute.name?uncap_first}DTO.${udtAttribute.name?uncap_first}" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
              </div>
              <script type="text/javascript">
               $(function () {
                $('#${udtAttribute.name?cap_first}Datetimepicker').datetimepicker();
               });
              </script>
            </div>
           <div>
              <label for="${udtAttribute.name?uncap_first}">${attribute.name?cap_first}.${udtAttribute.name?cap_first}</label>
              <input name="${udtAttribute.name?uncap_first}" placeholder="${udtAttribute.name?uncap_first}" ng-model="$parent.${entity.name?lower_case}Obj.${attribute.name?uncap_first}DTO.${udtAttribute.name?uncap_first}" class="form-control"/>
           </div>
           </#if>
		   </#list>
		   </div>
      	</#if> 
	    <#else> 
	    <#if !(attribute.hasAnnotation("UUID") || attribute.hasAnnotation("AUTO") || attribute.getMultiplicity()==-1 || attribute.hasAnnotation("ListHide"))>
	   <div>
            <#if attribute.hasAnnotation("PK")>
            <label name="${attribute.name?uncap_first}" ng-bind="$parent.${entity.name?lower_case}Obj.${attribute.name?uncap_first}"/>
            <#else>
            <md-input-container class="md-block" flex-sm>
              <label>${attribute.name?cap_first}</label>
              <input ng-model="$parent.${entity.name?lower_case}Obj.${attribute.name?uncap_first}">
            </md-input-container>
            </#if>	
         </div> 
        </#if> 
        </#if>
		
      </#list>
    </div>
</div>