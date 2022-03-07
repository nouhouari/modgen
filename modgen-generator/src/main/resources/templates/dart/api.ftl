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
import 'package:dio/dio.dart';
import '../model/${entity.name?lower_case}-page.dart';
import '../model/${entity.name?lower_case}.dart';

class ${entity.name}Api {
  late String baseUrl;

  ${entity.name}Api(String backendUrl) {
    this.baseUrl = backendUrl + '/${entity.name?lower_case}';
  }	

  Future<${entity.name}Page> get${entity.name}() async {
    try {
      return Dio().get(baseUrl + '/quicksearch').then((value) {
        return ${entity.name}Page.fromJson(value.data);
      });
    } catch (e) {
      throw Exception('Error getting ${entity.name?lower_case}');
    }
  }
  
  Future<List<${entity.name}>> getAll${entity.name}s() async {
    try {
      return Dio().get<List>(baseUrl).then((value) {
        return (value.data as List).map((e) => ${entity.name}.fromJson(e)).toList();
      });
    } catch (e) {
      throw Exception('Error getting ${entity.name?lower_case}');
    }
  }
  
  <#if entity.hasAnnotation("SYNCH_SERVER")>
  Future<DateTime> getLastUpdateDate() async {
    try {
      return Dio().get<String>(baseUrl + '/latest').then((value) {
        String? replaceAll = value.data?.replaceAll("\"", '');
        if (replaceAll != null) {
          return DateTime.parse(replaceAll);
        }
        throw Exception('No latest update date available for ${entity.name?lower_case}');
      });
    } catch (e) {
      throw Exception('Error getting last update date for ${entity.name?lower_case}');
    }
  }

  Future<List<${entity.name}>> getAll${entity.name}UpdatedSince(DateTime since) {
    var queryParameters = {'latestDate': since.toIso8601String()};
    print('Query ${entity.name} from date: ' + queryParameters.toString());
    try {
      return Dio()
          .get(baseUrl + '/update', queryParameters: queryParameters)
          .then((value) {
        return (value.data as List).map((e) => ${entity.name}.fromJson(e)).toList();
      });
    } catch (e) {
      throw Exception('Error getting all ${entity.name?lower_case}');
    }
  }
  </#if>
  
  /// Save ${entity.name}
  Future<${entity.name}> save${entity.name}(${entity.name} ${entity.name?lower_case}) async {
    try {
      var post = await Dio().post(baseUrl, data: ${entity.name?lower_case});
      return ${entity.name}.fromJson(post.data);
    } catch (e) {
      throw Exception('Error saving ${entity.name}');
    }
  }
}