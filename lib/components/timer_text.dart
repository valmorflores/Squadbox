import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:SquadBox/controllers/gameController.dart';

class TimerText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  TimerText({this.gameController}) {
    painter = TextPainter(
        textAlign: TextAlign.right, textDirection: TextDirection.ltr);
    this.position = Offset.zero;
  }

  void render(Canvas c) {
    painter != null ? painter.paint(c, position) : null;
  }

  void update(double t) {
    if ((painter.text ?? '') != this.gameController.elapsedSecs.toString()) {
      painter.text = TextSpan(
        text: this.gameController.elapsedSecs.toString(),
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.3),
          fontSize: 16.0,
        ),
      );

      painter.layout();
      position = Offset(
          this.gameController.screenSize.width - 20 - painter.width, 90.0);
    }
  }
}
