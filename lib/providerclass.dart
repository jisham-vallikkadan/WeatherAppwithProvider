import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptwo/weahermodel.dart';
import 'package:http/http.dart' as http;

class LivelocationWeatherProvider with ChangeNotifier {
  var exactpostion = '';

  Future<void> getpostion() async {
    Position position = await takeposition();
    List positiondata =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    print('pickup');
    print(positiondata[0].locality);
    exactpostion = positiondata[0].locality.toString();
    notifyListeners();
  }

  Future<Position> takeposition() async {
    print('on location');
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  double temp = 0;
  String? wind;
  String? humidity;
  String? rain;
  double? Morntemp;
  double? daytemp;
  double? evetemp;
  double? nighttemp;
  String location = '';
  String? disc;

  double get dayweather {
    temp;
    wind;
    humidity;
    rain;
    Morntemp;
    daytemp;
    evetemp;
    nighttemp;
    location;
    disc;
    return temp;
  }

  Future<List<Weatherdata>> getday(String position) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast/daily?q=${position}&units=metric&cnt=7&appid=d94bcd435b62a031771c35633f9f310a';
    var responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      notifyListeners();
      var body = json.decode(responce.body);

      location = body['city']['name'];
      temp = body['list'][0]['temp']['day'];
      humidity = body["list"][0]['humidity'].toString();
      wind = body['list'][0]['speed'].toString();
      rain = body["list"][0]['rain'].toString();
      Morntemp = body['list'][0]['temp']['day'];
      daytemp = body['list'][0]['temp']['max'];
      evetemp = body['list'][0]['temp']['eve'];
      nighttemp = body['list'][0]['temp']['night'];
      disc = body["list"][0]['weather'][0]['description'];
// print(body);
      List<Weatherdata> listData = List<Weatherdata>.from(
          body['list'].map((v) => Weatherdata.fromJson(v))).toList();

      return listData;
    } else {
      List<Weatherdata> listData = [];
      return listData;
    }
  }
}
