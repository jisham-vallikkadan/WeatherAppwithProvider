// import 'dart:convert';
//
// import 'package:weatherapptwo/weahermodel.dart';
// import 'package:http/http.dart' as http;
//
// class WeatherApi {
//
//   Future<List<Weatherdata>> getday(String position) async {
//     final url =
//         'https://api.openweathermap.org/data/2.5/forecast/daily?q=${position}&units=metric&cnt=7&appid=d94bcd435b62a031771c35633f9f310a';
//     var responce = await http.get(Uri.parse(url));
//     if (responce.statusCode == 200) {
//       var body = json.decode(responce.body);
// // print(body);
//       List<Weatherdata> listData = List<Weatherdata>.from(
//           body['list'].map((v) => Weatherdata.fromJson(v))).toList();
//       return listData;
//     } else {
//       List<Weatherdata> listData = [];
//       return listData;
//     }
//   }
// }
