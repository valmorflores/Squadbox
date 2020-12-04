import 'dart:ui';

import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_enemy.dart';

class LevelPercent {

  GameController gameController;
  Rect rectPercentual;
  int perc = 0;
  double nCiclos = 0;

  LevelPercent({this.gameController}){
     this.nCiclos = 0;
     rectPercentual = Rect.fromLTWH( 
         0, 
         this.gameController.screenSize.height, 
         this.gameController.screenSize.width, 
         this.gameController.screenSize.height);

  }

  void render(Canvas c){
    double nI=0.10;
    Paint useblockColor = Paint()..color = Color.fromRGBO( 0, 0, 0, nI );
    c.drawRect( rectPercentual, useblockColor);
  }

  void update(double t){

     double ocupacao = this.gameController.gameLevel.ocupacao();
     double objetivo = this.gameController.gameLevel.percentual;
     double atingido = ( ocupacao / objetivo ) * 100; 
     //atingido = 40;
     double nTop  = this.gameController.screenSize.height * atingido /100;
    
     nTop = this.gameController.screenSize.height - nTop;
     rectPercentual = Rect.fromLTWH( 
         0, 
         nTop, 
         gameController.screenSize.width,
         gameController.screenSize.height - nTop);
  }


}