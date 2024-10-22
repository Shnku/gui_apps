import 'package:flutter/material.dart';

class Mytheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.purple,
      textTheme: ButtonTextTheme.primary,
      focusColor: Colors.blueAccent,
      hoverColor: Colors.amber,
    ),
    brightness: Brightness.light,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black38),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black38),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black38),
      ),
      labelStyle: const TextStyle(color: Colors.black),
      prefixIconColor: Colors.black,
      suffixIconColor: Colors.redAccent,
      helperStyle: const TextStyle(color: Colors.black),
      helperMaxLines: 2,
      contentPadding: const EdgeInsets.all(10),
      isDense: true,
      filled: true,
      fillColor: Colors.white.withOpacity(0.5),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.amberAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(fontSize: 20, color: Colors.black54)),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        maximumSize: Mytheme.darkTheme.dropdownMenuTheme.menuStyle?.maximumSize,
        shape: Mytheme.darkTheme.dropdownMenuTheme.menuStyle?.shape,
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(235, 164, 184, 253),
        ),
        elevation: Mytheme.darkTheme.dropdownMenuTheme.menuStyle?.elevation,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amberAccent,
      textTheme: ButtonTextTheme.primary,
      focusColor: Colors.blueAccent,
      hoverColor: Colors.amber,
    ),
    brightness: Brightness.dark,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white30),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white30),
      ),
      labelStyle: const TextStyle(color: Colors.white),
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.redAccent,
      helperStyle: const TextStyle(color: Colors.white),
      helperMaxLines: 2,
      contentPadding: const EdgeInsets.all(10),
      isDense: true,
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.amberAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.21),
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(fontSize: 20, color: Colors.white70)),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        maximumSize: const WidgetStatePropertyAll(Size(140, 600)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(245, 40, 19, 86),
        ),
        elevation: const WidgetStatePropertyAll(80),
      ),
    ),
  );

  static BoxDecoration boxdeco = BoxDecoration(
    color: Colors.white12,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.white.withOpacity(0.4),
      width: 1,
    ),
  );
}
