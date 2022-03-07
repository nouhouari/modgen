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

import 'sort.dart';

class Pageable {
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  Sort? sort;
  bool? unpaged;

  Pageable(
      {this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.sort,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    this.offset = json["offset"];
    this.pageNumber = json["pageNumber"];
    this.pageSize = json["pageSize"];
    this.paged = json["paged"];
    this.sort = json["sort"] == null ? null : Sort.fromJson(json["sort"]);
    this.unpaged = json["unpaged"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["offset"] = this.offset;
    data["pageNumber"] = this.pageNumber;
    data["pageSize"] = this.pageSize;
    data["paged"] = this.paged;
    if (this.sort != null) data["sort"] = this.sort?.toJson();
    data["unpaged"] = this.unpaged;
    return data;
  }
}
