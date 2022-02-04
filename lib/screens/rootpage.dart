import 'package:flutter/material.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/resources/resources.dart';
import 'package:life_diary_app/screens/note_screen.dart';
import 'package:life_diary_app/screens/photoviewscreen.dart';
import 'package:life_diary_app/screens/searchscreen.dart';
import 'package:life_diary_app/screens/settingscreen.dart';

class Homepage extends StatefulWidget {
  static const route = '/Homepage_screen';

  String? color;
  Color? otherColor;

  Homepage({this.color});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void getSyncData() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: widget.otherColor,
        title: Column(
          children: [
            Icon(
              Icons.sync,
              size: deviceHeight(context) * 0.06,
              color: appbarcolor,
            ),
            SizedBox(
              height: deviceHeight(context) * 0.01,
            ),
            Text(
              'Sync Your Data',
              style: textStyle18Medium(appbarcolor),
            ),
          ],
        ),
        content: Container(
          height: deviceHeight(context) * 0.15,
          child: Column(
            children: [
              Text(
                'Please Sign In and Sync your data often to avoid data loss.',
                style: textStyle16Medium(dialogtxtcolor),
              ),
              SizedBox(
                height: deviceHeight(context) * 0.03,
              ),
              Text(
                'it\'s free to sync your data and see them on any of the devices.',
                style: textStyle16Medium(dialogtxtcolor),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: appbarcolor),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth(context) * 0.05,
                      vertical: deviceHeight(context) * 0.01),
                  child: Text(
                    "Sign in",
                    style: textStyle14(whitecolor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getcolorData() async {
    PreferenceModel? themeData = await SharedPreference().getData();

    widget.color = themeData!.themeColorData;

    setState(() {});

    String colorString = widget.color!; // Color(0x12345678)
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    widget.otherColor = new Color(value);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcolorData();
  }

  @override
  Widget build(BuildContext context) {
    getcolorData();
    return Scaffold(
      backgroundColor: widget.otherColor,
      body: Stack(
        children: [
          Column(
            children: [
              getAppbar(),
            ],
          ),
          Positioned(
              bottom: deviceHeight(context) * 0.2,
              left: deviceWidth(context) * 0.3,
              child: Image.asset(
                imgbackground,
                height: deviceHeight(context) * 0.4,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NoteScreen.route);
          },
          child: Icon(Icons.edit),
          backgroundColor: appbarcolor),
    );
  }

  Widget getAppbar() {
    return Container(
      height: deviceHeight(context) * 0.1,
      color: appbarcolor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: deviceHeight(context) * 0.05,
                    child: Image.asset(
                      imgAppbarLogo,
                      fit: BoxFit.cover,
                    )),
                Text(
                  '  Life Diary',
                  style: textStyle18Bold(Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      getSyncData();
                    },
                    icon: Icon(
                      Icons.wb_cloudy_outlined,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SearchScreen.route,
                          arguments: widget.color);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(GallryScreen.route,
                          arguments: widget.color);
                    },
                    icon: Icon(
                      Icons.photo,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.print,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SettingScreen.route,
                          arguments: widget.otherColor);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
