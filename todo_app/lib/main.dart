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
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSwatch(
      //     brightness: Brightness.dark,
      //     primarySwatch: Colors.amber,
      //     backgroundColor: Colors.purple,
      //     accentColor: Colors.amberAccent,
      //     cardColor: Colors.black,
      //   ),
      //   useMaterial3: true,
      // ),
      //better approach ...
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          surface: Colors.black,
          brightness: Brightness.dark,
          contrastLevel: BorderSide.strokeAlignOutside,
          secondary: Colors.deepPurple.shade500,
        ),
      ),
      home: const Mainpage(title: 'Your Tasks'),
      debugShowCheckedModeBanner: false,
    );
  }
}
