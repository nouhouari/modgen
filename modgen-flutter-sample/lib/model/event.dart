class EventPageResult {
  EventPageResult({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.numberOfElements,
    required this.number,
    required this.size,
    required this.first,
    required this.sort,
    required this.empty,
  });
  late final List<Event> content;
  late final Pageable pageable;
  late final int totalPages;
  late final int totalElements;
  late final bool last;
  late final int numberOfElements;
  late final int number;
  late final int size;
  late final bool first;
  late final Sort sort;
  late final bool empty;

  EventPageResult.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => Event.fromJson(e)).toList();
    pageable = Pageable.fromJson(json['pageable']);
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    numberOfElements = json['numberOfElements'];
    number = json['number'];
    size = json['size'];
    first = json['first'];
    sort = Sort.fromJson(json['sort']);
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['last'] = last;
    _data['numberOfElements'] = numberOfElements;
    _data['number'] = number;
    _data['size'] = size;
    _data['first'] = first;
    _data['sort'] = sort.toJson();
    _data['empty'] = empty;
    return _data;
  }
}

class Event {
  Event({
    this.categoryEvent,
    required this.venueEvent,
    required this.organizerEvent,
    required this.createdDate,
    required this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.extension,
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.timeZone,
    required this.format,
    required this.active,
  });
  late final Null categoryEvent;
  late final VenueEvent venueEvent;
  late final OrganizerEvent organizerEvent;
  late final String createdDate;
  late final String modifiedDate;
  late final Null createdBy;
  late final Null modifiedBy;
  late final Null extension;
  late final String id;
  late final String name;
  late final String description;
  late final String startDate;
  late final String endDate;
  late final String type;
  late final String timeZone;
  late final String format;
  late final bool active;

  Event.fromJson(Map<String, dynamic> json) {
    categoryEvent = null;
    venueEvent = VenueEvent.fromJson(json['venue_event']);
    organizerEvent = OrganizerEvent.fromJson(json['organizer_event']);
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    createdBy = null;
    modifiedBy = null;
    extension = null;
    id = json['id'];
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    type = json['type'];
    timeZone = json['timeZone'];
    format = json['format'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_event'] = categoryEvent;
    _data['venue_event'] = venueEvent.toJson();
    _data['organizer_event'] = organizerEvent.toJson();
    _data['createdDate'] = createdDate;
    _data['modifiedDate'] = modifiedDate;
    _data['createdBy'] = createdBy;
    _data['modifiedBy'] = modifiedBy;
    _data['extension'] = extension;
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['type'] = type;
    _data['timeZone'] = timeZone;
    _data['format'] = format;
    _data['active'] = active;
    return _data;
  }
}

class VenueEvent {
  VenueEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.contactNumber,
    required this.contactEmail,
    required this.website,
    this.event,
    required this.location,
  });
  late final String id;
  late final String name;
  late final String description;
  late final String address;
  late final String city;
  late final String country;
  late final String zipCode;
  late final String contactNumber;
  late final String contactEmail;
  late final String website;
  late final Null event;
  late final Location location;

  VenueEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    zipCode = json['zipCode'];
    contactNumber = json['contactNumber'];
    contactEmail = json['contactEmail'];
    website = json['website'];
    event = null;
    location = Location.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['address'] = address;
    _data['city'] = city;
    _data['country'] = country;
    _data['zipCode'] = zipCode;
    _data['contactNumber'] = contactNumber;
    _data['contactEmail'] = contactEmail;
    _data['website'] = website;
    _data['event'] = event;
    _data['location'] = location.toJson();
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

class OrganizerEvent {
  OrganizerEvent({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.event,
    required this.picture,
    this.aboutme,
  });
  late final String id;
  late final String firstName;
  late final String lastName;
  late final Null event;
  late final String picture;
  late final Null aboutme;

  OrganizerEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    event = null;
    picture = json['picture'];
    aboutme = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['event'] = event;
    _data['picture'] = picture;
    _data['aboutme'] = aboutme;
    return _data;
  }
}

class Pageable {
  Pageable({
    required this.sort,
    required this.pageSize,
    required this.pageNumber,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });
  late final Sort sort;
  late final int pageSize;
  late final int pageNumber;
  late final int offset;
  late final bool paged;
  late final bool unpaged;

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = Sort.fromJson(json['sort']);
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort.toJson();
    _data['pageSize'] = pageSize;
    _data['pageNumber'] = pageNumber;
    _data['offset'] = offset;
    _data['paged'] = paged;
    _data['unpaged'] = unpaged;
    return _data;
  }
}

class Sort {
  Sort({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });
  late final bool unsorted;
  late final bool sorted;
  late final bool empty;

  Sort.fromJson(Map<String, dynamic> json) {
    unsorted = json['unsorted'];
    sorted = json['sorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unsorted'] = unsorted;
    _data['sorted'] = sorted;
    _data['empty'] = empty;
    return _data;
  }
}
