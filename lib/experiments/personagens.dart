import 'dart:ui';

import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/main-old.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class PersonagensGame extends StatefulWidget {
  GameController gameController;
  PersonagensGame({gameController, Key key}) : super(key: key);

  @override
  State<PersonagensGame> createState() => PersonagensGameState();
}

class PersonagensGameState extends State<PersonagensGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personagens'),
          actions: [
            InkWell(
                onTap: () {
                  gameController.resumeEngine();
                },
                child: Icon(Icons.play_arrow)),
            InkWell(
                onTap: () {
                  gameController.pauseEngine();
                },
                child: Icon(Icons.pause)),
            InkWell(
                onTap: () {
                  gameController.restartRun();
                },
                child: Icon(Icons.refresh))
          ],
        ),
        body: GameWidget(game: gameController));
  }
}

class ComposabilityExample extends FlameGame {
  static const String description = '''
    In this example we showcase how you can add children to a component and how
    they transform together with their parent, if the parent is a
    `PositionComponent`. This example is not interactive.
  ''';

  ParentSquare parentSquare;

  @override
  bool debugMode = true;

  @override
  Future<void> onLoad() async {
    parentSquare = ParentSquare(Vector2.all(200), Vector2.all(300))
      ..anchor = Anchor.center;
    add(parentSquare);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parentSquare.angle += dt;
  }
}

class ParentSquare extends RectangleComponent with HasGameRef {
  static final defaultPaint = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke;

  ParentSquare(Vector2 position, Vector2 size)
      : super(
          position: position,
          size: size,
          paint: defaultPaint,
        );

  @override
  Future<void> onLoad() async {
    createChildren(gameController);
  }

  void createChildren(gameController) {
    // All positions here are in relation to the parent's position
    const childSize = 50.0;

    gameController.enemies.add(Enemy(
        gameController: gameController,
        difficulty: 10,
        isFree: false,
        enemyType: EnemyType.chefao,
        x: 10,
        y: 10));

    
  }
}
