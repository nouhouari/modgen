class EventPageResult {
  EventPageResult({
    required this.content,
    required this.empty,
    required this.first,
    required this.last,
    required this.number,
    required this.numberOfElements,
    required this.pageable,
    required this.size,
    required this.sort,
    required this.totalElements,
    required this.totalPages,
  });
  late final List<Event> content;
  late final bool empty;
  late final bool first;
  late final bool last;
  late final int number;
  late final int numberOfElements;
  late final Pageable pageable;
  late final int size;
  late final Sort sort;
  late final int totalElements;
  late final int totalPages;

  EventPageResult.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => Event.fromJson(e)).toList();
    empty = json['empty'];
    first = json['first'];
    last = json['last'];
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    pageable = Pageable.fromJson(json['pageable']);
    size = json['size'];
    sort = Sort.fromJson(json['sort']);
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    _data['empty'] = empty;
    _data['first'] = first;
    _data['last'] = last;
    _data['number'] = number;
    _data['numberOfElements'] = numberOfElements;
    _data['pageable'] = pageable.toJson();
    _data['size'] = size;
    _data['sort'] = sort.toJson();
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    return _data;
  }
}

class Event {
  Event({
    this.createdBy,
    this.createdDate,
    this.description,
    this.extension,
    this.id,
    this.location,
    this.modifiedBy,
    this.modifiedDate,
    this.name,
  });
  late final String? createdBy;
  late final String? createdDate;
  late final String? description;
  late final Extension? extension;
  late final String? id;
  late final Location? location;
  late final String? modifiedBy;
  late final String? modifiedDate;
  late final String? name;

  Event.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    description = json['description'];
    extension = json['extenaion'] != null
        ? Extension.fromJson(json['extension'])
        : null;
    id = json['id'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdBy'] = createdBy;
    _data['createdDate'] = createdDate;
    _data['description'] = description;
    _data['extension'] = extension != null ? extension!.toJson() : null;
    _data['id'] = id;
    _data['location'] = location != null ? location!.toJson() : null;
    _data['modifiedBy'] = modifiedBy;
    _data['modifiedDate'] = modifiedDate;
    _data['name'] = name;
    return _data;
  }
}

class Extension {
  Extension({
    required this.extension,
  });
  late final Extension extension;

  Extension.fromJson(Map<String, dynamic> json) {
    extension = Extension.fromJson(json['extension']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['extension'] = extension.toJson();
    return _data;
  }
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });
  late final String type;
  late final List<double> coordinates;

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = List.castFrom<dynamic, double>(json['coordinates']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['coordinates'] = coordinates;
    return _data;
  }
}

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
