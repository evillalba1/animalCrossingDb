import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:animalcrossingdb/object_class.dart';
//import 'package:awesome_button/awesome_button.dart';
//import 'package:flutter/services.dart';

import 'home_view.dart';


void main() {
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//      .then((_) {
//    runApp(MaterialApp(home: HomePage()));
//  });
  runApp(MaterialApp(home: HomePage()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("fetching");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
