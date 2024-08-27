import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/mainpage.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mydb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.amber,
          backgroundColor: Colors.purple,
          accentColor: Colors.amberAccent,
          cardColor: const Color.fromARGB(83, 51, 51, 51),
        ),
        useMaterial3: true,
      ),
      home: const Mainpage(title: 'Your Tasks'),
      debugShowCheckedModeBanner: false,
    );
  }
}
