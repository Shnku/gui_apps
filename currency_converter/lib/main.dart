import 'package:flutter/material.dart';
import 'package:currency_converter/homepage.dart';
import 'package:currency_converter/theme.dart';

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
      title: 'Currency Converter',
      theme: Mytheme.lightTheme,
      darkTheme: Mytheme.darkTheme,
      home: const MyHomePage(title: 'Convert Currency'),
      debugShowCheckedModeBanner: false,
    );
  }
}
