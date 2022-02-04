import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/models/settingscreenmodellist.dart';
import 'package:life_diary_app/resources/constant.dart';
import 'package:life_diary_app/resources/resources.dart';
import 'package:life_diary_app/screens/rootpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  dynamic color;
  Color? otherColor;

  SettingScreen({this.color});

  static const route = 'Setting_Screen';
  bool lightTheme = true;
  Color currentColor = Colors.amber;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _portraitCrossAxisCount = 4;
  int _landscapeCrossAxisCount = 5;

  double _borderRadius = 30;
  double _blurRadius = 5;
  double _iconSize = 24;

  String? selectedFontData;
  String? getFontFamilyData;
  double? getFontSizeData = 10;
  double age = 10;

  Widget pickerLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: 300,
      height: orientation == Orientation.portrait ? 360 : 240,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait
            ? _portraitCrossAxisCount
            : _landscapeCrossAxisCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }

  Widget pickerItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: color,
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.8),
              offset: const Offset(1, 2),
              blurRadius: _blurRadius)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: _iconSize,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    PreferenceModel? themeData;

    if (prefs.getString(themeDataKey) != null) {
      themeData = await SharedPreference().getData();
    } else {
      themeData = PreferenceModel();
    }

    widget.currentColor = color;
    setState(() {});

    themeData!.themeColor = widget.currentColor.toString();
    await SharedPreference().addData(themeData);
    Navigator.of(context)
        .pushNamed(Homepage.route, arguments: widget.currentColor);
  }

  void changeColors(List<Color> colors) =>
      setState(() => widget.currentColors = colors);

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

  void getBackgroundData() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Backgrounds(Beta)',
              style: textStyle18(Colors.black),
            ),
            SizedBox(
              height: deviceHeight(context) * 0.02,
            ),
            Row(
              children: [
                Expanded(child: Image.asset(imgBgThemeData1)),
                Expanded(child: Image.asset(imgBgThemeData2)),
              ],
            )
          ],
        ),
        content: Container(
          // color: Colors.green,
          width: deviceWidth(context) * 0.02,
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              childAspectRatio: 0.7,
              children: List.generate(getThemeData.length, (index) {
                return Center(
                  child: Container(
                    height: deviceHeight(context) * 0.3,
                    child: Image.asset(
                      getThemeData[index].imgpath,
                      fit: BoxFit.cover,
                      //height: 40,
                    ),
                  ),
                );
              })),
        ),
        // actions: <Widget>[
        //   Center(
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: TextButton(
        //         style: TextButton.styleFrom(backgroundColor: appbarcolor),
        //         onPressed: () {
        //           Navigator.of(ctx).pop();
        //         },
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(
        //               horizontal: deviceWidth(context) * 0.05,
        //               vertical: deviceHeight(context) * 0.01),
        //           child: Text(
        //             "Sign in",
        //             style: textStyle14(whitecolor),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }

  getTextStyle({int? index}) {
    if (index == 0) {
      return " Roboto-txt";
    } else if (index == 1) {
      return "Roboto-Bold";
    } else if (index == 2) {
      return "Lato";
    } else if (index == 3) {
      return " Lato-Bold";
    } else if (index == 4) {
      return "IndieFlower";
    } else if (index == 5) {
      return "DancingScript";
    } else if (index == 6) {
      return "Caveat";
    } else if (index == 7) {
      return "GochiHand";
    } else if (index == 8) {
      return "GreatVibes";
    } else if (index == 9) {
      return "Pacifico";
    } else {
      return "Saira";
    }
  }

  storeFontFamily(
      {required String fontfamily,
      required String fontFamilyselectedData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    PreferenceModel? themeData;

    if (prefs.getString(themeDataKey) != null) {
      themeData = await SharedPreference().getData();
    } else {
      themeData = PreferenceModel();
    }

    // themeData.themeColor='';
    themeData!.themeFontFamily = fontfamily;
    themeData.themeFontFamilySelected = fontFamilyselectedData;
    await SharedPreference().addData(themeData);
  }

  getFontFamily() async {
    PreferenceModel? themeData = await SharedPreference().getData();
    print(themeData!.themeFontFamilySelectedData);

    setState(() {
      getFontFamilyData;
      selectedFontData;
    });
    getFontFamilyData = themeData.themeFontFamilyData;
    selectedFontData = themeData.themeFontFamilySelectedData;
  }

  getFontSizeValue() async {
    PreferenceModel? themeData = await SharedPreference().getData();
    setState(() {
      getFontSizeData;
    });
    getFontSizeData = themeData!.themeFontData;
  }

  void getFontStyle() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: widget.otherColor,
        content: Container(
          width: deviceWidth(context) * 0.02,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: Fonts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedFontData = Fonts[index].data;
                                storeFontFamily(
                                    fontfamily: getTextStyle(index: index),
                                    fontFamilyselectedData: selectedFontData!);
                              });

                              Navigator.of(context).pushNamed(Homepage.route,
                                  arguments: widget.currentColor);
                            },
                            child: Text(
                              Fonts[index].data,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: getTextStyle(index: index)),
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight(context) * 0.05,
                          )
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    PreferenceModel? themeData;

    if (prefs.getString(themeDataKey) != null) {
      themeData = await SharedPreference().getData();
    } else {
      themeData = PreferenceModel();
    }
    await showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  bottom: 200,
                  child: Container(
                    width: deviceWidth(context) * 1,
                    height: deviceHeight(context) * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Scaffold(
                      backgroundColor: widget.otherColor,
                      body: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Size',
                            style: textStyle16(Settingscreenlefttxt),
                          ),
                          Slider(
                            activeColor: Colors.black,
                            label: "Select Age",
                            value: getFontSizeData!,
                            onChangeEnd: (value) {
                              print('enddata${value.toInt().toString()}');
                            },
                            onChanged: (value) {
                              setState(() {
                                getFontSizeData = value;
                              });
                            },
                            min: 10,
                            max: 20,
                          ),
                          Text(
                            getFontSizeData!.toInt().toString(),
                            style: TextStyle(
                              fontSize: getFontSizeData,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          });
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFontFamily();
    getFontSizeValue();
  }

  @override
  @override
  Widget build(BuildContext context) {
    getcolorData();

    return Scaffold(
      backgroundColor: widget.otherColor,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: appbarcolor,
      title: Text(
        'Settings',
        style: textStyle18(whitecolor),
      ),
    );
  }

  Widget getBody() {
    return Container(
      height: deviceHeight(context) * 0.8,
      child: ListView.builder(
          itemCount: screenData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: deviceWidth(context) * 0.03,
                          ),
                          Text(
                            screenData[index].leftsidetxt,
                            style: textStyle16(Settingscreenlefttxt),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: deviceWidth(context) * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: deviceWidth(context) * 0.03,
                            ),
                            screenData[index].rightsidetxt.runtimeType == String
                                ? InkWell(
                                    onTap: () {
                                      index == 3
                                          ? getFontStyle()
                                          : index == 4
                                              ? getFontSize()
                                              : null;
                                    },
                                    child: Text(
                                      index == 3
                                          ? selectedFontData == null ||
                                                  selectedFontData!.isEmpty
                                              ? screenData[index].rightsidetxt
                                              : selectedFontData
                                          : screenData[index].rightsidetxt,
                                      style: index == 3
                                          ? TextStyle(
                                              fontSize: 16,
                                              color: Settingscreenrighttxt,
                                              fontFamily: getFontFamilyData ??
                                                  "Roboto-Bold")
                                          : index == 4
                                              ? TextStyle(
                                                  fontSize: getFontSizeData!
                                                      .toDouble())
                                              : textStyle16(
                                                  Settingscreenrighttxt),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      index == 1
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Select a color'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: BlockPicker(
                                                      pickerColor:
                                                          widget.currentColor,
                                                      onColorChanged:
                                                          changeColor,
                                                      availableColors: widget
                                                              .colorHistory
                                                              .isNotEmpty
                                                          ? widget.colorHistory
                                                          : colors,
                                                      layoutBuilder:
                                                          pickerLayoutBuilder,
                                                      itemBuilder:
                                                          pickerItemBuilder,
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : index == 2
                                              ? getBackgroundData()
                                              : null;
                                    },
                                    child: Container(
                                      child: screenData[index].rightsidetxt,
                                    ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth(context) * 0.2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight(context) * 0.01,
                  ),
                  Divider(
                    thickness: 1,
                    color: Settingscreenrighttxt,
                  )
                ],
              ),
            );
          }),
    );
  }
}
