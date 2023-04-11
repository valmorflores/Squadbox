import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:SquadBox/controllers/gameController.dart';

class LevelHeart {
  GameController gameController;

  Image imageHeartGrey, imageHeartRed;
  LevelHeart({this.gameController}) {
    // this.imageHeartRed =
    //     Flame.images.load('assets/images/heart_red.png');

    Flame.images.load('heart_red.png').then((Image image) {
      this.imageHeartRed = image;
    });

    Flame.images.load('heart_grey.png').then((Image image) {
      this.imageHeartGrey = image;
    });

  }

  void render(Canvas c) {
    double width = 50, height = 50;
    double space = 20;
    double left = ( this.gameController.screenSize.width - (width*3) - space*2 ) /2;
    if (this.imageHeartRed != null) {
      var paint = Paint()..color = Color(0xffffffff);
      var inputrect = Rect.fromLTWH(
          0.0,
          0.0,
          this.imageHeartRed.width.toDouble(),
          this.imageHeartRed.height.toDouble());
      // Heart live one
      var rect = Rect.fromLTWH( left, 150.0, width, height);
      c.drawImageRect(this.gameController.lifes >=1? this.imageHeartRed:this.imageHeartGrey, inputrect, rect, paint);
      left = left + 20 + width;
      // Heart live two
      rect = Rect.fromLTWH( left, 150.0, width, height);
      c.drawImageRect(this.gameController.lifes >=2?this.imageHeartRed:this.imageHeartGrey, inputrect, rect, paint);
      left = left + 20 + width;
      // Heart live three
      var rectGrey = Rect.fromLTWH( left, 150.0, width, height);
      c.drawImageRect(this.gameController.lifes >=3?this.imageHeartRed:this.imageHeartGrey, inputrect, rectGrey, paint);
      left = left + 20 + width;
    }
  }
}
