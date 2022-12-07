import 'package:weatherapptwo/weathercast.dart';

import 'mainwmodel.dart';
import 'weatherrainmodelclass.dart';
import 'weatherapiclass.dart';

class Weatherdata {
  String? humidity;
  Temp? temp;
  Weatherrain? weather;

  Weatherdata({
    this.humidity,
    this.temp,
    this.weather,
  });
  factory Weatherdata.fromJson(Map<String, dynamic> response) {
    return Weatherdata(
      humidity: response['humidity'].toString(),
      temp: Temp.fromJson(response['temp']),
      weather: Weatherrain.fromJson(response['weather'][0]),
    );
  }
}
