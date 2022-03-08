class PreferenceModel {
  String _themeColor = "";
  String _themeFontFamily = "";
  String _themeFontFamilySelected = "";
  String _fontSize = "";
  String passcode = "";

  PreferenceModel();

  PreferenceModel.fromJson(Map<String, dynamic> json)
      : _themeColor = json['themeColorData'],
        _themeFontFamily = json['themeFontFamilyData'],
        _themeFontFamilySelected = json['themeFontFamilySelectedData'],
        _fontSize = json['fontSizeData'],
        passcode = json['passcode'];

  Map<String, dynamic> toJson() => {
        'themeColorData': _themeColor,
        'themeFontFamilyData': _themeFontFamily,
        'themeFontFamilySelectedData': _themeFontFamilySelected,
        'fontSizeData': _fontSize,
        'passcode': passcode
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

  String get themeFontData => _fontSize;

  set themeFont(String value) {
    _fontSize = value;
  }

  String get getPasscodeData => passcode;

  set setPasscode(String value) {
    passcode = value;
  }

  @override
  String toString() {
    return 'PreferenceModel{_themeColor: $_themeColor, _themeFontFamily: $_themeFontFamily, _themeFontFamilySelected: $_themeFontFamilySelected, _fontSize: $_fontSize, passcode: $passcode}';
  }
}
