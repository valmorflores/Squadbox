import 'package:SquadBox/components/blocks.dart';
import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/components/tools.dart';
import 'package:SquadBox/components/tools/block_energy.dart';
import 'package:SquadBox/components/tools/block_portal.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/controllers/gameDesafios.dart';
import 'package:SquadBox/models/enum_desafios.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:SquadBox/models/enum_tools.dart';
import 'package:flutter/material.dart';

import 'level_001_builder.dart';

class Level001047 extends Level001builder {
  GameController gameController;

  Level001047({this.gameController}) {
    List<String> map = [
      'P_____111111111111___________________P',
      'P___1_1___G___________1______________P',
      'P______________________1_____________P',
      'P_____R_____R____________1___________P',
      'P__R___________R____________1________P',
      'P_____R_____R________________________P',
      'P_________G_________G______1___2_____P',
      'P___1________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
      'P____________________________________P',
    ];

    this.gameController.inimigos = 10;
    this.gameController.gameLevel.percentual = 70;

    int lin = 50, col = 50;

    design(map, lin, col);

    lin = 10;
    col = 20;

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
          quantidade: 4,
        ));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Chefao',
          enemytype: EnemyType.chefao,
          desafio: DesafiosGame.capturar,
          quantidade: 10,
        ));
    this.gameController.tools.items.add(ToolsItem(
        gameController: this.gameController,
        tooltype: ToolsType.add_energyblock,
        name: 'Tools',
        quantidade: 30));
  }
}
