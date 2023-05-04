import 'package:flutter/material.dart';

import '../../controllers/gameController.dart';
import '../../models/enum_enemy.dart';
import '../blocks.dart';
import '../enemy.dart';
import '../tools/block_energy.dart';
import '../tools/block_portal.dart';

class Level001builder {
  GameController gameController;

  Level001builder({this.gameController}) {}

  void design(map, lin, col) {
    map.forEach((element) {
      lin = lin + 10;
      col = 0;
      for (var i = 0; i < element.length; i++) {
        if (element[i] == 'R') {
          this.gameController.blocks.add(new Blocks(
              gameController: this.gameController,
              left: col.toDouble() + 0.0,
              top: lin.toDouble() + 0.0,
              width: 20,
              height: 20,
              blockColor: Colors.redAccent));
        }
        if (element[i] == 'G') {
          this.gameController.blocks.add(new Blocks(
              gameController: this.gameController,
              left: col.toDouble(),
              top: lin.toDouble(),
              width: 20,
              height: 20,
              blockColor: Colors.green));
        }
        if (element[i] == 'B') {
          this.gameController.blocks.add(new Blocks(
              gameController: this.gameController,
              left: col.toDouble(),
              top: lin.toDouble(),
              width: 20,
              height: 20,
              blockColor: Colors.blue));
        }
        if (element[i] == 'Y') {
          this.gameController.blocks.add(new Blocks(
              gameController: this.gameController,
              left: col.toDouble() + 0.0,
              top: lin.toDouble() + 100.0,
              width: 10,
              height: 10,
              blockColor: Colors.yellow));
        }
        if (element[i] == 'E') {
          this.gameController.blocks.add(new BlockEnergy(
              gameController: this.gameController,
              left: col.toDouble() + 0.0,
              top: lin.toDouble() + 0.0,
              width: 20,
              height: 20,
              blockColor: Colors.greenAccent));
        }
        if (element[i] == 'P') {
          this.gameController.blocks.add(new BlockPortal(
                gameController: this.gameController,
                left: col.toDouble() + 0.0,
                top: lin.toDouble() + 0.0,
                width: 20,
                height: 20,
              ));
        }

        if (element[i] == '1') {
          this.gameController.enemies.add(new Enemy(
              gameController: this.gameController,
              x: col.toDouble() + 0.0,
              y: lin.toDouble() + 0.0,
              difficulty: 20,
              enemyType: EnemyType.chefao));
        }

        if (element[i] == '2') {
          this.gameController.enemies.add(new Enemy(
              gameController: this.gameController,
              x: col.toDouble() + 0.0,
              y: lin.toDouble() + 0.0,
              difficulty: 20,
              enemyType: EnemyType.gerente));
        }

        if (element[i] == '3') {
          this.gameController.enemies.add(new Enemy(
              gameController: this.gameController,
              x: 50,
              y: 50,
              difficulty: 30,
              enemyType: EnemyType.gangster));
        }
        
        col = col + 10;
      }
    });
  }
}
