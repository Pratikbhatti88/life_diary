import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_diary_app/core/prefrence.dart';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/resources/Images.dart';
import 'package:life_diary_app/resources/colors.dart';
import 'package:life_diary_app/resources/constant.dart';
import 'package:life_diary_app/resources/diamensions.dart';
import 'package:life_diary_app/screens/rootpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {
  bool isOldPasscode;
  final isChangePasscode;

  LockScreen({this.isOldPasscode = false, this.isChangePasscode = false});

  static const route = 'Lock_Screen';
  dynamic color;
  String setPasscode = '';
  Color? otherColor;

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController1 = TextEditingController();
  final TextEditingController _unlockController = TextEditingController();

  bool isChange = false;

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

  storePasscode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PreferenceModel? themeData;
    if (prefs.getString(themeDataKey) != null) {
      themeData = await SharedPreference().getData();
    } else {
      themeData = PreferenceModel();
    }

    themeData!.setPasscode = _confirmController1.text;

    await SharedPreference().addData(themeData);
    await Fluttertoast.showToast(
        msg: widget.isOldPasscode ? '' : '  passcode created successfully...  ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.yellow);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    //themeData.setPasscode=
  }

  changePasscode() {
    setState(() {
      widget.setPasscode = '';
      isChange = false;
    });
  }

  getPasscodeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PreferenceModel? themeData;
    if (prefs.getString(themeDataKey) != null) {
      themeData = await SharedPreference().getData();
    } else {
      themeData = PreferenceModel();
    }

    widget.setPasscode = themeData!.getPasscodeData;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcolorData();
    getPasscodeData();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.setPasscode);
    getcolorData();
    return Scaffold(
      backgroundColor: widget.otherColor,
      body: WillPopScope(
        onWillPop: () async {
          setState(() {});
          return isChange = !isChange;
        },
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.setPasscode.isEmpty
                      ? Image.asset(
                          imgAppbarLogo,
                          height: deviceHeight(context) * 0.08,
                        )
                      : Icon(
                          Icons.lock_outline,
                          size: 70,
                          color: appbarcolor,
                        ),
                  SizedBox(
                    height: deviceHeight(context) * 0.03,
                  ),
                  Text(
                    widget.setPasscode.isEmpty
                        ? !isChange
                            ? 'SET PASSCODE'
                            : 'CONFIRM PASSCODE'
                        : widget.isOldPasscode || widget.isChangePasscode
                            ? 'Enter OLD Passcode'
                            : 'Enter passcode',
                    style: TextStyle(color: appbarcolor),
                  ),
                  SizedBox(
                    height: deviceHeight(context) * 0.1,
                    child: Container(
                      width: deviceWidth(context) * 0.4,
                      child: widget.setPasscode.isEmpty
                          ? isChange
                              ? TextField(
                                  onChanged: (hh) {
                                    print(hh.length);
                                  },
                                  maxLength: 4,
                                  obscureText: true,
                                  controller: _confirmController1,
                                  textAlign: TextAlign.center,
                                  showCursor: false,
                                  style: const TextStyle(fontSize: 40),
                                  // Disable the default soft keybaord
                                  keyboardType: TextInputType.number,
                                )
                              : TextField(
                                  onChanged: (hh) {
                                    print(hh.length);
                                    if (hh.length == 4) {
                                      setState(() {
                                        isChange = true;
                                      });
                                    }
                                  },
                                  controller: _passController,
                                  maxLength: 4,
                                  obscureText: true,
                                  textAlign: TextAlign.center,
                                  showCursor: false,
                                  style: const TextStyle(fontSize: 40),
                                  // Disable the default soft keybaord
                                  keyboardType: TextInputType.number,
                                )
                          : TextField(
                              onChanged: (hh) {
                                print(hh.length);
                              },
                              maxLength: 4,
                              obscureText: true,
                              controller: _unlockController,
                              textAlign: TextAlign.center,
                              showCursor: false,
                              style: const TextStyle(fontSize: 40),
                              // Disable the default soft keybaord
                              keyboardType: TextInputType.number,
                            ),
                    ),
                  ),
                  NumPad(
                      buttonSize: deviceHeight(context) * 0.1,
                      buttonColor: appbarcolor,
                      iconColor: Colors.deepOrange,
                      controller: widget.setPasscode.isEmpty
                          ? isChange
                              ? _confirmController1
                              : _passController
                          : _unlockController,
                      delete: () {
                        widget.setPasscode.isEmpty
                            ? isChange
                                ? _confirmController1.text =
                                    _confirmController1.text.substring(
                                        0, _confirmController1.text.length - 1)
                                : _passController.text = _passController.text
                                    .substring(
                                        0, _passController.text.length - 1)
                            : _unlockController.text = _unlockController.text
                                .substring(
                                    0, _unlockController.text.length - 1);
                      },
                      // do something with the input numbers
                      onSubmit: () {
                        debugPrint('Your code: ${_passController.text}');
                        debugPrint('Your code: ${_confirmController1.text}');

                        if (_passController.text.length < 4 ||
                            _confirmController1.text.length < 4) {
                          Fluttertoast.showToast(
                              msg: 'please enter 4 digit passcode!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.yellow);
                        } else {
                          if (_passController.text ==
                              _confirmController1.text) {
                            storePasscode();
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    'password and ConfirmPassword Should be same',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.yellow);
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget NumPad(
      {required final double buttonSize,
      required final Color buttonColor,
      required final Color iconColor,
      required final TextEditingController controller,
      required final Function delete,
      required final Function onSubmit}) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          SizedBox(height: deviceHeight(context) * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: [
              NumberButton(
                number: 1,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 2,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 3,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          SizedBox(height: deviceHeight(context) * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 4,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 5,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 6,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          SizedBox(height: deviceHeight(context) * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 7,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 8,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 9,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          SizedBox(height: deviceHeight(context) * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: buttonColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: IconButton(
                    onPressed: () => onSubmit(),
                    icon: Icon(
                      Icons.done_rounded,
                      color: Colors.white,
                    ),
                    iconSize: deviceHeight(context) * 0.05,
                  ),
                ),
              ),
              NumberButton(
                number: 0,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: buttonColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: IconButton(
                    onPressed: () => delete(),
                    icon: Icon(
                      Icons.backspace,
                      color: Colors.white,
                    ),
                    iconSize: deviceHeight(context) * 0.048,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget NumberButton({
    required final int number,
    required final double size,
    required final Color color,
    required final TextEditingController controller,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: () {
          print(controller.text);
          if (controller.text.length < 4) {
            controller.text += number.toString();
            if (controller.text.length == 4) {
              if (widget.setPasscode.isEmpty) {
                setState(() {
                  isChange = true;
                });
                if (isChange) {
                  if (_passController.text == _confirmController1.text) {
                    storePasscode();
                  } else {
                    Fluttertoast.showToast(
                      msg: "password and ConfirmPassword Should be same",
                      backgroundColor: Colors.black45,

                      // fontSize: 25
                      // gravity: ToastGravity.TOP,
                      // textColor: Colors.pink
                    );
                  }
                }
              } else {
                if (_unlockController.text == widget.setPasscode) {
                  Fluttertoast.showToast(
                      msg: widget.isOldPasscode
                          ? 'Passcode Removed'
                          : '  success...  ',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.yellow);

                  widget.isChangePasscode
                      ? changePasscode()
                      : widget.isOldPasscode
                          ? storePasscode()
                          : Navigator.of(context).pushNamedAndRemoveUntil(
                              Homepage.route, (Route<dynamic> route) => false);
                } else {
                  Fluttertoast.showToast(
                    msg: "Incorrect password",
                    backgroundColor: Colors.black45,

                    // fontSize: 25
                    // gravity: ToastGravity.TOP,
                    // textColor: Colors.pink
                  );
                }
              }
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
