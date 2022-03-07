/*
 * 
 * Nourreddine HOUARI CONFIDENTIAL
 * 
 * All information contained herein is, and remains
 * the property of Nourreddine HOUARI and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Nourreddine HOUARI
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or re${entity.name?lower_case}ion of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Nourreddine HOUARI.
 * 
 * [2021] Nourreddine HOUARI SA
 * All Rights Reserved.
 */
/// This database can be extended
/// class CustomDB extends AppDatabase {
///
/// CustomDB() : super(_openConnection());
/// ...
/// @override
/// int get schemaVersion => 1;
///
/// @override
/// MigrationStrategy get migration => MigrationStrategy(
///    onUpgrade: (m, from, to) async {},); 
/// } 
///
/// LazyDatabase _openConnection() {
///  // the LazyDatabase util lets us find the right location for the file async.
///  return LazyDatabase(() async {
///    // put the database file, called db.sqlite here, into the documents folder
///    // for your app.
///    final dbFolder = await getApplicationDocumentsDirectory();
///    final file = File(p.join(dbFolder.path, 'db.sqlite'));
///    return VmDatabase(file);
///  });
/// }

import 'dart:convert';
import 'package:moor/moor.dart';
import 'package:enum_to_string/enum_to_string.dart';
import '../../model/common/extension.dart';
import '../../model/${entity.name?lower_case}.dart' as ${entity.name?lower_case}DTO;
<#list entities as entity>
import '../../model/${entity.name?lower_case}.dart' as ${entity.name?lower_case}DTO;
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import '../../model/${attribute.type?lower_case}.dart';
</#if>
</#list>
</#list>
<#function hasAtLeastOneRelation entity>
<#list entity.attributes as attribute>
<#if attribute.reference && (attribute.multiplicity==1 && attribute.oppositeMultiplicity==-1 || attribute.multiplicity==1 && attribute.oppositeMultiplicity==1)>
<#return true>
</#if>
</#list>
<#return false>
</#function>

part 'database.g.dart';

<#list entities as entity>
/// ${entity.name} database model
class ${entity.name} extends Table {
 <#list entity.attributes as attribute>
 <#if attribute.type == "String" || attribute.type == "Character" || attribute.enumerate>
  TextColumn get ${attribute.name} => text().nullable()();	   
  <#elseif attribute.type == "Date">
  DateTimeColumn get ${attribute.name} => dateTime().nullable()();
  <#elseif attribute.type == "Byte" 
	   || attribute.type == "Short" 
	   || attribute.type == "Integer" 
	   || attribute.type == "Long">
  IntColumn get ${attribute.name} => integer()();	   
  <#elseif attribute.type == "Float"
	   || attribute.type == "Double">
  RealColumn get ${attribute.name} => real()(); 	   
  <#elseif attribute.type == "Boolean">	   
  BoolColumn get ${attribute.name} => boolean()();
  <#elseif attribute.reference && attribute.oppositeMultiplicity==1>
    <#if attribute.model.primaryAttribute.type == 'String'>
  TextColumn get ${attribute.name}${attribute.model.primaryAttribute.name?cap_first} => text().nullable()();
    <#elseif attribute.model.primaryAttribute.type == 'Integer'>
  IntColumn get ${attribute.name}${attribute.model.primaryAttribute.name?cap_first} => integer()();	
    <#else>
    // Not supported type [${attribute.model.primaryAttribute.type}] for primary key ${attribute.model.primaryAttribute.name}
    </#if>   	   	   	   	   	   
  </#if>	   
  </#list>
  <#if entity.hasAnnotation("SYNCH_CLIENT")>
  BoolColumn get synchronized => boolean().withDefault(Constant(false))();
  </#if>
  <#if entity.hasAnnotation("EXTENDABLE")>
  TextColumn get extension => text().nullable()();
  </#if>
  IntColumn get lastUpdateTimestamp => integer()(); 
  Set<Column> get primaryKey => {${entity.primaryAttribute.name}};
}

</#list>
@UseMoor(tables: [<#list entities as entity>${entity.name}<#sep>,</#sep></#list>])
class AppDatabase extends _$AppDatabase {
  AppDatabase(LazyDatabase db) : super(db);

  <#list entities as entity>
  /// Get all the ${entity.name?lower_case}s
  Future<List<${entity.name}Data>> getAll${entity.name}s() => select(${entity.name?lower_case}).get();

  <#if entity.hasAnnotation("SYNCH_CLIENT")>
  /// Get all the not synchronized ${entity.name?lower_case}s
  Future<List<${entity.name}Data>> getAllNonSynch${entity.name}s() =>
      (select(${entity.name?lower_case})..where((t) => t.synchronized.equals(false)))
          .get();
          
  </#if>
  /// Watch the list of ${entity.name?lower_case}
  Stream<List<${entity.name}Data>> watch${entity.name}() {
    return select(${entity.name?lower_case}).watch();
  }

  /// Create new ${entity.name?lower_case} and return inserted entry
  Future<${entity.name}Data> create${entity.name}(${entity.name}Companion entry) {
    return into(${entity.name?lower_case}).insertReturning(entry);
  }
  
  /// Add new ${entity.name?lower_case}.
  Future<int> add${entity.name}(${entity.name}Companion entry) {
    return into(${entity.name?lower_case}).insertOnConflictUpdate(entry);
  }
  
  /// Get the ${entity.name?lower_case} by ${entity.primaryAttribute.name?lower_case}
  Future<${entity.name}Data?> get${entity.name}ByPrimaryKey(${entity.primaryAttribute.type} ${entity.primaryAttribute.name}) {
    return (select(${entity.name?lower_case})..where((t) => t.id.equals(${entity.primaryAttribute.name}))).getSingle();
  }

  /// delete the ${entity.name?lower_case} by ${entity.primaryAttribute.name?lower_case}
  Future delete${entity.name}ByPrimaryKey(${entity.primaryAttribute.type} ${entity.primaryAttribute.name}) {
    return (delete(${entity.name?lower_case})..where((t) => t.id.equals(${entity.primaryAttribute.name}))).go();
  }

  /// Update a ${entity.name?lower_case}
  Future updateFull${entity.name}(${entity.name}Data entry) {
    return update(${entity.name?lower_case}).replace(entry);
  }
  
  Future update${entity.name}(Insertable<${entity.name}Data> the${entity.name}) => 
    update(${entity.name?lower_case}).replace(the${entity.name});

  /// Get last update date
  Future<${entity.name}Data?> get${entity.name}LastUpdateDate() {
    SimpleSelectStatement<$${entity.name}Table, ${entity.name}Data> simpleSelectStatement =
        select(${entity.name?lower_case})
          ..orderBy([(t) => OrderingTerm.desc(t.lastUpdateTimestamp)])
          ..limit(1);

    return simpleSelectStatement.getSingleOrNull();
  }
  <#assign relation = hasAtLeastOneRelation(entity)>
  /// Fetch all with relations ==> <#if relation>true<#else>false</#if>
  Stream<List<${entity.name?lower_case}DTO.${entity.name}>> getAll${entity.name}WithRelations() =>
      (select(${entity.name?lower_case}))
          <#list entity.attributes as attribute>
          <#if attribute.reference && attribute.multiplicity == 1>
          .join([leftOuterJoin(${attribute.model.name?lower_case}, ${attribute.model.name?lower_case}.${attribute.model.primaryAttribute.name}.equalsExp(${entity.name?lower_case}.${attribute.model.name?lower_case}${attribute.model.primaryAttribute.name?cap_first}))])
          </#if>
          </#list>
          .watch()
          .map(
            (rows) => rows.map(
              (row) {
                return ${entity.name?lower_case}DTO.${entity.name}(
                    <#list entity.attributes as attribute>
                    //${attribute.name} ${attribute.multiplicity} ${attribute.oppositeMultiplicity} 
                    <#if attribute.reference && attribute.multiplicity == 1>
                    ${attribute.name}: ${attribute.type?lower_case}DTO.${attribute.type}(
                    <#assign childModel=attribute.model>
                    <#if childModel.hasAnnotation("EXTENDABLE")>
					// Add extension
					extension: (row.readTable(${childModel.name?lower_case}).extension != null)?Extension.fromJson(jsonDecode(row.readTable(${childModel.name?lower_case}).extension!)):null,
					</#if>
                    modifiedDate: row.readTable(${childModel.name?lower_case}).lastUpdateTimestamp,
                    	<#list attribute.model.attributes as childAttribute>
                    	<#if !childAttribute.reference>
                    	  <#if childAttribute.enumerate>
                    	  ${childAttribute.name}: (row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name} != null)?
                         EnumToString.fromString(${childAttribute.type}.values, 
                         row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name}!):null<#sep>,<#sep>
                    	  <#elseif childAttribute.type == 'String' && childAttribute.hasAnnotation('LOCATION')>
                    	   ${childAttribute.name}: (row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name} != null)?jsonDecode(row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name}!):{}<#sep>,<#sep>
                    	  <#else>
                    	  ${childAttribute.name}: row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name}<#sep>,<#sep>
                    	  </#if>
                    	</#if>
                    	</#list>
                    )<#sep>,<#sep>
                     <#elseif attribute.type == 'String' && attribute.hasAnnotation('LOCATION')>
                     ${attribute.name}: (row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name} != null)?
                       jsonDecode(row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name}!):{}<#sep>,<#sep>
                     <#elseif attribute.enumerate>
                     ${attribute.name}: (row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name} != null)?
                       EnumToString.fromString(${attribute.type}.values, 
                       row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name}!):null<#sep>,<#sep>
                     <#elseif !attribute.reference>
                    ${attribute.name}: row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name}<#sep>,<#sep>
                    </#if>
                    </#list>
                    <#if entity.hasAnnotation("EXTENDABLE")>
                    
                   ,extension: (row<#if relation>.readTable(${entity.name?lower_case})</#if>.extension != null)?Extension.fromJson(jsonDecode(row<#if relation>.readTable(${entity.name?lower_case})</#if>.extension!)):null
                    </#if>
                    );
              },
            ).toList(),
          );
          
    /// Fetch all with relations ==> <#if relation>true<#else>false</#if>
    Stream<List<${entity.name?lower_case}DTO.${entity.name}>> getAll${entity.name}WithRelationsNotSynchronized() =>
      (select(${entity.name?lower_case})
          <#if entity.hasAnnotation("SYNCH_CLIENT")>
            ..where((tbl) {
              return tbl.synchronized.equals(false);
            })
          </#if>)
          
          <#list entity.attributes as attribute>
          <#if attribute.reference && attribute.multiplicity == 1>
          .join([leftOuterJoin(${attribute.model.name?lower_case}, ${attribute.model.name?lower_case}.${attribute.model.primaryAttribute.name}.equalsExp(${entity.name?lower_case}.${attribute.model.name?lower_case}${attribute.model.primaryAttribute.name?cap_first}))])
          </#if>
          </#list>
          .watch()
          .map(
            (rows) => rows.map(
              (row) {
                return ${entity.name?lower_case}DTO.${entity.name}(
                    <#list entity.attributes as attribute>
                    //${attribute.name} ${attribute.multiplicity} ${attribute.oppositeMultiplicity} 
                    <#if attribute.reference && attribute.multiplicity == 1>
                    ${attribute.name}: ${attribute.type?lower_case}DTO.${attribute.type}(
                    <#assign childModel=attribute.model>
					<#if childModel.hasAnnotation("EXTENDABLE")>
					// Add extension
					extension: (row.readTable(${childModel.name?lower_case}).extension != null)?Extension.fromJson(jsonDecode(row.readTable(${childModel.name?lower_case}).extension!)):null,
					</#if>                    
                    modifiedDate: row.readTable(${childModel.name?lower_case}).lastUpdateTimestamp,
                    	<#list attribute.model.attributes as childAttribute>
                    	<#if !childAttribute.reference>
                    	  <#if childAttribute.enumerate>
                    	  ${childAttribute.name}: (row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name} != null)?
                         EnumToString.fromString(${childAttribute.type}.values, row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name}!):null<#sep>,<#sep>
                    	  <#elseif childAttribute.type=='String' && childAttribute.hasAnnotation('LOCATION')>
                    	  ${childAttribute.name}: (row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name} != null)?jsonDecode(row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name}!):{}<#sep>,<#sep>
                    	  <#else>
                    	  ${childAttribute.name}: row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name}<#sep>,<#sep>
                    	  </#if>
                    	</#if>
                    	</#list>
                    )<#sep>,<#sep>
                     <#elseif attribute.type == 'String' && attribute.hasAnnotation('LOCATION')>
                     ${attribute.name}: (row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name} != null)?
                       jsonDecode(row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name}!):{}<#sep>,<#sep>
                     <#elseif attribute.enumerate>
                     ${attribute.name}: (row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name} != null)?
                       EnumToString.fromString(${attribute.type}.values, 
                       row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name}!):null<#sep>,<#sep>
                     <#elseif attribute.type=='String' && attribute.hasAnnotation('LOCATION')>
                     //${childAttribute.name}: (row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name} != null)?row<#if relation>.readTable(${childModel.name?lower_case})</#if>.${childAttribute.name}:{}<#sep>,<#sep>	    
                     <#elseif !attribute.reference>
                    ${attribute.name}: row<#if relation>.readTable(${entity.name?lower_case})</#if>.${attribute.name}<#sep>,<#sep>
                    </#if>
                    </#list>
                    <#if entity.hasAnnotation("EXTENDABLE")>
                    
                   ,extension: (row<#if relation>.readTable(${entity.name?lower_case})</#if>.extension != null)?Extension.fromJson(jsonDecode(row<#if relation>.readTable(${entity.name?lower_case})</#if>.extension!)):null
                    </#if>
                    );
              },
            ).toList(),
          );       
          
  </#list>
  @override
  int get schemaVersion => throw UnimplementedError();

}
