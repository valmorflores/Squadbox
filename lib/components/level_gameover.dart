import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:squadbox/components/level_heart.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/models/enum_fails.dart';

class LevelGameOverText {
  final GameController gameController;
  late TextPainter painter;
  late TextPainter painterTitle;
  late TextPainter paintersecondary;
  late TextPainter paintermotive;
  late Offset position, positionsecondary, positionmotive, positionTitle;
  late Rect respawnRect, titleRect;
  late LevelHeart levelHeart;

  LevelGameOverText({required this.gameController}) {
    painter = const TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    position = Offset.zero;
    painterTitle = const TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    paintersecondary = const TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    paintermotive = const TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    respawnRect = Rect.fromLTWH(0, 0, gameController.screenSize.width,
        gameController.screenSize.height);
    titleRect = Rect.fromLTWH(0, 0, gameController.screenSize.width,
        80);
    levelHeart = LevelHeart( gameController: this.gameController );
  }

  void render(Canvas c) {
    Paint color = Paint()..color = Color.fromRGBO(255, 0, 0, 0.90);
    c.drawRect(respawnRect, color);
    Paint colorTitle = Paint()..color = Colors.black38;
    c.drawRect(titleRect,colorTitle);
    this.painter.paint(c, this.position);
    painterTitle.paint(c, positionTitle);
    paintersecondary.paint(c, positionsecondary);
    paintermotive.paint(c, positionmotive);
    levelHeart.render(c);
  }

  void update(double t) {
    if ((painter.text ?? '') != this.gameController.score.toString()) {
      painter.text = TextSpan(
        text: ':(',
        style: TextStyle(
          color: Colors.white,
          fontSize: 120.0,
        ),
      );

      painter.layout();
      position = Offset(
        (this.gameController.screenSize.width - painter.width) / 2,
        (this.gameController.screenSize.height - 250) / 2,
        /*,
        ,*/
      );
    }
    String texto = 'Feche a tela para jogar';
    if ((paintersecondary.text ?? '') != texto) {
      paintersecondary.text = TextSpan(
        text: texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        ),
      );

      paintersecondary.layout();
      positionsecondary = Offset(
        (this.gameController.screenSize.width - paintersecondary.width) / 2,
        (this.gameController.screenSize.height) / 2 + 50,
        /*,
        ,*/
      );

      
    }

    String textoTitle = 'Clique aqui para fechar X';
    if ((painterTitle.text ?? '') !=textoTitle) {
      painterTitle.text = TextSpan(
        text: textoTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      );

      painterTitle.layout();
      positionTitle = Offset(
        (this.gameController.screenSize.width - painterTitle.width)-20,
        50,
        /*,
        ,*/
      );
    }

    String motive;

    motive = 'Você foi eliminado';
    FailsGame falha;
    falha = this.gameController.gameLevel.fail();
    motive = (falha == FailsGame.bosskilled) ? 'Você matou chefes demais' : motive;
    motive = (falha == FailsGame.managerkilled)
        ? 'Você matou gerentes demais'
        : motive;
    motive = (falha == FailsGame.enemykilled)
        ? 'Você matou inimigos demais'
        : motive;
    motive = (falha == FailsGame.refemkilled) ? 'Você matou um refém' : motive;
    motive = (falha == FailsGame.timeout) ? 'Tempo esgotado' : motive;
    motive =
        (falha == FailsGame.victimkilled) ? 'Você matou um inocente' : motive;

    if ((paintermotive.text ?? '') != motive) {
      paintermotive.text = TextSpan(
        text: motive,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      );

      paintermotive.layout();
      positionmotive = Offset(
        (this.gameController.screenSize.width - paintermotive.width) / 2,
        (this.gameController.screenSize.height) / 2 + 80,
        /*,
        ,*/
      );
    }
  }
}
