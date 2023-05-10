import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'dart:math' as math;

class MovementGame extends StatefulWidget {
  MovementGame({Key key}) : super(key: key);

  @override
  State<MovementGame> createState() => MovementGameState();
}

class MovementGameState extends State<MovementGame> {
  @override
  Widget build(BuildContext context) {
    BoxGameMain _game = BoxGameMain();
    return Scaffold(
        appBar: AppBar(
          title: Text('Movement'),
        ),
        body: GestureDetector(
          onTapDown: (details) => _game.onTapDown(details),
          child: GameWidget(game: _game)));
  }
}

class BoxGameMain extends FlameGame with HasCollisionDetection {
  static const description = '''
    This example shows how you can use the Collisions detection api to know when a ball
    collides with the screen boundaries and then update it to bounce off these boundaries.
  ''';
  @override
  void onLoad() {
    addAll([
      ScreenHitbox(),
      Ball(),
      FixedBox(10.0, 10.0),
      FixedBox(30.0, 30.0),
      FixedBox(40.0, 40.0),
      FixedBox(100.0, 100.0),
      FixedBox(130.0, 30.0),
      FixedBox(170.0, 80.0),
      FixedBox(300.0, 300.0),
    ]);
  }

  @override
  void onTapDown(TapDownDetails d) {
    add(FixedBox(d.globalPosition.dx, d.globalPosition.dy));
  }

}

/* FixedBox */

class FixedBox extends CircleComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  Vector2 velocity;
  final paint3 = Paint()..color = const Color(0xffb372dc);
  double positionX = 0;
  double positionY = 0;

  FixedBox(x, y) {
    paint = Paint()..color = Colors.red;
    radius = 10;
    positionX = x;
    positionY = y;
  }

  static const double speed = 500;
  static const degree = math.pi / 180;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //_resetBall;
    final hitBox = CircleHitbox(
      radius: radius,
    );

    addAll([
      hitBox,
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = Vector2(positionX, positionY);
  }

  
}

/* Ball */
class Ball extends CircleComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  Vector2 velocity;
  final paint3 = Paint()..color = const Color(0xffb372dc);

  Ball() {
    paint = Paint()..color = Colors.yellow;
    radius = 10;
  }

  static const double speed = 500;
  static const degree = math.pi / 180;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _resetBall;
    final hitBox = CircleHitbox(
      radius: radius,
    );

    addAll([
      hitBox,
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  void get _resetBall {
    position = gameRef.size / 2;
    final spawnAngle = getSpawnAngle;

    final vx = math.cos(spawnAngle * degree) * speed;
    final vy = math.sin(spawnAngle * degree) * speed;
    velocity = Vector2(
      vx,
      vy,
    );
  }

  double get getSpawnAngle {
    final random = math.Random().nextDouble();
    final spawnAngle = lerpDouble(0, 360, random);

    return spawnAngle;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is ScreenHitbox) {
      final collisionPoint = intersectionPoints.first;

      // Left Side Collision
      if (collisionPoint.x == 0) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Right Side Collision
      if (collisionPoint.x == gameRef.size.x) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Top Side Collision
      if (collisionPoint.y == 0) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      // Bottom Side Collision
      if (collisionPoint.y == gameRef.size.y) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
    }

    // OUTRA COLISAO COM OUTRA BOLA
    if (other is FixedBox) {
      final collisionPoint = intersectionPoints.first;
      debugPrint('Colidiu com outra bola fixa');
      debugPrint(
          'Target: [${other.position.x},${other.position.y}] Ball: [${collisionPoint.x},${collisionPoint.y}]');
      // Left Side Collision
      if (collisionPoint.x >= other.position.x) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Right Side Collision
      if (collisionPoint.x <= other.position.x) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Top Side Collision
      if (collisionPoint.y >= other.position.y) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      // Bottom Side Collision
      if (collisionPoint.y <= other.position.y) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
    }
  }
}





/*  
class BoxGame extends FlameGame with TapDetector {
  List<Rect> squares;
  List<Component> boxes;

  @override
  Future<void> onLoad() async {
    squares = [
      Rect.fromLTWH(0, 0, 40, 40),
      Rect.fromLTWH(size.x - 40, 0, 40, 40),
      Rect.fromLTWH(0, size.y - 40, 40, 40),
      Rect.fromLTWH(size.x - 40, size.y - 40, 40, 40),
    ];

    boxes = [
      Box(20, const Color(0xFFFF0000)),
      Box(20, const Color(0xFF00FF00)),
      Box(20, const Color(0xFF0000FF)),
    ];

    boxes.forEach((box) => add(box));
  }

  @override
  void onTapDown(TapDownInfo info) {
    final box = Box(20, const Color(0xFFFF00FF));
    box.x = info.eventPosition.game.x;
    box.y = info.eventPosition.game.y;
    add(box);
    super.onTapDown(info);
  }

  @override
  void update(double dt) {
    super.update(dt);
/*
    for (final box in boxes) {
      if (box.toRect().overlaps(squares[0])) {
        box.direction = Vector2(-1.0, -1.0);
      } else if (box.toRect().overlaps(squares[1])) {
        box.direction = Vector2(1.0, -1.0);
      } else if (box.toRect().overlaps(squares[2])) {
        box.direction = Vector2(-1.0, 1.0);
      } else if (box.toRect().overlaps(squares[3])) {
        box.direction = Vector2(1.0, 1.0);
      }

      if (box.x < 0 || box.x > size.x - box.width) {
        box.direction = Vector2(-box.direction.x, box.direction.y);
      }

      if (box.y < 0 || box.y > size.y - box.height) {
        box.direction = Vector2(box.direction.x, -box.direction.y);
      }
    }
    */
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = const Color(0xFF000000)
      ..style = PaintingStyle.stroke;

    for (final square in squares) {
      canvas.drawRect(square.deflate(1), paint);
    }
  }
}


class Box extends PositionComponent with HasGameRef<BoxGame> {
  static final Random _random = Random();
  
  Paint _paint;
  
  double _speed;
  
  Vector2 direction;

  Box(double size, Color color) {
    _paint = Paint()..color = color;
    _speed = _random.nextDouble() * (300 - size * sqrt2);
   
    direction = Vector2(_random.nextDouble() * sqrt2 - sqrt2 / 2,
            _random.nextDouble() * sqrt2 - sqrt2 / 2);
    width = height = size;
    
    x = _random.nextDouble() * gameRef.size.x;
    
    y = _random.nextDouble() * gameRef.size.y;
    
    anchor = Anchor.center;
    
    //addShape(HitboxRectangle());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    x += direction.x * _speed * dt;
    y += direction.y * _speed * dt;
  }
}
*/




// class BoxGame extends FlameGame {
//   final List<Box> boxes = [];

//   BoxGame() {
//     boxes.add(Box(0, 0));
//     boxes.add(Box(290, 0));
//     boxes.add(Box(0, 290));
//     boxes.add(Box(290, 290));
//     add(Box(0, 0));
//     add(Box(290, 0));
//     add(Box(0, 290));
//     add(Box(290, 290));
//     add(Square(150, 150));
//     add(Square(200, 200));
//   }

//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     boxes.forEach((box) => box.render(canvas));
//   }

//   @override
//   void update(double t) {
//     super.update(t);
//     boxes.forEach((box) => box.update(t));
//   }
// }


// class Box extends Component with HasGameRef<FlameGame> {
//   Vector2 velocity;
//   static const SIZE = 10.0;
//   Rect _rect;
//   Paint _paint;

//   Box(double x, double y) {
//     _rect = Rect.fromLTWH(x, y, SIZE, SIZE);
//     _paint = Paint()..color = Color(0xFFCCCCCC);
//   }

//   @override
//   void render(Canvas canvas) {
//     canvas.drawRect(_rect, _paint);
//   }

//   @override
//   void update(double t) {
//     if (_rect.left <= 0 || _rect.right >= gameRef.size.x) {
//       velocity = Vector2(-velocity.x, velocity.y);
//     }
//     if (_rect.top <= 0 || _rect.bottom >= gameRef.size.y) {
//       velocity = Vector2(velocity.x, -velocity.y);
//     }
//     _rect = _rect.translate(velocity.x * t, velocity.y * t);
//   }
// }

// class Square extends Component with HasGameRef<FlameGame> {
//   Vector2 velocity;
//   static const SIZE = 3.0;
//   Rect _rect;
//   Paint _paint;

//   Square(double x, double y) {
//     _rect = Rect.fromLTWH(x, y, SIZE, SIZE);
//     _paint = Paint()..color = Color(0xFFFF0000);
//     velocity = Vector2(150, 100);
//   }

//   @override
//   void render(Canvas canvas) {
//     canvas.drawRect(_rect, _paint);
//   }

//   @override
//   void update(double t) {
//     final game = this.game as BoxGame;
//     if (_rect.left <= 0 || _rect.right >= gameRef.size.x) {
//       velocity = Vector2(-velocity.x, velocity.y);
//     }
//     if (_rect.top <= 0 || _rect.bottom >= gameRef.size.y) {
//       velocity = Vector2(velocity.x, -velocity.y);
//     }
//     _rect = _rect.translate(velocity.x * t, velocity.y * t);
//     game.boxes.forEach((box) {
//       if (_rect.overlaps(box._rect)) {
//         velocity = Vector2(-velocity.x, -velocity.y);
//       }
//     });
//   }
// }