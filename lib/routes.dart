import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_diary_app/resources/colors.dart';
import 'package:life_diary_app/screens/lock_screen.dart';
import 'package:life_diary_app/screens/note_screen.dart';
import 'package:life_diary_app/screens/photoviewscreen.dart';
import 'package:life_diary_app/screens/rootpage.dart';
import 'package:life_diary_app/screens/searchscreen.dart';
import 'package:life_diary_app/screens/settingscreen.dart';
import 'package:life_diary_app/screens/splashscreen.dart';

import 'blocs/fontfamily/font_family_bloc.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  final arguments = routeSettings.arguments;
  print(arguments);
  // print(arguments);
  //  print('color$getcolor()');
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => Splashscreen(),
      );
    case Homepage.route:
      return MaterialPageRoute(
        builder: (_) => Homepage(),
      );
    case SearchScreen.route:
      return MaterialPageRoute(
        builder: (_) => SearchScreen(
          color: arguments,
        ),
      );

    case GallryScreen.route:
      return MaterialPageRoute(
        builder: (_) => GallryScreen(
          color: arguments,
        ),
      );
    case SettingScreen.route:
      return MaterialPageRoute(
        builder: (_) => SettingScreen(
          color: Colors.pinkAccent,
        ),
      );
    case NoteScreen.route:
      return MaterialPageRoute(builder: (_) => NoteScreen());

    case LockScreen.route:
      return MaterialPageRoute(builder: (_) => LockScreen());

    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}
