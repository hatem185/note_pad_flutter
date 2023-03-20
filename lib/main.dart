import 'package:flutter/material.dart';
import 'package:note_pad/pages/home_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(183, 122, 111, 1),
          primarySwatch: const MaterialColor(
            0xFFB77A6F,
            {
              50: Color.fromRGBO(183, 122, 111, .1),
              100: Color.fromRGBO(183, 122, 111, .2),
              200: Color.fromRGBO(183, 122, 111, .3),
              300: Color.fromRGBO(183, 122, 111, .4),
              400: Color.fromRGBO(183, 122, 111, .5),
              500: Color.fromRGBO(183, 122, 111, .6),
              600: Color.fromRGBO(183, 122, 111, .7),
              700: Color.fromRGBO(183, 122, 111, .8),
              800: Color.fromRGBO(183, 122, 111, .9),
              900: Color.fromRGBO(183, 122, 111, 1),
            },
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 57, 57, 57)),
      home: HomeScreen(title: 'Note Pad'),
      navigatorKey: navigatorKey,
    );
  }
}
