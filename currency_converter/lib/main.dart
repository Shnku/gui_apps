import 'dart:async';

import 'package:currency_converter/providermodel.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/homepage.dart';
import 'package:currency_converter/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
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
            home: const MyHomePage(title: 'C O N V E R T - C U R R E N C Y'),
            debugShowCheckedModeBanner: false,
            themeAnimationDuration: const Duration(microseconds: 100),
            themeAnimationCurve: TreeSliver.defaultAnimationCurve,
          );
        },
      ),
    );
  }
}
