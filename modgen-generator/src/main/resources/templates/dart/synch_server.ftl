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
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Nourreddine HOUARI.
 * 
 * [2021] Nourreddine HOUARI SA
 * All Rights Reserved.
 */
import 'dart:async';
import 'dart:convert';

import '../api/${entity.name?lower_case}.api.dart';
import '../model/dao/database.dart';
import 'package:drift/drift.dart' as drift;
<#if entity.hasAnnotation("SYNCH_SERVER")>
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import 'package:enum_to_string/enum_to_string.dart';
<#break>
</#if>
</#list>
</#if>

<#if entity.hasAnnotation("SYNCH_SERVER")>
/// ${entity.name} server synchronisation
start${entity.name}ServerSynching(int seconds, AppDatabase db, ${entity.name}Api api) async {

  Timer.periodic(Duration(seconds: seconds), (time) {
    api.getLastUpdateDate().then((remoteLastUpdateDate) {
    
      if (remoteLastUpdateDate != null) {
        // Check the local update time and remote for equality
        db.get${entity.name}LastUpdateDate().then((localLastUpdateDate) {
          if (localLastUpdateDate == null) {
            // If no data locally, fetch all ${entity.name?lower_case}s
            api.getAll${entity.name}s().then((${entity.name?lower_case}s) {
              ${entity.name?lower_case}s.forEach((element) {
                db.add${entity.name}(new ${entity.name}Companion(
                    lastUpdateTimestamp:
                        drift.Value(element.modifiedDate!),
                    <#list entity.attributes as attribute>
                    <#if !attribute.reference>
                    <#if attribute.enumerate>
                    //Enum
                    ${attribute.name}: (element.${attribute.name} != null)
                        ? drift.Value(EnumToString.convertToString(
                            element.${attribute.name}))
                        : drift.Value.absent()<#sep>,</#sep>
                    <#elseif attribute.type == 'String' && attribute.hasAnnotation('LOCATION')>
                    ${attribute.name}: (element.${attribute.name} != null)?drift.Value(jsonEncode(element.${attribute.name})):drift.Value.absent()<#sep>,</#sep>    
                    <#else>
                    ${attribute.name}: drift.Value(element.${attribute.name})<#sep>,</#sep>
                    </#if>
                    <#else>
                    // ${attribute.name}
                    </#if>
                    </#list>
                    ));
              });
            });
          } else {
            // Local and remote not null. Need to compare the local and remote date
            if (remoteLastUpdateDate.millisecondsSinceEpoch >
                localLastUpdateDate.lastUpdateTimestamp) {
              // Get all the ${entity.name?lower_case}s updated after the local last update
              api
                  .getAll${entity.name}UpdatedSince(
                      DateTime.fromMillisecondsSinceEpoch(
                          localLastUpdateDate.lastUpdateTimestamp, isUtc: true))
                  .then((${entity.name?lower_case}s) {
                ${entity.name?lower_case}s.forEach((element) {
                  db.add${entity.name}(new ${entity.name}Companion(
                      lastUpdateTimestamp:
                        drift.Value(element.modifiedDate!),
                    <#list entity.attributes as attribute>
                    <#if !attribute.reference>
                    <#if attribute.enumerate>
                    //Enum
                    ${attribute.name}: (element.${attribute.name} != null)
                        ? drift.Value(EnumToString.convertToString(
                            element.${attribute.name}))
                        : drift.Value.absent()<#sep>,</#sep>
                    <#elseif attribute.type == 'String' && attribute.hasAnnotation('LOCATION')>
                    ${attribute.name}: (element.${attribute.name} != null)?drift.Value(jsonEncode(element.${attribute.name})):drift.Value.absent()<#sep>,</#sep>    
                    <#else>
                    ${attribute.name}: drift.Value(element.${attribute.name})<#sep>,</#sep>
                    </#if>
                    <#else>
                    // ${attribute.name}
                    </#if>
                    </#list>
                      ));
                });
              });
            } else {
              //print('Nothing to update');
            }
          }
        });
      }
    });
  });
}
</#if>

<#if entity.hasAnnotation("SYNCH_CLIENT")>
/// ${entity.name} client synchronisation
start${entity.name}ClientSynching(int seconds, AppDatabase db, ${entity.name}Api api) async {
  
  Timer.periodic(Duration(seconds: seconds), (timer) {
    db.getAll${entity.name}WithRelationsNotSynchronized().first.then((value) => {
          value.forEach((${entity.name?lower_case}) {
            api.save${entity.name}(${entity.name?lower_case}).then(
                (value) => {
                      db.update${entity.name}(${entity.name}Companion.insert(
                          id: drift.Value(${entity.name?lower_case}.${entity.primaryAttribute.name}),
                          lastUpdateTimestamp:
                              DateTime.now().millisecondsSinceEpoch,
                          synchronized: const drift.Value(true)))
                    },
                onError: (e) => print('Error synching ${entity.name}.'));
          })
        });
  });
}

</#if>