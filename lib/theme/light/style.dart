import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xfff5f5f5),
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(
        //title: TextStyle(color: Colors.black54),
        //subtitle: TextStyle(color: Colors.grey),
        //subhead: TextStyle(color: Colors.white)),
        ),
    appBarTheme: AppBarTheme(
        color: Color(0xff1f655d),
        actionsIconTheme: IconThemeData(color: Colors.white)));
