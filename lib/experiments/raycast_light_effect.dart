import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// Versão simplificada do exemplo de raycast apenas para manter o projeto
/// compilando nas versões atuais de Flutter/Flame.
class RaycastLightEffectGame extends StatelessWidget {
  const RaycastLightEffectGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Raycast Light Effect desativado nesta versão.\n'
          'Exemplo mantido apenas como placeholder.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
