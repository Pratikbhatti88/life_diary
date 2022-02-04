// import 'package:flutter/material.dart';
// import 'package:life_diary_app/core/prefrence.dart';
// import 'package:life_diary_app/resources/constant.dart';
//
// dynamic getcolorData({dynamic color,Color? otherColor}) async {
//   color = await SharedPreference().getOnboardingData(colorKey);
//   String colorString = color; // Color(0x12345678)
//   String valueString =
//   colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
//   int value = int.parse(valueString, radix: 16);
//   otherColor = Color(value);
//
//   return otherColor;
// }