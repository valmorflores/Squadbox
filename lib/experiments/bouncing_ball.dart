import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_noise/flame_noise.dart';

class BouncingBallGame extends StatefulWidget {
  const BouncingBallGame({Key key}) : super(key: key);

  @override
  State<BouncingBallGame> createState() => _BouncingBallGameState();
}

class _BouncingBallGameState extends State<BouncingBallGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bouncing Ball')),
        body: GameWidget(game: BouncingBall()));
  }
}

class BouncingBall extends FlameGame with HasCollisionDetection {
  static const description = '''
    This example shows how you can use the Collisions detection api to know when a ball
    collides with the screen boundaries and then update it to bounce off these boundaries.
  ''';
  @override
  void onLoad() {
    addAll([
      ScreenHitbox(),
      Ball(),
    ]);
  }
}

class Ball extends CircleComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  Vector2 velocity;
  final paint3 = Paint()..color = const Color(0xffb372dc);

  Ball() {
    paint = Paint()..color = Colors.white;
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
  }
}
