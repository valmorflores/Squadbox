import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:SquadBox/controllers/gameController.dart';

class HealthText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  HealthText({this.gameController}) {
    painter = TextPainter(
        textAlign: TextAlign.right, textDirection: TextDirection.ltr);
    this.position = Offset.zero;
  }

  void render(Canvas c) {
    painter != null ? painter.paint(c, position) : null;
  }

  void update(double t) {
    double percent = this.gameController.player.currentHealt / 1;
    if ((painter.text ?? '') != percent.toString()) {
      painter.text = TextSpan(
        text: percent.toString() + '%',
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 16.0,
        ),
      );

      painter.layout();
      position = Offset(
          this.gameController.screenSize.width - 20 - painter.width, 10.0);
    }
  }
}
