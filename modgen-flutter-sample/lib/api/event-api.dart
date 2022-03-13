import 'package:dio/dio.dart';
import 'package:modgensample/model/page.model.dart';

class EventAPI {
  String _baseUrl;
  final Dio _dio = Dio();

  EventAPI(this._baseUrl);

  // Get event page
  Future<EventPageResult> getEventPage({int page = 0, int size = 10}) async {
    Response pageData =
        await _dio.get(_baseUrl + 'event/search?page=$page&size=$size');
    return EventPageResult.fromJson(pageData.data);
  }

  // Get the event from its identifier
  Future<Event> getEventById(String eventId) async {
    Response pageData = await _dio.get(_baseUrl + 'event/$eventId');
    return Event.fromJson(pageData.data);
  }
}
