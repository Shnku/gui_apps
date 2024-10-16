import 'dart:convert';
import 'dart:developer';

import 'package:currency_converter/currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

/// Data Provider................................
class DataProvider extends ChangeNotifier {
  late Map<String, dynamic> _data;
  String _display = "";
  String _toC = '';
  String _fromC = '';

  //getters .........
  get data => _data;
  get display => _display;
  get to => _toC;
  get form => _fromC;
  //setters...........
  set to(v) => _toC = v;
  set form(v) => _fromC = v;
  set display(val) => _display = val;

  //web fetching function.......
  Future<void> fetchData(String base) async {
    Response response = await get(Uri.parse(
      'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$base.min.json',
    ));
    if (response.statusCode == 200) {
      // log(response.body);
      _data = jsonDecode(response.body);
      log("\ndata is: in fetchData func ");
      log(_data[base]['inr'].toString());
    } else {
      throw ('Failed to fetch data');
    }
  }

//calculation function..........
  Future<void> doCalculate({
    required String to,
    required String form,
    double val = 1,
  }) async {
    _display = "calculating";
    _fromC = ctoc[form].toString().toLowerCase();
    _toC = ctoc[to].toString().toLowerCase();
    try {
      await fetchData(_fromC);
      _display =
          "$val ${_fromC.toUpperCase()}= ${(val * _data[_fromC][_toC]).toStringAsFixed(2)}${_toC.toUpperCase()}";
    } catch (error) {
      log('Error occurs ==: $error');
    }
    notifyListeners();
  }
}

/// Theme Provider............................
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; //init
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
