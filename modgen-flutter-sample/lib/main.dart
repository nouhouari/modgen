import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modgensample/api/event-api.dart';
import 'package:modgensample/constants.dart';
import 'package:modgensample/cubit/event-cubit.dart';
import 'package:modgensample/screens/event_screen.dart';
import 'package:modgensample/state/event-state.dart';

void main() {
  String baseUrl = 'http://192.168.0.106:8081/';
  EventAPI api = EventAPI(baseUrl);
  EventCubit eventCubit =
      EventCubit(EventState(loading: LoadingStatus.unknown), api);
  runApp(MyApp(eventCubit));
}

class MyApp extends StatelessWidget {
  final EventCubit cubit;
  MyApp(this.cubit);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('Running with backend url=' + BACKEND_URL);
    return MaterialApp(
        title: 'Wasabih Event',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: BlocProvider(create: (context) => cubit, child: EventScreen()));
  }
}
