import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:squadbox/controllers/gameController.dart';

class LevelHeart {
  final GameController gameController;

  Image? imageHeartGrey, imageHeartRed;

  LevelHeart({required this.gameController}) {
    // this.imageHeartRed =
    //     Flame.images.load('assets/images/heart_red.png');

    Flame.images.load('heart_red.png').then((Image image) {
      imageHeartRed = image;
    });

    Flame.images.load('heart_grey.png').then((Image image) {
      imageHeartGrey = image;
    });

  }

  void render(Canvas c) {
    double width = 50, height = 50;
    double space = 20;
    double left = ( this.gameController.screenSize.width - (width*3) - space*2 ) /2;
    if (imageHeartRed != null && imageHeartGrey != null) {
      var paint = Paint()..color = Color(0xffffffff);
      var inputrect = Rect.fromLTWH(
          0.0,
          0.0,
          imageHeartRed!.width.toDouble(),
          imageHeartRed!.height.toDouble());
      // Heart live one
      var rect = Rect.fromLTWH( left, 150.0, width, height);
      c.drawImageRect(
        this.gameController.lifes >= 1 ? imageHeartRed! : imageHeartGrey!,
        inputrect,
        rect,
        paint,
      );
      left = left + 20 + width;
      // Heart live two
      rect = Rect.fromLTWH( left, 150.0, width, height);
      c.drawImageRect(
        this.gameController.lifes >= 2 ? imageHeartRed! : imageHeartGrey!,
        inputrect,
        rect,
        paint,
      );
      left = left + 20 + width;
      // Heart live three
      var rectGrey = Rect.fromLTWH( left, 150.0, width, height);
      c.drawImageRect(
        this.gameController.lifes >= 3 ? imageHeartRed! : imageHeartGrey!,
        inputrect,
        rectGrey,
        paint,
      );
      left = left + 20 + width;
    }
  }
}
