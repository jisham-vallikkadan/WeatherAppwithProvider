import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptwo/providerclass.dart';

import 'package:weatherapptwo/rowbulider.dart';
import 'package:weatherapptwo/weahermodel.dart';
import 'package:weatherapptwo/weatherapiclass.dart';

import 'todayforcast.dart';
import 'weathercast.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LivelocationWeatherProvider>(context, listen: false)
        .getpostion();


  }



  @override
  Widget build(BuildContext context) {
    var data = Provider.of<LivelocationWeatherProvider>(context, listen: false);
    var a = context.watch<LivelocationWeatherProvider>().dayweather;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_on),
            color: Colors.black,
          ),
        ],
        leading: Icon(Icons.apps_rounded),
        backgroundColor: Color(0xff00a1ff),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(50),
                      bottomStart: Radius.circular(50)),
                  color: Color(0xff00a1ff),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff00a1ff),
                        spreadRadius: 4,
                        blurRadius: 13)
                  ]),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    // color: Colors.black,
                    child: data.temp! < 0
                        ? Image(image: AssetImage('images/snowflake.png'))
                        : (data.temp! <= 0 && data.temp! >= 10)
                            ? Image(image: AssetImage('images/rainy.png'))
                            : (data.temp! > 10)
                                ? Image(image: AssetImage('images/sun.png'))
                                : Image(image: AssetImage('images/rainy.png')),
                  ),
                  Text(
                    '${(data.temp)}°C',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    data.location,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    '${data.disc}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Divider(
                      thickness: 2,
                      color: Colors.white30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Weather(
                            image: 'images/wind.png',
                            climate: 'wind',
                            km: '${data.wind}'),
                        Weather(
                            image: 'images/hot.png',
                            climate: 'Humidity',
                            km: '${data.humidity}'),
                        Weather(
                            image: 'images/rainy.png',
                            climate: 'rain',
                            km: '${data.rain}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '1 days',
                        style: TextStyle(
                            color: Color(0xff606170),
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Today(
                        todayimage: 'images/morn.png',
                        time: '6:00',
                        todaytemp: '${data.Morntemp}',
                      ),
                      Today(
                        todayimage: 'images/sun.png',
                        time: '12:00',
                        todaytemp: '${data.daytemp}',
                      ),
                      Today(
                        todayimage: 'images/clouds.png',
                        time: '5:00',
                        todaytemp: '${data.evetemp}',
                      ),
                      Today(
                        todayimage: 'images/moon.png',
                        time: '9:00',
                        todaytemp: '${data.nighttemp}',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    // future: weatherApi.getday(exactpostion),
                    future: data.getday(data.exactpostion),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: RowBulider(
                              verticalDirection: VerticalDirection.down,
                              itemBuilder: (context, index) {
                                var days = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Text(
                                          'day${index + 1} ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          '${days.temp!.min}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '${days.temp!.eve}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          days.weather!.main.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.length),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }


}
