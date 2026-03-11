import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:squadbox/controllers/gameController.dart';

class EnemyText {
  final GameController gameController;
  late TextPainter painter;
  late Offset position;

EnemyText({required this.gameController}) {
  painter = TextPainter( textAlign:  TextAlign.center,
  textDirection: TextDirection.ltr );
  position = Offset.zero;

}

void render(Canvas c){
  painter.paint(c, position);
}

void update(double t){
   if ((painter.text??'')!=this.gameController.enemiesCount().toString()){
     painter.text = TextSpan( text: this.gameController.enemiesCount().toString(),
     style: TextStyle( 
     fontSize: 45.0,     
     foreground: new Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Color.fromRGBO(255,255,255,0.50),
     ),
    
    );
   
   painter.layout();
   position = 
      Offset( 
        ( this.gameController.screenSize.width - painter.width  )/ 2,
        25.0 
        );   
   }
}


}