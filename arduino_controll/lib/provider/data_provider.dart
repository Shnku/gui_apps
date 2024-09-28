import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier {
  String _baseUrl = '';
  bool _status = false;
  List<Map> _controllers = [
    {'id': 'LED', 'descrip': 'On Off LED'}
  ];

  //getters.........
  String get baseurl => _baseUrl;
  bool get status => _status;
  List get controllers => _controllers;

  //setters...........
  set baseyrl(val) {
    _baseUrl = val;
    notifyListeners();
  }

  set status(val) {
    _status = val;
    notifyListeners();
  }

  set controllers(val) => _controllers = val;
}
