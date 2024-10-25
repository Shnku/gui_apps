import 'dart:convert';
import 'dart:developer';

import 'package:currency_converter/currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Data Provider................................
class DataProvider extends ChangeNotifier {
  late Map<String, dynamic> _data;
  String _display = "";
  String _toC = '';
  String _fromC = '';
  late double _whatValue;
  double _result = 0;
  List _barDatas = [];
  final List tags = ['usd', 'inr', 'eur', 'gbp', 'jpy'];

  //getters .........
  get data => _data;
  get display => _display;
  get to => _toC;
  get form => _fromC;
  get whatvalue => _whatValue;
  get barDatas => _barDatas;
  get result => _result;
  //setters...........
  // set to(v) => _toC = v;
  // set form(v) => _fromC = v;
  // set display(val) => _display = val;
  // set whatValue(val) => _whatValue = val;

  //web fetching function.......
  Future<void> fetchData(String base) async {
    Response response = await get(Uri.parse(
      'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$base.min.json',
    ));
    if (response.statusCode == 200) {
      _data = jsonDecode(response.body);
      log("\ndata is: in fetchData func");
      log(_data[base]['inr'].toString());
    } else {
      throw ('Failed to fetch data');
    }
  }

//calculation function..........
  Future<void> doCalculate({
    required String to,
    required String form,
    String val = '1',
  }) async {
    _fromC = ctoc[form].toString().toLowerCase();
    _toC = ctoc[to].toString().toLowerCase();
    _whatValue = double.parse(val);
    try {
      await fetchData(_fromC);
      setBarData();
      _result = whatvalue * _data[_fromC][_toC];
      _display =
          "$val ${_fromC.toUpperCase()} = ${_result.toStringAsFixed(2)} ${_toC.toUpperCase()}";
    } catch (error) {
      log('Error occurs ==: $error');
      rethrow;
    }
    notifyListeners();
  }

//set barchart data function..........
  void setBarData() async {
    _barDatas = [
      if (!tags.contains(_toC)) {'x': 0, 'id': _toC, 'y': _data[_fromC][_toC]},
      {'x': 1, 'id': tags[0], 'y': _data[_fromC][tags[0]]},
      {'x': 2, 'id': tags[1], 'y': _data[_fromC][tags[1]]},
      {'x': 3, 'id': tags[2], 'y': _data[_fromC][tags[2]]},
      {'x': 4, 'id': tags[3], 'y': _data[_fromC][tags[3]]},
      {'x': 5, 'id': tags[4], 'y': _data[_fromC][tags[4]]},
      if (!tags.contains(_fromC))
        {'x': 6, 'id': _toC, 'y': _data[_fromC][_fromC]},
    ];
    notifyListeners();
  }
}

/// Theme Provider............................
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; //init
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    loadTheme();
  }

  void toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', themeMode.toString());
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString('theme_mode');
    if (mode == ThemeMode.dark.toString()) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}

// class MyObject {
//   String countryname;
//   String countrycode;
//   String currency;
//   CountryFlag image;
//   MyObject.empty() : this('', '', '', CountryFlag.fromCountryCode(''));
//   MyObject(this.countryname, this.countrycode, this.currency, this.image);
// }

// MyObject from = MyObject("india", "in", "INR", CountryFlag.fromCountryCode('in'));
// MyObject to = MyObject("usa", "us", "USD", CountryFlag.fromCountryCode('us'));
// String display = '0';
