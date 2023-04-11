import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:SquadBox/controllers/gameController.dart';

class LevelWaitText {
  
 final GameController gameController;
 TextPainter painter;
 TextPainter paintersecondary;
 Offset position, positionsecondary;
 Rect respawnRect;

LevelWaitText( {this.gameController} ){
  painter = TextPainter( textAlign:  TextAlign.center,
  textDirection: TextDirection.ltr );
  position = Offset.zero;
  paintersecondary = TextPainter( textAlign:  TextAlign.center,
  textDirection: TextDirection.ltr );
  respawnRect = Rect.fromLTWH( 0, 0, gameController.screenSize.width, gameController.screenSize.height );
}

void render(Canvas c){
  Paint color = Paint()..color = Color.fromRGBO(0, 0, 0, 0.70);
     c.drawRect(respawnRect, color);
  painter.paint(c, position);
  paintersecondary.paint(c, positionsecondary);
   
}

void update(double t){
   if ((painter.text??'')!=this.gameController.score.toString()){
     painter.text = TextSpan( text: this.gameController.level.toString(),
     style: TextStyle( color: Colors.white,
     fontSize: 120.0,
     ),
    
    );
   
   painter.layout();
   position = 
      Offset( 
        ( this.gameController.screenSize.width - painter.width ) / 2, 
        (this.gameController.screenSize.height-100)/2,
        /*,
        ,*/
        );
   
   }
   String texto = 'Clique na tela para capturar';
   if ((paintersecondary.text??'')!=texto){
     paintersecondary.text = TextSpan( text: texto,
     style: TextStyle( color: Colors.white,
     fontSize: 22.0,
     ),
    
    );
   
   paintersecondary.layout();
   positionsecondary = 
      Offset( 
        ( this.gameController.screenSize.width - paintersecondary.width ) / 2, (this.gameController.screenSize.height)/2+100,
        /*,
        ,*/
        );
   
   }


}


}