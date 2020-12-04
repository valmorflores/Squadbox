import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_coordinates.dart';
import 'package:SquadBox/models/enum_mark.dart';

import 'blocks.dart';

class Mark {
  GameController gameController;
  Rect markRect;
  MarkDirection direcaoMark;
  double left;
  double top;
  double width;
  double height;
  Color color;
  bool isDead = false;

  Mark(
      {this.gameController,
      this.left,
      this.top,
      this.width,
      this.height,
      MarkDirection direction = MarkDirection.vertical}) {
    this.direcaoMark = direction;
    double barWidth = gameController.screenSize.width * 1;

    this.color = Color.fromRGBO(255, 255, 255, 1 * 50 / 100);

    markRect = Rect.fromLTWH(left, top, width, height);
  }

  void render(Canvas c) {
    color = this.color;
    Paint markColor = Paint()..color = color;
    c.drawRect(markRect, markColor);
  }

  void update(double t) {
    double dificuldade = 10;
    double speed = gameController.tileSize * dificuldade;
    double stepDistance = speed * t;
    Offset toDirection1 = Offset(0, 0);
    Offset toDirection2 = Offset(0, 0);

    // if ( ! detectColisionBlocks() ){
    if (detectColisionLimit() && (!isDead)) {
      if (direcaoMark == MarkDirection.vertical) {
        // Enemy(direita ou esquerda)?
        if (!isDead) {
          //if (this.gameController.enemies[0].enemyRect.left<=this.markRect.left ){
          if (this
                  .gameController
                  .quadranteMaisImportanteVertical(this.markRect.left) ==
              Coordinates.left) {
            print('povo ta na esquerda');
            this.gameController.eliminaporcoordenadaLTRB( this.markRect.left, 
                 0, gameController.screenSize.width,
                  gameController.screenSize.height );
            // Block a direita           
            this.gameController.blocks.add(Blocks(
                gameController: this.gameController,
                top: 0,
                left: this.markRect.left,
                width: gameController.screenSize.width - this.markRect.left,
                height: gameController.screenSize.height,
                blockColor: Colors.pinkAccent,
                isSpoiled: false));
            this.isDead = true;
          } else {
            // Block a esquerda
            this.gameController.eliminaporcoordenadaLTRB( 0, 
                 0, 
                 this.markRect.left,
                 this.markRect.height );
            this.gameController.blocks.add(Blocks(
                gameController: this.gameController,
                top: 0,
                left: 0,
                width: this.markRect.left,
                height: this.markRect.height,
                blockColor: Colors.pinkAccent,
                isSpoiled: false));
            this.isDead = true;
          }
        }
      }
      if (direcaoMark == MarkDirection.horizontal) {
        // Enemy(acima ou abaixo)?
        if (!isDead) {
          // Inimigo acima, bloco abaixo
          if (this
                  .gameController
                  .quadranteMaisImportanteHorizontal(this.markRect.top) ==
              Coordinates.top) {

            this.gameController.eliminaporcoordenadaLTRB( 
                  0, 
                 this.markRect.top, 
                 this.gameController.screenSize.width,
                 this.gameController.screenSize.height );

            this.gameController.blocks.add(Blocks(
                gameController: this.gameController,
                top: this.markRect.top,
                left: 0,
                width: this.gameController.screenSize.width,
                height:
                    this.gameController.screenSize.height - this.markRect.top,
                blockColor: Colors.blueAccent,
                isSpoiled: false));
            this.isDead = true;
          } else {
            
            this.gameController.eliminaporcoordenadaLTRB( 
                 0, 
                 0, 
                 this.gameController.screenSize.width,
                 this.markRect.top );
            
            this.gameController.blocks.add(Blocks(
                gameController: this.gameController,
                top: 0,
                left: 0,
                width: this.gameController.screenSize.width,
                height: this.markRect.top,
                blockColor: Colors.blueAccent,
                isSpoiled: false));
            this.isDead = true;
          }
        }
      }
    } else // vai esticando a corda
    {
      int velocidade = 100;
      if (direcaoMark == MarkDirection.vertical) {
        toDirection1 = Offset(-10, 0);
        toDirection2 = Offset(10, 0);
        this.markRect = Rect.fromLTWH(
            markRect.left,
            markRect.top - (1 * velocidade),
            markRect.width,
            markRect.height + (2 * velocidade));
      } else if (direcaoMark == MarkDirection.horizontal) {
        toDirection1 = Offset(0, -10);
        toDirection2 = Offset(0, 10);
        Offset stepToPlayer =
            Offset.fromDirection(toDirection1.direction, stepDistance);
        this.markRect = Rect.fromLTWH(markRect.left - (1 * velocidade),
            markRect.top, markRect.width + (2 * velocidade), markRect.height);
      }
    }
    //}
  }

  bool detectColisionBlocks() {
    Offset posicao;
    bool lcolide = false;
    gameController.blocks.forEach((Blocks element) {
      //element.colide(enemyRect));
      posicao = Offset(markRect.left, markRect.top);

      if (element.blockRect.contains(posicao)) {
        if (direcaoMark == MarkDirection.vertical) {
          if (posicao.dy < element.blockRect.top + 10) {}
        }
        //gameController.player.currentHealt--;
        //print( 'Tocou:' + element.blockColor.toString() );
        lcolide = true;
      }
    });

    return lcolide;
  }

  bool detectColisionLimit() {
    bool lcolide = false;
    if (this.direcaoMark == MarkDirection.vertical) {
      lcolide = (this.markRect.top <= 0);
      lcolide = (lcolide &&
          this.markRect.height >= this.gameController.screenSize.height);
    } else {
      lcolide = (this.markRect.left <= 0);
      lcolide = (lcolide &&
          this.markRect.right >= this.gameController.screenSize.width);
    }
    return lcolide;
  }
}
