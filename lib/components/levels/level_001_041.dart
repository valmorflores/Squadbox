import 'package:squadbox/components/blocks.dart';
import 'package:squadbox/components/enemy.dart';
import 'package:squadbox/components/tools.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/controllers/gameDesafios.dart';
import 'package:squadbox/models/enum_desafios.dart';
import 'package:squadbox/models/enum_enemy.dart';
import 'package:squadbox/models/enum_tools.dart';
import 'package:flutter/material.dart';

class Level001041 {
  final GameController gameController;

  Level001041({required this.gameController}) {
    this.gameController.inimigos = 10;
    this.gameController.gameLevel.percentual = 70;

    int lin = 200, col = 20;
    for (var i = 0; i < 10; i++) {
      this.gameController.blocks.add(new Blocks(
          gameController: this.gameController,
          left: col.toDouble() + 0.0,
          top: lin.toDouble() + 0.0,
          width: 30,
          height: 30,
          blockColor: Colors.red));

      this.gameController.blocks.add(new Blocks(
          gameController: this.gameController,
          left: col.toDouble() + 0.0,
          top: lin.toDouble() + 50.0,
          width: 20,
          height: 20,
          blockColor: Colors.lightBlueAccent));

      this.gameController.blocks.add(new Blocks(
          gameController: this.gameController,
          left: col.toDouble() + 0.0,
          top: lin.toDouble() + 100.0,
          width: 30,
          height: 30,
          blockColor: Colors.yellow));

      col += 34;
      if (col > this.gameController.screenSize.width) {
        lin += 10 + (i);
        col = (i + 15);
      }
    }

    lin = 10;
    col = 20;
    for (var i = 0; i < 10; i++) {
      this.gameController.enemies.add(new Enemy(
          gameController: this.gameController,
          x: col.toDouble() + 0.0,
          y: lin.toDouble() + 0.0,
          difficulty: 20,
          enemyType: EnemyType.chefao));

      col += 30;
      if (col > this.gameController.screenSize.width) {
        lin += 10 + (i);
        col = (i + 15);
      }
    }

    for (var i = 0; i < 15; i++) {
      this.gameController.enemies.add(new Enemy(
          gameController: this.gameController,
          x: lin.toDouble() + 0.0,
          y: col.toDouble() + 0.0,
          difficulty: 20,
          enemyType: EnemyType.gerente));

      col += 30;
      if (col > this.gameController.screenSize.width) {
        lin += 10 + (i);
        col = (i + 15);
      }
    }
    this.gameController.enemies.add(new Enemy(
        gameController: this.gameController,
        x: 50,
        y: 50,
        difficulty: 30,
        enemyType: EnemyType.gerente));
    this.gameController.enemies.add(new Enemy(
        gameController: this.gameController,
        x: 50,
        y: 50,
        difficulty: 50,
        enemyType: EnemyType.gangster));
    this.gameController.enemies.add(new Enemy(
        gameController: this.gameController,
        x: 50,
        y: 50,
        difficulty: 40,
        enemyType: EnemyType.gangster));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Gerente',
          enemytype: EnemyType.gerente,
          desafio: DesafiosGame.capturar,
          quantidade: 6,
        ));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Gangster',
          enemytype: EnemyType.gangster,
          desafio: DesafiosGame.capturar,
          quantidade: 3,
        ));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Chefao',
          enemytype: EnemyType.chefao,
          desafio: DesafiosGame.capturar,
          quantidade: 7,
        ));
    this.gameController.tools.items.add(ToolsItem(
        gameController: this.gameController,
        tooltype: ToolsType.add_energyblock,
        name: 'Tools',
        quantidade: 30));
  }
}
