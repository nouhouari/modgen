import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modgensample/api/event-api.dart';
import 'package:modgensample/constants.dart';
import 'package:modgensample/cubit/event-cubit.dart';
import 'package:modgensample/screens/event_screen.dart';
import 'package:modgensample/screens/onboarding.dart';
import 'package:modgensample/state/event-state.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:modgensample/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
final String initKey = 'initScreen';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Check if first time
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt(initKey);
  await preferences.setInt(initKey, 1).then((value) => print);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late EventCubit cubit;

  void initialization() async {
    String baseUrl = BACKEND_URL;
    EventAPI api = EventAPI(baseUrl);
    cubit = EventCubit(EventState(loading: LoadingStatus.unknown), api);
    // Wait and stop splashscreen
    await Future.delayed(const Duration(milliseconds: 500));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('Running with backend url=' + BACKEND_URL);
    return MaterialApp(
        title: 'Wasabih',
        theme: myTheme,
        initialRoute: (initScreen == 0 || initScreen == null) ? '/' : '/event',
        routes: {
          '/': (context) => const OnBoardingScreen(),
          '/event': (context) =>
              BlocProvider(create: (context) => cubit, child: EventScreen())
        });
  }
}
