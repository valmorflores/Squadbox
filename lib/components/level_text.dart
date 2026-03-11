import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:squadbox/controllers/gameController.dart';

class LevelText {
  final GameController gameController;
  late TextPainter painter;
  late Offset position;

LevelText({required this.gameController}) {
  painter = TextPainter( textAlign:  TextAlign.right,
  textDirection: TextDirection.ltr );
  this.position = Offset.zero;

}

void render(Canvas c){
  painter.paint(c, position);
}

void update(double t){
   if ((painter.text??'')!=this.gameController.level.toString()){
     painter.text = TextSpan( text: this.gameController.level.toString(),
     style: TextStyle( color: Colors.white.withAlpha(100),
     fontSize: 36.0,
     ),
    
    );
   
   painter.layout();
   position = 
      Offset( 
        this.gameController.screenSize.width -20 - painter.width,
        40.0 
        );
   
   }
}


}