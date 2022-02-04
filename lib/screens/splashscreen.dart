import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/resources/Images.dart';
import 'package:life_diary_app/resources/constant.dart';
import 'package:life_diary_app/resources/diamensions.dart';
import 'package:life_diary_app/screens/rootpage.dart';

class Splashscreen extends StatefulWidget {
  String? color;
  Color? otherColor;

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage())));
  }

  @override
  getcolorData() async {


    PreferenceModel? themeData = await SharedPreference().getData();
    setState(() {});
    widget.color =themeData!.themeColorData;
    String colorString = widget.color!; // Color(0x12345678)
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    setState(() {});
    widget.otherColor = Color(value);
  }

  Widget build(BuildContext context) {
    getcolorData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.otherColor,
        body: Center(
            child: Container(
                height: deviceHeight(context) * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imgAppbarLogo)),
                    border: Border.all(
                        color: Colors.white,
                        width: deviceWidth(context) * 0.008),
                    shape: BoxShape.circle))),
      ),
    );
  }
}
