import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/models/settingscreenmodellist.dart';
import 'package:life_diary_app/resources/constant.dart';
import 'package:life_diary_app/resources/resources.dart';
import 'package:life_diary_app/screens/lock_screen.dart';
import 'package:life_diary_app/screens/rootpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

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
  String? passcode;
  int _portraitCrossAxisCount = 4;
  int _landscapeCrossAxisCount = 5;

  double _borderRadius = 30;
  double _blurRadius = 5;
  double _iconSize = 24;

  String? selectedFontData;
  String? getFontFamilyData;
  double getFontSizeData = 13;
  String? getFontStringData;
  bool isSwitched = false;
  String? _chosenValue;
  TimeOfDay? _selectedTime;
  bool _isSelectTime = false;
  String? time;
  String defaultTime =
      '${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().second}';

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
      getFontStringData;
    });
    getFontStringData = themeData!.themeFontData;
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
                    itemCount: fonts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedFontData = fonts[index].data;
                                storeFontFamily(
                                    fontfamily: getTextStyle(index: index),
                                    fontFamilyselectedData: selectedFontData!);
                              });

                              Navigator.of(context).pushNamed(Homepage.route,
                                  arguments: widget.currentColor);
                            },
                            child: Text(
                              fonts[index].data,
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
                            value: getFontStringData == null ||
                                    getFontStringData!.isEmpty
                                ? getFontSizeData
                                : double.parse(getFontStringData!),
                            onChangeEnd: (value) async {
                              themeData!.themeFont = value.toInt().toString();
                              await SharedPreference().addData(themeData);
                            },
                            onChanged: (value) {
                              setState(() {
                                getFontStringData = value.toString();
                                getFontSizeData = value;
                              });
                            },
                            min: 12,
                            max: 25,
                          ),
                          Text(
                            getFontStringData == null ||
                                    getFontStringData!.isEmpty
                                ? getFontSizeData.toInt().toString()
                                : double.parse(getFontStringData!)
                                    .toInt()
                                    .toString(),
                            style: TextStyle(
                              fontSize: getFontStringData == null ||
                                      getFontStringData!.isEmpty
                                  ? getFontSizeData
                                  : double.parse(getFontStringData!),
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

  passcodeRemove() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // PreferenceModel? themeData;
    // if (prefs.getString(themeDataKey) != null) {
    //   themeData = await SharedPreference().getData();
    // } else {
    //   themeData = PreferenceModel();
    // }
    await showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
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
                        //backgroundColor: widget.otherColor,
                        body: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'What would you like to do?',
                            style: textStyle18(appbarcolor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LockScreen(
                                            isOldPasscode: true,
                                          )));
                                },
                                child: Text(
                                  'Remove Passcode',
                                  style: textStyle16(Settingscreenrighttxt),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LockScreen(
                                            isChangePasscode: true,
                                          )));
                                },
                                child: Text(
                                  'Change Passcode',
                                  style: textStyle16(Settingscreenrighttxt),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))),
              )
            ],
          );
        });
  }

  openLockScreen() {
    Navigator.of(context).pushNamed(LockScreen.route);
  }

  getPasscodeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PreferenceModel? themeData;
    if (prefs.getString(themeDataKey) != null) {
      themeData = await SharedPreference().getData();
    } else {
      themeData = PreferenceModel();
    }
    passcode = themeData!.getPasscodeData;
    setState(() {});
  }

  openReminderDialog() async {
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
                      height: deviceHeight(context) * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Scaffold(
                          //backgroundColor: widget.otherColor,
                          body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: deviceWidth(context) * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reminder',
                                  style: textStyle16(appbarcolor),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSwitched = !isSwitched;
                                    });
                                  },
                                  child: Text(
                                    isSwitched ? 'ON' : 'OFF',
                                    style: textStyle16(appbarcolor),
                                  ),
                                ),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      print(isSwitched);
                                    });
                                  },
                                  activeTrackColor: Colors.black12,
                                  activeColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: deviceWidth(context) * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Repeat',
                                  style: textStyle16(appbarcolor),
                                ),
                                DropdownButton<String>(
                                  underline: SizedBox(),
                                  value: _chosenValue,
                                  //elevation: 5,
                                  style: textStyle16(Settingscreenrighttxt),

                                  items: <String>[
                                    'Daily',
                                    'Weekly',
                                    'Monthly',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: Row(
                                    children: [
                                      Text(
                                        "Daily",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: deviceWidth(context) * 0.30,
                                      )
                                    ],
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _chosenValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: deviceWidth(context) * 0.05),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Time',
                                    style: textStyle16(appbarcolor),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await _presentTimePicker();
                                        isSwitched ? onSaveReminder() : null;
                                      },
                                      child: Text(
                                        time == null ? defaultTime : time!,
                                        style:
                                            textStyle16(Settingscreenrighttxt),
                                      )),
                                  SizedBox(
                                    width: deviceWidth(context) * 0.02,
                                  )
                                ]),
                          )
                        ],
                      ))),
                )
              ],
            );
          });
        });
  }

  _presentTimePicker() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay(
                hour: DateTime.now().hour, minute: DateTime.now().minute))
        .then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
        _isSelectTime = true;
        time =
            '${_selectedTime!.hour}:${_selectedTime!.minute} ${_selectedTime!.period.name}';
      });

      Navigator.of(context).pop();
    });
    openReminderDialog();
  }

  void scheduleTextNotes(
      DateTime scheduledNotificationDateTime, String textNotes) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'textNotes_notify',
      'Channel for textNotes notification',
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(0, 'Reminder', textNotes,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void onSaveReminder([int? index, dynamic savedTextNote]) {
    DateTime? scheduleTextNotesDateTime;
    scheduleTextNotesDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _selectedTime!.hour,
        _selectedTime!.minute);

    // print('=-=-=-=-=-=$_isSave');
    // var textNoteInfo = TextNotes(
    //     index == null ? textNoteModel.titleText : savedTextNote.titleText,
    //     index == null ? textNoteModel.noteText : savedTextNote.noteText,
    //     DateFormat().add_yMd().format(_selectedDate!),
    //     '${_selectedTime!.hour}:${_selectedTime!.minute}');
    scheduleTextNotes(scheduleTextNotesDateTime, 'start to write your note');
    // print('------3----$isSave');
    // _isSave ? Navigator.of(context).pop() : null;
    // isSave ? null : Navigator.of(context).pop();
    // loadAlarms();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFontFamily();
    getFontSizeValue();
    getPasscodeData();
  }

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
                                              : index == 5
                                                  ? passcode == null ||
                                                          passcode!.isEmpty
                                                      ? openLockScreen()
                                                      : passcodeRemove()
                                                  : index == 6
                                                      ? openReminderDialog()
                                                      : null;
                                    },
                                    child: Text(
                                      index == 3
                                          ? selectedFontData == null ||
                                                  selectedFontData!.isEmpty
                                              ? screenData[index].rightsidetxt
                                              : selectedFontData
                                          : index == 5
                                              ? passcode == null ||
                                                      passcode!.isEmpty
                                                  ? screenData[index]
                                                      .rightsidetxt
                                                  : 'Enabled'
                                              : index == 6
                                                  ? !isSwitched
                                                      ? 'OFF'
                                                      : screenData[index]
                                                          .rightsidetxt
                                                  : screenData[index]
                                                      .rightsidetxt,
                                      style: index == 3
                                          ? TextStyle(
                                              fontSize: 16,
                                              color: Settingscreenrighttxt,
                                              fontFamily: getFontFamilyData ??
                                                  "Roboto-Bold")
                                          : index == 4
                                              ? TextStyle(
                                                  fontSize: getFontStringData ==
                                                              null ||
                                                          getFontStringData!
                                                              .isEmpty
                                                      ? getFontSizeData
                                                      : double.parse(
                                                          getFontStringData!))
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
