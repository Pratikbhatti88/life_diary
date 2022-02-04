import 'package:flutter/material.dart';
import 'package:life_diary_app/routes.dart';
import 'package:life_diary_app/screens/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        home: Splashscreen());
  }
}
