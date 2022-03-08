import 'package:flutter/material.dart';
import 'package:life_diary_app/resources/Images.dart';
import 'package:life_diary_app/resources/colors.dart';
import 'package:life_diary_app/resources/icons.dart';

class SettingScreenData {
  final String leftsidetxt;
  final dynamic rightsidetxt;

  SettingScreenData({required this.leftsidetxt, required this.rightsidetxt});
}

List<SettingScreenData> screenData = [
  SettingScreenData(leftsidetxt: 'Sign In', rightsidetxt: 'Sync OFF'),
  SettingScreenData(leftsidetxt: 'Theme', rightsidetxt: getThemeIcon()),
  SettingScreenData(
      leftsidetxt: 'Background', rightsidetxt: getBackgroundIcon()),
  SettingScreenData(leftsidetxt: 'Font', rightsidetxt: 'Lato Bold'),
  SettingScreenData(leftsidetxt: 'Font Size', rightsidetxt: 'Aa'),
  SettingScreenData(leftsidetxt: 'Passcode', rightsidetxt: 'Disabled'),
  SettingScreenData(leftsidetxt: 'Reminder', rightsidetxt: 'ON'),
  SettingScreenData(leftsidetxt: 'Purchase Premium', rightsidetxt: 'Sync OFF'),
  SettingScreenData(leftsidetxt: 'Share App', rightsidetxt: ''),
  SettingScreenData(leftsidetxt: 'Privacy Policy', rightsidetxt: ''),
  SettingScreenData(leftsidetxt: 'Frequently Asked', rightsidetxt: ''),
  SettingScreenData(leftsidetxt: 'Purchase Premium', rightsidetxt: '')
];

class BackgroundThemeData {
  final String imgpath;

  BackgroundThemeData({required this.imgpath});
}

List<BackgroundThemeData> getThemeData = [
  BackgroundThemeData(imgpath: imgBgGrid1),
  BackgroundThemeData(imgpath: imgBgGrid2),
  BackgroundThemeData(imgpath: imgBgGrid3),
  BackgroundThemeData(imgpath: imgBgGrid4),
];

Widget getThemeIcon() {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: appbarcolor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Image.asset(
        checkIcon,
        color: whitecolor,
      ),
    ),
  );
}

Widget getBackgroundIcon() {
  return Image.asset(
    BackgroundIcon,
    height: 25,
  );
}

const List<Color> colors = [
  backgroundcolor,
  splashbgcolor,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

class FontData {
  final String data;

  FontData(this.data);
}

List<FontData> fonts = [FontData('Roboto'), FontData('Roboto Bold'),FontData('Lato'),FontData('Lato Bold'),FontData('lobster'),FontData('indie flower'),FontData('Dancing Seript'),FontData('Caveat'),FontData('great vibes'),FontData('pacifico'),FontData('Saira')];
