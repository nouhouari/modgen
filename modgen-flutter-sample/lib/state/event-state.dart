import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:modgensample/model/page.model.dart';

enum LoadingStatus { unknown, loading, loading_partial, success, error }

@JsonSerializable()
class EventState extends Equatable {
  EventPageResult? result;
  LoadingStatus? loading;
  bool? lastPage;
  List<Event>? allEvents;

  EventState({this.loading, this.result, this.lastPage, this.allEvents});

  EventState copyWith(
      {EventPageResult? result,
      LoadingStatus? loading,
      bool? lastPage,
      List<Event>? allEvents}) {
    return EventState(
        loading: loading,
        result: result,
        lastPage: lastPage,
        allEvents: allEvents);
  }

  @override
  List<Object?> get props => [result, loading];
}
