import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptwo/providerclass.dart';

import 'homepage.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(create: (context) => LivelocationWeatherProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false,
      home: Homepage(),),
    );

  }
}
