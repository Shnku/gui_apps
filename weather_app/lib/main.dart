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
      theme: ThemeData(
        useMaterial3: true,
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
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 57, 52, 126),
          shadows: [Shadow(color: Colors.black), Shadow(color: Colors.black)],
        ),
      ),
      home: const HomePage(title: 'weather_app'),
      debugShowCheckedModeBanner: false,
    );
  }
}
