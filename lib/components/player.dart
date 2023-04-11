import 'dart:ui';
import 'package:SquadBox/controllers/gameController.dart';

class Player {

  final GameController gameController;
  int maxHealt = 1024;
  int currentHealt = 1024;
  Rect playerRect;
  bool isDead = false;
  final double size = 5;

  Player( this.gameController ){
    maxHealt = currentHealt = 300;
    playerRect = Rect.fromLTWH( 5, 5, size, size );
  }

  void render( Canvas c ){
     Paint color = Paint()..color = Color.fromRGBO(17, 17, 17, 1);
     c.drawRect(playerRect, color);
   }

   void update( double t ){

   }

}
