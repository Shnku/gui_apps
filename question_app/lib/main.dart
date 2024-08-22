import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/pages_or_routs/rootpage.dart';
import 'pages_or_routs/homepage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; //init
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners(); // Notify listeners to rebuild
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: themeProvider.themeMode,
        initialRoute: '/',
        routes: {
          '/': (context) => const Rootpage(),
          '/home': (context) => const MyHomePage(title: 'Questions'),
        },
      );
    });
  }
}
