import 'dart:convert';

import 'package:http/http.dart';

class GettedData {
  String search;
  String? temp;
  String? humidity;
  String? feelsLike;
  String? max;
  String? min;
  String? pressure;
  String? cityData;
  String? visibl;
  Map? wind;
  Map? conditions;
  String iconUrl = 'https://openweathermap.org/img/wn/04n@4x.png';
  Map? cord;
  String aqi = 'no';
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
      // print("coiedfwedw\n");
      temp = data['main']['temp'].toString();
      feelsLike = data['main']['feels_like'].toString();
      max = data['main']['temp_max'].toString();
      min = data['main']['temp_min'].toString();
      humidity = data['main']['humidity'].toString();
      pressure = data['main']['pressure'].toString();
      conditions = data['weather'][0];
      cityData = data['name'] + ', ' + data['sys']['country'];
      visibl = (data['visibility'] / 100).toString();
      wind = data['wind'];
      cord = data['coord'];
      iconUrl =
          "https://openweathermap.org/img/wn/${(data['weather'][0]['icon']).toString()}@4x.png";

      Response response2 = await get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/air_pollution?lat=${cord?['lat']}&lon=${cord?['lon']}&appid=d46e83574c1f494bf7e5b93004ab9cd6'));
      if (response2.statusCode == 200) {
        Map data2 = jsonDecode(response2.body);
        print(data2);
        aqi = (data2['list'][0]['main']['aqi']).toString();
      } else {
        throw Exception('Failed to load uaqi');
      }
      // return true;
    } else {
      throw Exception('Failed to load user');
      // return false;
    }
  }
}

Map<String, dynamic> bgimageIndex = {
  "null":
      "https://images.unsplash.com/photo-1519422073259-4a67b15ea2e6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Clouds":
      "https://images.unsplash.com/photo-1574780986957-74f4ee225b87?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Thunderstorm":
      "https://images.unsplash.com/photo-1562155618-e1a8bc2eb04f?q=80&w=1491&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Rain":
      'https://images.unsplash.com/photo-1691265690307-47c9a0cffb0a?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  // 'https://images.unsplash.com/photo-1516279232585-44b3f7e8bad4?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  // "https://images.unsplash.com/photo-1507027682794-35e6c12ad5b4?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Haze":
      'https://images.unsplash.com/photo-1526281216101-e55f00f0db7a?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  // "https://images.unsplash.com/photo-1446339640351-36086581f5f6?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Clear":
      "https://images.unsplash.com/photo-1691756124504-f34d35665000?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Mist":
      "https://images.unsplash.com/photo-1486327764279-9ad06d206d9f?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Fog":
      "https://images.unsplash.com/photo-1485236715568-ddc5ee6ca227?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "Drizzle":
      "https://plus.unsplash.com/premium_photo-1687428554400-3ebabab7de29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODV8fERyaXp6bGV8ZW58MHx8MHx8fDA%3D",
  "Snow":
      "https://images.unsplash.com/photo-1478265409131-1f65c88f965c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
};

Map<String, dynamic> aqidata = {
  'Null': 'no',
  '1': 'Good',
  '2': 'Fair',
  '3': 'Moderate',
  '4': 'Poor',
  '5': 'Very Poor'
};

String getWindDirection(String? deg) {
  String dir = '';
  if (deg == null) return dir;
  int degree = int.parse(deg);
  if (degree >= 0 && degree < 22.5) {
    dir = 'from N';
  } else if (degree >= 22.5 && degree < 67.5) {
    dir = 'from NE';
  } else if (degree >= 67.5 && degree < 112.5) {
    dir = 'from E';
  } else if (degree >= 112.5 && degree < 157.5) {
    dir = 'from SE';
  } else if (degree >= 157.5 && degree < 202.5) {
    dir = 'from S';
  } else if (degree >= 202.5 && degree < 247.5) {
    dir = 'from SW';
  } else if (degree >= 247.5 && degree < 292.5) {
    dir = 'from W';
  } else if (degree >= 292.5 && degree < 337.5) {
    dir = 'from NW';
  } else if (degree >= 337.5 && degree < 360) {
    dir = 'from N';
  } else {
    dir = 'null'; // Handle invalid degree values
  }
  return dir;
}
