import 'package:flutter/material.dart';
import 'package:weather_app/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
          useMaterial3: true,
          // primarySwatch:
          // const MaterialColor(2, {1: Colors.white70, 2: Colors.pink,3:Colors.black}),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            outlineBorder: BorderSide(
              color: Colors.white,
            ),
            labelStyle: TextStyle(color: Colors.white),
            prefixIconColor: Colors.white30,
          ),
          // iconTheme: const IconThemeData(
          //   color: Colors.blue,
          //   shadows: [Shadow(color: Colors.black), Shadow(color: Colors.black)],
          // ),
          cardTheme: const CardTheme(
            shadowColor: Colors.white10,
            clipBehavior: Clip.antiAlias,
          )),
      home: const HomePage(title: 'weather_app'),
      debugShowCheckedModeBanner: false,
    );
  }
}
