import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/resources/colors.dart';
import 'package:life_diary_app/resources/diamensions.dart';
import 'package:life_diary_app/resources/icons.dart';
import 'package:life_diary_app/resources/resources.dart';

class NoteScreen extends StatefulWidget {
  static const route = 'note_screen';
  dynamic color;
  Color? otherColor;
  String? selectedFontData;
  String? getFontFamilyData;
  DateTime? _selectedDate;
  bool _isSelectDate = false;
  String? day;
  String? date;
  TimeOfDay? _selectedTime;
  bool _isSelectTime = false;
  String? time;
  double? getFontSizeData = 10;
  String? getFontStringData;

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String defaultTime =
      '${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().second}';

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

  getFontFamily() async {
    PreferenceModel? themeData = await SharedPreference().getData();
    print(themeData!.themeFontFamilySelectedData);

    widget.getFontFamilyData = themeData.themeFontFamilyData;
    print('data=============');
    print(widget.getFontFamilyData);
  }

  getFontSizeValue() async {
    PreferenceModel? themeData = await SharedPreference().getData();

    widget.getFontStringData = themeData!.themeFontData;
    setState(() {});
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      _presentTimePicker();
      if (pickedDate == null) {
        return;
      }
      setState(() {
        widget._isSelectDate = true;
        widget._selectedDate = pickedDate;
        widget.day = DateFormat().add_EEEE().format(widget._selectedDate!);
        widget.date = DateFormat().add_yMMMd().format(widget._selectedDate!);
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(
                hour: DateTime.now().hour, minute: DateTime.now().minute))
        .then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        widget._selectedTime = pickedTime;
        widget._isSelectTime = true;
        widget.time =
            '${widget._selectedTime!.hour}:${widget._selectedTime!.minute} ${widget._selectedTime!.period.name}';
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcolorData();
    getFontFamily();
    getFontSizeValue();
  }

  @override
  Widget build(BuildContext context) {
    print('getfontdata=========');
    print(widget.getFontStringData);
    getcolorData();
    return Scaffold(
        backgroundColor: widget.otherColor,
        appBar: getAppBar(),
        body: getBody());
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: appbarcolor,
      title: Text('Write'),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              premiumIcon,
              color: whitecolor,
              height: deviceHeight(context) * 0.035,
            )),
        IconButton(
            onPressed: () {},
            icon: Image.asset(checkIcon,
                color: whitecolor, height: deviceHeight(context) * 0.030)),
        IconButton(
            onPressed: () {},
            icon: Image.asset(moreVertIcon,
                color: whitecolor, height: deviceHeight(context) * 0.030)),
      ],
    );
  }

  Widget getBody() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: _presentDatePicker,
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(
                    width: deviceWidth(context) * 0.02,
                  ),
                  Text(
                      '${widget.day ?? DateFormat().add_EEEE().format(DateTime.now())}${','}${widget.date ?? DateFormat().add_yMMMd().format(DateTime.now())} ${widget.time ?? defaultTime} ',
                      style: TextStyle(
                          fontFamily: widget.getFontFamilyData ?? "Lato-Bold",
                          fontSize: widget.getFontStringData == null ||
                                  widget.getFontStringData!.isEmpty
                              ? widget.getFontSizeData
                              : double.parse(
                                  widget.getFontStringData.toString()))),
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight(context) * 0.02,
            ),
            TextField(
              style: TextStyle(
                  fontSize: widget.getFontStringData == null ||
                          widget.getFontStringData!.isEmpty
                      ? widget.getFontSizeData
                      : double.parse(widget.getFontStringData.toString()),
                  fontFamily: widget.getFontFamilyData ?? "Lato-Bold"),
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'write here...',
                  hintStyle: TextStyle(color: Colors.purple)),
            ),
            Spacer(),
            Row(
              children: [
                bottomIcon(data: Icons.camera_alt),
                SizedBox(
                  width: deviceWidth(context) * 0.02,
                ),
                bottomIcon(data: Icons.mic),
                Spacer(),
                bottomIcon(data: checkIcon),
              ],
            )
          ],
        ));
  }

  Widget bottomIcon({dynamic data}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: appbarcolor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: data.runtimeType == String
            ? Image.asset(
                data,
                height: deviceHeight(context) * 0.03,
                color: whitecolor,
              )
            : Icon(
                data,
                color: Colors.white,
              ),
      ),
    );
  }
}
