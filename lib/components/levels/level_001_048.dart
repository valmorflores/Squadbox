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

class Level001048 extends Level001builder {
  GameController gameController;

  Level001048({this.gameController}) {
    List<String> map = [
      'R_____111111111111___________________R',
      'R___1_1___G___________1______________R',
      'R______________________1_____________R',
      'R_____R_____R____________1___________R',
      'R__R___________R____________1________R',
      'R_____R_____R________________________R',
      'R_________G_________G______1___2_____R',
      'R___1________________________________R',
      'R____________________________________R',
      'R_____2________2______2_____2________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R_______3____________________________R',
      'R___________3___________3____________R',
      'R____________3_________3_____________R',
      'R_____________3_______3______________R',
      'R______________3_____3_______________R',
      'R_______________3___3________________R',
      'R________________3_3_________________R',
      'R_________________3__________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
      'R____________________________________R',
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
