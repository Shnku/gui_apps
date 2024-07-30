import 'package:flutter/material.dart';
import 'package:tictactoe/nome.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            brightness: Brightness.dark,
            primary: Colors.amber,
            primaryContainer: Colors.amberAccent,
            secondary: Colors.green,
          )),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
