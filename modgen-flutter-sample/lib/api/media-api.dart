import 'package:dio/dio.dart';
import 'package:modgensample/model/media.dart';

class MediaAPI {
  String _baseUrl;
  final Dio _dio = Dio();

  MediaAPI(this._baseUrl);

  // Get media for event
  Future<MediaPageResult> getMediaByEvenId(String eventId) async {
    Response pageData =
        await _dio.get(_baseUrl + 'media/search?eventId=$eventId');
    return MediaPageResult.fromJson(pageData.data);
  }

  // Get media for event
  Future<List<Media>> getMediaListByEvenId(String eventId) async {
    Response pageData =
        await _dio.get(_baseUrl + 'media/search?eventId=$eventId');
    return MediaPageResult.fromJson(pageData.data).content;
  }

  Future<Media> getFirstMediaByEvenId(String eventId) async {
    Response pageData =
        await _dio.get(_baseUrl + 'media/search?eventId=$eventId');
    return MediaPageResult.fromJson(pageData.data).content[0];
  }
}
