import 'package:flutter/material.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/resources/constant.dart';
import 'package:life_diary_app/resources/resources.dart';

class GallryScreen extends StatefulWidget {
  static const route = '/gallary_screen';
  dynamic color;
  Color? otherColor;
  GallryScreen({this.color});

  @override
  _GallryScreenState createState() => _GallryScreenState();
}

class _GallryScreenState extends State<GallryScreen> {

  getcolorData() async {
    PreferenceModel? themeData = await SharedPreference().getData();
    setState(() {});
    widget.color = themeData!.themeColorData;
    String colorString = widget.color!; // Color(0x12345678)
    String valueString =
    colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    setState(() {});
    widget.otherColor = Color(value);
  }

  @override
  Widget build(BuildContext context) {
    getcolorData();
    return Scaffold(
      backgroundColor: widget.otherColor,
      appBar: getAppBar(),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appbarcolor,
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: appbarcolor,
      title: Text(
        'Photo Memories',
        style: textStyle18(whitecolor),
      ),
    );
  }

  Widget getBody() {
    return Center(
      child: Container(
        height: deviceHeight(context) * 0.5,
        child: Image.asset(imgGallarybackground),
      ),
    );
  }
}
