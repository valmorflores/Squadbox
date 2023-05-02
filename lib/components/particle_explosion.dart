import 'dart:math';
import 'dart:ui';

import 'package:SquadBox/controllers/gameController.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class ParticleExplosion {
  final Random rnd = Random();
  final cellCenter = Vector2(100, 100);
  final cellSize = Vector2(100, 100);

  final GameController gameController;
  ParticleExplosion({this.gameController});

  callParticle() {
    final particle = fireworkParticle();
    final col = 100;
    final row = 100;
    this.gameController.add(
          // Bind all the particles to a [Component] update
          // lifecycle from the [FlameGame].
          ParticleSystemComponent(
            particle: MovingParticle(
              // Will move from corner to corner of the game canvas.
              from: Vector2.zero(),
              to: this.gameController.size,
              child: CircleParticle(
                radius: 2.0,
                paint: Paint()..color = Colors.red,
              ),
            ),
          ),
        );
  }

  /// Returns random [Vector2] within a virtual grid cell
  Vector2 randomCellVector2() {
    return (Vector2.random() - Vector2.random())..multiply(cellSize);
  }

  /// Returns random [Color] from primary swatches
  /// of material palette
  Color randomMaterialColor() {
    return Colors.primaries[rnd.nextInt(Colors.primaries.length)];
  }

  /// Returns a random element from a given list
  T randomElement<T>(List<T> list) {
    return list[rnd.nextInt(list.length)];
  }

  Particle fireworkParticle() {
    // A palette to paint over the "sky"
    final paints = [
      Colors.amber,
      Colors.amberAccent,
      Colors.red,
      Colors.redAccent,
      Colors.yellow,
      Colors.yellowAccent,
      // Adds a nice "lense" tint
      // to overall effect
      Colors.blue,
    ].map((color) => Paint()..color = color).toList();

    return Particle.generate(
      generator: (i) {
        final initialSpeed = randomCellVector2();
        final deceleration = initialSpeed * -1;
        final gravity = Vector2(0, 40);

        return AcceleratedParticle(
          speed: initialSpeed,
          acceleration: deceleration + gravity,
          child: ComputedParticle(
            renderer: (canvas, particle) {
              final paint = randomElement(paints);
              // Override the color to dynamically update opacity
              paint.color = paint.color.withOpacity(1 - particle.progress);

              canvas.drawCircle(
                Offset.zero,
                // Closer to the end of lifespan particles
                // will turn into larger glaring circles
                rnd.nextDouble() * particle.progress > .6
                    ? rnd.nextDouble() * (50 * particle.progress)
                    : 2 + (3 * particle.progress),
                paint,
              );
            },
          ),
        );
      },
    );
  }
}
