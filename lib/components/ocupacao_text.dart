import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_state.dart';

class OcupacaoText {
  
 final GameController gameController;
 TextPainter painter;
 TextPainter painterobjetivo;
 Offset position;
 Offset positionobjetivo;
 Rect ocupacaoRect;
 Rect ocupacaoEvolutionRect;
 Rect objectivoRect;
 double espaco = 80;
 double altura = 30;
 double posicaotop = 10;
 double posicaoleft =  10;
 

OcupacaoText( {this.gameController} ){
  painter = TextPainter( textAlign:  TextAlign.right,
  textDirection: TextDirection.ltr );
  position = Offset.zero;
  painterobjetivo = TextPainter( textAlign:  TextAlign.right,
  textDirection: TextDirection.ltr ); 
  ocupacaoRect = Rect.fromLTWH( this.posicaoleft, this.posicaotop, this.espaco, this.altura );
  ocupacaoEvolutionRect = Rect.fromLTWH( this.posicaoleft, this.posicaotop, 1, 1 );
  objectivoRect =  Rect.fromLTWH( this.posicaoleft + this.espaco - 10, this.posicaotop + 20, 20, 20 );
  positionobjetivo = Offset( this.posicaoleft + this.espaco - 8, this.posicaotop + 22 );
  //painterobjetivo.text = TextSpan( text: this.gameController.gameLevel.percentual.toStringAsPrecision(2) );
}

void render(Canvas c){

  Paint color = Paint()..color = Color.fromRGBO(0, 0, 0, 0.50);
  c.drawRect(ocupacaoRect, color);

  Paint colorEvol = Paint()..color = Color.fromRGBO( 255,255,255, 0.50);
  c.drawRect(ocupacaoEvolutionRect, colorEvol);

  if ( this.gameController.state == StateGame.playing ){
    Paint colorObjetivo = Paint()..color = Colors.red;
    c.drawRect(objectivoRect, colorObjetivo );
    painterobjetivo!=null?painterobjetivo.paint(c, positionobjetivo):null;
  }
  painter!=null?painter.paint(c, position):null;

}

void update(double t){

   double evolucao = 100 * ( this.gameController.gameLevel.ocupacao() / this.gameController.gameLevel.percentual );
   double espacoevol = 80 * (evolucao/100);
   ocupacaoEvolutionRect = Rect.fromLTWH( this.posicaoleft, this.posicaotop, espacoevol, this.altura );

   if ((painter.text??'')!=this.gameController.gameLevel.ocupacao().toStringAsPrecision(2)+'%'){
     painter.text = TextSpan( text: this.gameController.gameLevel.ocupacao().toStringAsPrecision(2)+'%',
     style: TextStyle( color: Colors.black,
     fontSize: 20.0,
     ),
    
    );
   
  painter.layout();
   position = 
      Offset( 
        30,
        15.0 
        );
   
   
   if ((painterobjetivo.text??'')!=this.gameController.gameLevel.percentual.toStringAsPrecision(2)){
     painterobjetivo.text = TextSpan( text: this.gameController.gameLevel.percentual.toStringAsPrecision(2),
     style: TextStyle( color: Colors.white,
     fontSize: 14.0,
     ),
    
    );
   }
   painterobjetivo.layout();

   
   }
}


}