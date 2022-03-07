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
 * [2017] Nourreddine HOUARI SA
 * All Rights Reserved.
 */

import '${entity.name?lower_case}.dart';
import 'common/pageable.dart';
import 'common/sort.dart';

class ${entity.name}Page {
  List<${entity.name}>? content;
  bool? empty;
  bool? first;
  bool? last;
  int? number;
  int? numberOfElements;
  Pageable? pageable;
  int? size;
  Sort? sort;
  int? totalElements;
  int? totalPages;

  ${entity.name}Page(
      {this.content,
      this.empty,
      this.first,
      this.last,
      this.number,
      this.numberOfElements,
      this.pageable,
      this.size,
      this.sort,
      this.totalElements,
      this.totalPages});

  ${entity.name}Page.fromJson(Map<String, dynamic> json) {
    this.content = json["content"] == null
        ? null
        : (json["content"] as List).map((e) => ${entity.name}.fromJson(e)).toList();
    this.empty = json["empty"];
    this.first = json["first"];
    this.last = json["last"];
    this.number = json["number"];
    this.numberOfElements = json["numberOfElements"];
    this.pageable =
        json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]);
    this.size = json["size"];
    this.sort = json["sort"] == null ? null : Sort.fromJson(json["sort"]);
    this.totalElements = json["totalElements"];
    this.totalPages = json["totalPages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null)
      data["content"] = this.content?.map((e) => e.toJson()).toList();
    data["empty"] = this.empty;
    data["first"] = this.first;
    data["last"] = this.last;
    data["number"] = this.number;
    data["numberOfElements"] = this.numberOfElements;
    if (this.pageable != null) data["pageable"] = this.pageable?.toJson();
    data["size"] = this.size;
    if (this.sort != null) data["sort"] = this.sort?.toJson();
    data["totalElements"] = this.totalElements;
    data["totalPages"] = this.totalPages;
    return data;
  }
}
