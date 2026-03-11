import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color(0xfff5f5f5),
    colorScheme:
        ThemeData.light().colorScheme.copyWith(secondary: const Color(0xff40bf7a)),
    textTheme: const TextTheme(
        //title: TextStyle(color: Colors.black54),
        //subtitle: TextStyle(color: Colors.grey),
        //subhead: TextStyle(color: Colors.white)),
        ),
    appBarTheme: const AppBarTheme(
        color: Color(0xff1f655d),
        actionsIconTheme: IconThemeData(color: Colors.white)));
