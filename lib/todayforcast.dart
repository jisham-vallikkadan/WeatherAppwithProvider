import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  String? todaytemp;
  String? todayimage;
  String? time;
  Today({Key? key, this.todaytemp, this.todayimage, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.black87,
              border: Border.all(color: Colors.white, width: 1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${this.todaytemp}°C',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                width: 35,
                height: 35,
                color: Colors.black87,
                child: Image(
                  image: AssetImage('${this.todayimage}'),
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '${this.time}',
                style: TextStyle(
                    color: Color(0xff606170),
                    fontSize: 19,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
    );
  }
}
