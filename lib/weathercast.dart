import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  String? image;
  String? km;
  String? climate;
   Weather({Key? key,this.image,this.km,this.climate}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 35,
          height: 35,
          child: Image(image: AssetImage('${widget.image}')),
        ),
        SizedBox(height: 10,),
       widget.climate=='wind'? Text(
         '${widget.km} km/h',
         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
       ):Text(
         '${widget.km} %',
         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
       ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${widget.climate}',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w300, color: Colors.black),
        ),


      ],

    );
  }
}
