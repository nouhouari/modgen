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
 
class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    this.empty = json["empty"];
    this.sorted = json["sorted"];
    this.unsorted = json["unsorted"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["empty"] = this.empty;
    data["sorted"] = this.sorted;
    data["unsorted"] = this.unsorted;
    return data;
  }
}
