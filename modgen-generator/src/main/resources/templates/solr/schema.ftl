<schema name="solr_${entity.name?lower_case}" version="1.1">
<types>
 <fieldType name="string" class="solr.StrField"/>
 <fieldType name="text" class="solr.TextField">
   <analyzer>
     <tokenizer class="solr.StandardTokenizerFactory" />
   </analyzer>
 </fieldType>
 <fieldType name="coord" class="solr.LatLonType" subFieldSuffix="_coordinate" />
 <fieldType class="com.datastax.bdp.search.solr.core.types.TupleField" name="UDTField"/> 
 <fieldType name="float" class="solr.TrieFloatField" precisionStep="8" positionIncrementGap="0" />
 <fieldType name="double" class="solr.TrieDoubleField" precisionStep="8" positionIncrementGap="0" />
 <fieldType name="byte" class="solr.TrieIntField"/>
 <fieldType name="short" class="solr.TrieIntField"/>
 <fieldType name="int" class="solr.TrieIntField"/>
 <fieldType name="long" class="solr.TrieLongField"/>
 <fieldType name="date" class="solr.TrieDateField"/>
 <fieldType name="boolean" class="solr.BoolField"/>
</types>

<fields>

  <#list attributes as attribute>
    <#if attribute.reference && attribute.model.hasAnnotation("UDT")>
   <field name="${attribute.name?lower_case}" type="UDTField" indexed="true" stored="true"/>
      <#list attribute.model.attributes as udtAttribute>
      <#if udtAttribute.hasAnnotation("QUERY")>
   <field name="${attribute.name?lower_case}.${udtAttribute.name?lower_case}" type="${udtAttribute.type?lower_case}" indexed="true"  stored="true"/>
      </#if>
      </#list>
	<#elseif attribute.hasAnnotation("QUERY") || attribute.hasAnnotation("PK") || attribute.hasAnnotation("CC")>
	<#if attribute.type = "String" && attribute.location>
  <field name="${attribute.name?lower_case}" type="coord" indexed="true" stored="true" multiValued="false" />
  	<#elseif attribute.reference>
  	<#else>	
  <field name="${attribute.name?lower_case}" type="${attribute.type?lower_case}" indexed="true"  stored="true"/>
  </#if>
    </#if>
  </#list>
 
  <dynamicField name="*_coordinate" type="double" indexed="true" stored="false"/>
</fields>

<uniqueKey>(<#list primaryAttributes as attribute>${attribute.name?lower_case}<#sep>,</#list>)</uniqueKey>
</schema>

    