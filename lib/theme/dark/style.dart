import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xff1f655d),
    colorScheme:
        ThemeData.dark().colorScheme.copyWith(secondary: const Color(0xff40bf7a)),
    textTheme: const TextTheme(
        /*title: TextStyle(color: Color(0xff40bf7a)),
        subtitle: TextStyle(color: Colors.white),
        subhead: TextStyle(color: Color(0xff40bf7a))*/
        ),

    // floatingActionButtonTheme:
    //     FloatingActionButtonThemeData(backgroundColor: Color(0xff40bf7a),),
    appBarTheme: const AppBarTheme(color: Color(0xff1f655d)));
