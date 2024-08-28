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
          seedColor: const Color.fromARGB(255, 182, 252, 20),
          surface: Colors.black,
          brightness: Brightness.dark,
          contrastLevel: BorderSide.strokeAlignOutside,
          secondary: const Color.fromARGB(255, 136, 184, 47),
          // Add text colors
          onSurface: const Color.fromARGB(255, 220, 240, 184),
          onSurfaceVariant: const Color.fromARGB(255, 170, 204, 77),
        ),
      ),
      home: const Mainpage(title: 'T o - D o'),
      debugShowCheckedModeBanner: false,
    );
  }
}
