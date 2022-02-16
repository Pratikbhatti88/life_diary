
import 'dart:convert';
import 'package:life_diary_app/models/preference_model.dart';
import 'package:life_diary_app/resources/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  addData(PreferenceModel themeData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userdata = jsonEncode(themeData);
    print(userdata);
    prefs.setString(themeDataKey, userdata);

  }


  Future<PreferenceModel?> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsondetails =
    jsonDecode(prefs.getString(themeDataKey)!);
    PreferenceModel themeData = PreferenceModel.fromJson(jsondetails);
    return themeData;
  }




}
