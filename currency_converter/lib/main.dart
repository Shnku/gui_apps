import 'package:currency_converter/providermodel.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/homepage.dart';
import 'package:currency_converter/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, value, _) {
          return MaterialApp(
            themeMode: value.themeMode,
            title: 'Currency Converter',
            theme: Mytheme.lightTheme,
            darkTheme: Mytheme.darkTheme,
            home: const MyHomePage(title: 'Convert Currency'),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
