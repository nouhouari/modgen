import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modgensample/api/event-api.dart';
import 'package:modgensample/model/page.model.dart';
import 'package:modgensample/state/event-state.dart';

class EventCubit extends Cubit<EventState> {
  final EventAPI api;
  EventCubit(EventState initialState, this.api) : super(initialState);

  Future<void> load() async {
    // Loading
    emit(state.copyWith(loading: LoadingStatus.loading));
    // Load
    try {
      EventPageResult result = await api.getEventPage();
      emit(state.copyWith(
          result: result,
          loading: LoadingStatus.success,
          allEvents: result.content,
          lastPage: result.last));
    } catch (e) {
      emit(state.copyWith(
          result: this.state.result!, loading: LoadingStatus.error));
    }
  }

  void loadNexPage() async {
    if (!state.result!.last) {
      print('Not last page, loading page ${state.result!.number + 1}');
      // Loading
      // emit(state.copyWith(
      //     loading: LoadingStatus.loading_partial,
      //     result: state.result,
      //     allEvents: state.allEvents,
      //     lastPage: state.lastPage));
      // Load
      try {
        EventPageResult result =
            await api.getEventPage(page: state.result!.number + 1);

        state.allEvents!.addAll(result.content);

        emit(state.copyWith(
            result: result,
            lastPage: result.last,
            allEvents: state.allEvents,
            loading: LoadingStatus.success));
      } catch (e) {
        emit(state.copyWith(loading: LoadingStatus.error));
      }
    } else {
      print('Last page ${state.result!.number}');
    }
  }
}
