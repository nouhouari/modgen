class Pageable {
  Pageable({
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.paged,
    required this.sort,
    required this.unpaged,
  });
  late final int offset;
  late final int pageNumber;
  late final int pageSize;
  late final bool paged;
  late final Sort sort;
  late final bool unpaged;

  Pageable.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    sort = Sort.fromJson(json['sort']);
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offset'] = offset;
    _data['pageNumber'] = pageNumber;
    _data['pageSize'] = pageSize;
    _data['paged'] = paged;
    _data['sort'] = sort.toJson();
    _data['unpaged'] = unpaged;
    return _data;
  }
}

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });
  late final bool empty;
  late final bool sorted;
  late final bool unsorted;

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['sorted'] = sorted;
    _data['unsorted'] = unsorted;
    return _data;
  }
}
