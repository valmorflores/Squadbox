import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:SquadBox/controllers/gameController.dart';

class HealthBar {

  final GameController gameController;
  Rect healthBarRect;
  Rect progressBarRect;
  double _barWidth;
  double _postop = 0; // gameController.screenSize.height-5

  HealthBar({this.gameController}){
    double barWidth = gameController.screenSize.width * 1;
    this._barWidth = barWidth;
    healthBarRect = Rect.fromLTWH(
         ( this.gameController.screenSize.width - barWidth ) / 2, 
         this._postop, barWidth, 5 );

    progressBarRect = Rect.fromLTWH(
         ( gameController.screenSize.width - barWidth ) / 2, 
         this._postop, barWidth, 5 );

  }

  void render( Canvas c ){
     Paint healthBarColor = Paint()..color = Colors.black54;
     Paint healthProgressBarColor = Paint()..color = Colors.greenAccent;
     c.drawRect(healthBarRect, healthBarColor);
     c.drawRect(progressBarRect, healthProgressBarColor);
  }

  void update( double t ){
     double percent = this.gameController.player.currentHealt / this.gameController.player.maxHealt;
     double barWidth = this._barWidth * percent;
     progressBarRect = Rect.fromLTWH( 
         ( this.gameController.screenSize.width - this._barWidth ) / 2, 
           this._postop, barWidth, 5 );
  }


}