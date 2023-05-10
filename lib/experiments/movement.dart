import 'dart:ui';

import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/main-old.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class MovementGame extends StatefulWidget {
  
  MovementGame({Key key}) : super(key: key);

  @override
  State<MovementGame> createState() => MovementGameState();
}

class MovementGameState extends State<MovementGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movement'),
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
        body: GameWidget(game: BoxGame()));
  }
}
  

class BoxGame extends FlameGame {
  final List<Box> boxes = [];

  BoxGame() {
    boxes.add(Box(0, 0));
    boxes.add(Box(290, 0));
    boxes.add(Box(0, 290));
    boxes.add(Box(290, 290));
    add(Box(0, 0));
    add(Box(290, 0));
    add(Box(0, 290));
    add(Box(290, 290));
    add(Square(150, 150));
    add(Square(200, 200));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    boxes.forEach((box) => box.render(canvas));
  }

  @override
  void update(double t) {
    super.update(t);
    boxes.forEach((box) => box.update(t));
  }
}


class Box extends Component with HasGameRef<FlameGame> {
  Vector2 velocity;
  static const SIZE = 10.0;
  Rect _rect;
  Paint _paint;

  Box(double x, double y) {
    _rect = Rect.fromLTWH(x, y, SIZE, SIZE);
    _paint = Paint()..color = Color(0xFFCCCCCC);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(_rect, _paint);
  }

  @override
  void update(double t) {
    if (_rect.left <= 0 || _rect.right >= gameRef.size.x) {
      velocity = Vector2(-velocity.x, velocity.y);
    }
    if (_rect.top <= 0 || _rect.bottom >= gameRef.size.y) {
      velocity = Vector2(velocity.x, -velocity.y);
    }
    _rect = _rect.translate(velocity.x * t, velocity.y * t);
  }
}

class Square extends Component with HasGameRef<FlameGame> {
  Vector2 velocity;
  static const SIZE = 3.0;
  Rect _rect;
  Paint _paint;

  Square(double x, double y) {
    _rect = Rect.fromLTWH(x, y, SIZE, SIZE);
    _paint = Paint()..color = Color(0xFFFF0000);
    velocity = Vector2(150, 100);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(_rect, _paint);
  }

  @override
  void update(double t) {
    final game = this.game as BoxGame;
    if (_rect.left <= 0 || _rect.right >= gameRef.size.x) {
      velocity = Vector2(-velocity.x, velocity.y);
    }
    if (_rect.top <= 0 || _rect.bottom >= gameRef.size.y) {
      velocity = Vector2(velocity.x, -velocity.y);
    }
    _rect = _rect.translate(velocity.x * t, velocity.y * t);
    game.boxes.forEach((box) {
      if (_rect.overlaps(box._rect)) {
        velocity = Vector2(-velocity.x, -velocity.y);
      }
    });
  }
}