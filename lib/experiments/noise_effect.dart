import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_noise/flame_noise.dart';

class NoiseEffectGame extends StatefulWidget {
  const NoiseEffectGame({Key key}) : super(key: key);

  @override
  State<NoiseEffectGame> createState() => _NoiseEffectGameState();
}

class _NoiseEffectGameState extends State<NoiseEffectGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Noise Effect')),
        body: GameWidget(game: NoiseEffect()));
  }
}

class NoiseEffect extends FlameGame with HasCollisionDetection {
  static const description = '''
    This example shows how you can use noise effect.
  ''';
  @override
  void onLoad() {
    addAll([
      ScreenHitbox(),
      Box(),
    ]);
  }
}

class Box extends CircleComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  Vector2 velocity;
  final paint3 = Paint()..color = const Color(0xffb372dc);

  Box() {}

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(
      RectangleComponent.square(
        size: 25,
        position: Vector2(50, 50),
        paint: paint3,
      )..add(
          SequenceEffect(
            [
              MoveEffect.by(
                Vector2(5, 0),
                PerlinNoiseEffectController(duration: 1, frequency: 20),
              ),
              MoveEffect.by(Vector2.zero(), LinearEffectController(2)),
              MoveEffect.by(
                Vector2(0, 10),
                PerlinNoiseEffectController(duration: 1, frequency: 10),
              ),
            ],
            infinite: true,
          ),
        ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}


/*

    
    
    */ 