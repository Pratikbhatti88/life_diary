import 'package:flutter/cupertino.dart';
import 'package:life_diary_app/resources/colors.dart';

class PreferenceModel {
  String _themeColor = "";
  String _themeFontFamily = "";
  String _themeFontFamilySelected = "";
  dynamic _fontSize="";

  PreferenceModel();

  PreferenceModel.fromJson(Map<String, dynamic> json)
      : _themeColor = json['themeColorData'],
        _themeFontFamily = json['themeFontFamilyData'],
        _themeFontFamilySelected = json['themeFontFamilySelectedData'],
        _fontSize=json['fontSizeData'];

  Map<String, dynamic> toJson() => {
        'themeColorData': _themeColor,
        'themeFontFamilyData': _themeFontFamily,
        'themeFontFamilySelectedData': _themeFontFamilySelected,
        'fontSizeData':_fontSize
      };

  String get themeColorData => _themeColor;

  set themeColor(String value) {
    _themeColor = value;
  }

  String get themeFontFamilyData => _themeFontFamily;

  set themeFontFamily(String value) {
    _themeFontFamily = value;
  }

  String get themeFontFamilySelectedData => _themeFontFamilySelected;

  set themeFontFamilySelected(String value) {
    _themeFontFamilySelected = value;

  }

  dynamic get themeFontData => _fontSize;

  set themeFont(dynamic value) {
    _fontSize = value;
  }


  @override
  String toString() {
    return 'PreferenceModel{_themeColor: $_themeColor, _themeFontFamily: $_themeFontFamily, _themeFontFamilySelected: $_themeFontFamilySelected, _fontSize: $_fontSize}';
  }
}
