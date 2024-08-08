import 'dart:convert';
import 'package:http/http.dart';

class GettedData {
  String search;
  String? temp;
  String? humidity;
  String? feelsLike;
  String? pressure;
  String? cityData;
  Map? wind;
  Map? conditions;
  // Map? json;

  GettedData({required this.search});
  GettedData.all(
      {this.conditions,
      this.feelsLike,
      this.humidity,
      required this.search,
      this.pressure,
      this.temp,
      this.cityData});
  // GettedData.fromJson(Map<String, dynamic> json) {
  //   temp = json['main']['temp'];
  //   feelsLike = json['main']['feels_like'];
  //   humidity = json['main']['humidity'];
  //   pressure = json['main']['pressure'];
  //   conditions = json['weather'][0];
  // }

  Future<void> getData() async {
    Response response = await get(Uri.parse(
        ("https://api.openweathermap.org/data/2.5/weather?units=metric&q=$search&appid=d46e83574c1f494bf7e5b93004ab9cd6")));

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      print(data);
      print("coiedfwedw\n");
      temp = data['main']['temp'].toString();
      feelsLike = data['main']['feels_like'].toString();
      humidity = data['main']['humidity'].toString();
      pressure = data['main']['pressure'].toString();
      conditions = data['weather'][0];
      cityData = data['name'] + ',' + data['sys']['country'];
      wind = data['wind'];
    } else {
      temp = feelsLike = humidity = pressure = "no data";
      conditions = wind = {'key': 'no datra'};
      print("no search found/ error fetching");
      throw Exception('Failed to load user');
    }
  }
}
