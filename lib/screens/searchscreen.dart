import 'package:flutter/material.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/resources/colors.dart';
import 'package:life_diary_app/resources/resources.dart';

class SearchScreen extends StatefulWidget {
  static const route = '/search_screen';
  dynamic color;
  Color? otherColor;

  SearchScreen({this.color});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isClose = true;

  getcolorData() async {
    PreferenceModel? themeData = await SharedPreference().getData();
    widget.color = themeData!.themeColorData;

    String colorString = widget.color!; // Color(0x12345678)
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    widget.otherColor = new Color(value);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getcolorData();
    return Scaffold(
      appBar: getSearchbar(),
      backgroundColor: widget.otherColor,
      body: getbody(),
    );
  }

  PreferredSizeWidget getSearchbar() {
    return AppBar(
      backgroundColor: appbarcolor,
      title: isClose
          ? Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        color: whitecolor,
                      ),
                      hintText: 'Search',
                      hintStyle: textStyle18(),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isClose = !isClose;
                          });
                        },
                        icon: Icon(Icons.close),
                        color: whitecolor,
                      )),
                  autofocus: true,
                  cursorColor: Colors.black,
                ),
                Container(
                  color: whitecolor.withOpacity(0.8),
                  height: deviceHeight(context) * 0.001,
                )
              ],
            )
          : Text(
              'Search',
              style: textStyle18(whitecolor),
            ),
      actions: [
        isClose
            ? Container()
            : IconButton(
                onPressed: () {
                  setState(() {
                    isClose = true;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: whitecolor,
                ))
      ],
    );
  }

  Widget getbody() {
    return Center(
        child: Container(
            height: deviceHeight(context) * 0.5,
            child: Image.asset(imgSearchbackground)));
  }
}
