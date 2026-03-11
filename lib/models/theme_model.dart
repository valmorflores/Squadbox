import 'package:flutter/material.dart';
import 'package:squadbox/models/enum_themetype.dart';
import 'package:squadbox/theme/dark/style.dart';
import 'package:squadbox/theme/default/style.dart';
import 'package:squadbox/theme/light/style.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = defaultTheme;
  ThemeType _themeType = ThemeType.Dark;

  toggleTheme() {
    if (_themeType == ThemeType.Default) {
      currentTheme = defaultTheme;
      _themeType = ThemeType.Light;      
      return notifyListeners();
    }

    if (_themeType == ThemeType.Dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.Light) {
      currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}

//use: Theme.of(context).textTheme.title.color