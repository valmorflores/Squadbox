import 'dart:ui';

import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:flutter/painting.dart';

class BustedText {
  String text = 'BUSTED';
  GameController gameController;
  double posx, posy;
  double left, top;
  bool posfinal = false;
  int vezes = 50;
  bool isDead = false;
  int velocity = 7;
  double size = 10;
  double taxazoom = 0.5;
  TextPainter painter;
  TextDirection textDirection;
  Offset position;
  EnemyType enemyType;

  BustedText({this.gameController, this.left, this.top, this.enemyType: EnemyType.gangster}){
     posx = left;
     posy = top;
     painter = TextPainter( textAlign:  TextAlign.center,
     textDirection: TextDirection.ltr );
     position = Offset.zero;
  }

  void render( Canvas c ){
     if (!this.isDead){
       Rect background = Rect.fromLTWH(this.posx, this.posy, painter.width, painter.height);
       Paint backgroundPaint = Paint();
       backgroundPaint.color = Color.fromRGBO(0,0,0,0.50);
       if (this.enemyType == EnemyType.gangster )  
          backgroundPaint.color = Color.fromRGBO(0,0,0,0.50);
       if (this.enemyType == EnemyType.chefao )  
          backgroundPaint.color = Color.fromRGBO(255,0,0,0.50);
       if (this.enemyType == EnemyType.gerente )  
          backgroundPaint.color = Color.fromRGBO(0,255,0,0.50);     
       c.drawRect(background, backgroundPaint);
       painter.paint(c, position);
     }
  }

  void update( double t){
    this.posfinal = false;
    if ( this.posx > 0 ){
       this.posx = this.posx - this.velocity;
    }    
    if ( this.posy > -100 ){
       this.posy = this.posy - this.velocity;
       this.size = this.size + this.taxazoom;
    }
    else {
      this.posfinal = true;
    }
    if (this.posfinal){
        --this.vezes;
        if ( this.vezes <= 0 ){
           this.isDead = true;
        } 
    }
    // Text
    if ((painter.text??'')!=this.text){
     painter.text = TextSpan( text: this.text,
     style: TextStyle( 
     fontSize: this.size,     
     foreground: new Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 2
          ..color = Color.fromRGBO(255,255,255,0.90),
     ),
    
    );
   
   painter.layout();
   position = 
      Offset( 
        ( this.posx ),
        ( this.posy )
        );   
   }
  }

  bool destroy(){
    return ( this.posx < -100 || this.posy < -100 || this.isDead );  
  }

}