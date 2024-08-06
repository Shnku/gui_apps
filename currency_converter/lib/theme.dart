import 'package:flutter/material.dart';

class Mytheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.purple,
      textTheme: ButtonTextTheme.primary,
      focusColor: Colors.blueAccent,
      hoverColor: Colors.amber,
    ),
    brightness: Brightness.light,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      labelStyle: TextStyle(color: Colors.black),
      prefixIconColor: Colors.black,
      suffixIconColor: Colors.redAccent,
      helperStyle: TextStyle(color: Colors.black),
      helperMaxLines: 2,
      contentPadding: EdgeInsets.all(10),
      isDense: true,
      filled: true,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.amberAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(6),
        backgroundColor: WidgetStatePropertyAll(Colors.purple),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll(
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amberAccent,
      textTheme: ButtonTextTheme.primary,
      focusColor: Colors.blueAccent,
      hoverColor: Colors.amber,
    ),
    brightness: Brightness.dark,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      labelStyle: TextStyle(color: Colors.white),
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.redAccent,
      helperStyle: TextStyle(color: Colors.white),
      helperMaxLines: 2,
      contentPadding: EdgeInsets.all(10),
      isDense: true,
      filled: true,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.amberAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.deepPurpleAccent),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        shadowColor: WidgetStatePropertyAll(Colors.blueAccent),
        elevation: WidgetStatePropertyAll(6),
        shape: WidgetStatePropertyAll(
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
    ),
  );

  // decoration: BoxDecoration(
  //   borderRadius: BorderRadius.circular(10),
  //   border: Border.all(color: Colors.black),
  //   color: c,
  //   boxShadow: [
  //     BoxShadow(
  //       color: Colors.grey.withOpacity(0.5),
  //       spreadRadius: 5,
  //       blurRadius: 7,
  //       offset: Offset(0, 5), // changes position of shadow
  //     ),
  //   ],
  // ),
}
