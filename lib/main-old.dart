import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_game.dart';
 
import 'package:SquadBox/models/theme_model.dart';
import 'home_prototipo.dart';

// Se quiser rodar protitipo (rode:)
//void main() => runApp(MyApp());
GameController gameController = GameController();

void main(){
   //////Util flameUtil = Util();
   /////runApp( gameController.widget );

   VerticalDragGestureRecognizer vdrag = VerticalDragGestureRecognizer();
   vdrag.onStart = gameController.onVerticalDragStart;
   vdrag.onEnd = gameController.onVerticalDragEnd;
   vdrag.onUpdate = gameController.onVerticalDragUpdate;
   ///////flameUtil.addGestureRecognizer(vdrag);

   HorizontalDragGestureRecognizer hdrag = HorizontalDragGestureRecognizer();
   hdrag.onStart = gameController.onHorizontalDragStart;
   hdrag.onEnd = gameController.onHorizontalDragEnd;
   hdrag.onUpdate = gameController.onHorizontalDragUpdate;
   ////flameUtil.addGestureRecognizer(hdrag);

   TapGestureRecognizer tapper = TapGestureRecognizer();
   tapper.onTapDown = gameController.onTapDown;
   /////flameUtil.addGestureRecognizer(tapper);



}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

