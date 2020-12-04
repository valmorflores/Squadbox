import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:SquadBox/controllers/gameController.dart';

class ScoreText {
  
 final GameController gameController;
 TextPainter painter;
 Offset position;

ScoreText( {this.gameController} ){
  painter = TextPainter( textAlign:  TextAlign.right,
  textDirection: TextDirection.ltr );
  this.position = Offset.zero;

}

void render(Canvas c){
  painter!=null?painter.paint(c, position):null;
}

void update(double t){
   if ((painter.text??'')!=this.gameController.score.toString()){
     painter.text = TextSpan( text: this.gameController.score.toString(),
     style: TextStyle( color: Colors.black,
     fontSize: 20.0,
     ),
    
    );
   
   painter.layout();
   position = 
      Offset( 
        this.gameController.screenSize.width -70,
        15.0 
        );
   
   }
}


}