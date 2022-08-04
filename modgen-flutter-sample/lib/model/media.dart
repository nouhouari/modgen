import 'package:modgensample/model/page.dart';

class Media {
  late String id;
  late String filePath;

  Media({required this.id, required this.filePath});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filePath'] = this.filePath;
    return data;
  }
}

class MediaPageResult {
  MediaPageResult({
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
  late List<Media> content;
  late bool empty;
  late bool first;
  late final bool last;
  late final int number;
  late final int numberOfElements;
  late final Pageable pageable;
  late final int size;
  late final Sort sort;
  late final int totalElements;
  late final int totalPages;

  MediaPageResult.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content'])
        .map<Media>((e) => Media.fromJson(e))
        .toList();
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
