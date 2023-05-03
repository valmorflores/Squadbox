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
      'R_____111111111111________________R',
      'R___1_1___G___________1___________R',
      'R______________________1__________R',
      'R_____R_____R____________1________R',
      'R__R___________R____________1_____R',
      'R_____R_____R_____________________R',
      'R_________G_________G______1___2__R',
      'R___1_____________________________R',
      'R___________________1_____________R',
      'R_____2________2______2_____2_____R',
      'R_________________________________R',
      'R__________________1______________R',
      'R_________________________________R',
      'R_______3_________________________R',
      'R___________3________1__3_________R',
      'R____________3_________3__________R',
      'R_____________3_______3___________R',
      'R______________3_____3____________R',
      'R_______1_______3___3_____________R',
      'R________1_______3_3__1_1 1_______R',
      'R_________1_______3_______________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
      'R_________________________________R',
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
          quantidade: 2,
        ));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Gangster',
          enemytype: EnemyType.gangster,
          desafio: DesafiosGame.capturar,
          quantidade: 2,
        ));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Chefao',
          enemytype: EnemyType.chefao,
          desafio: DesafiosGame.capturar,
          quantidade: 2,
        ));
    this.gameController.tools.items.add(ToolsItem(
        gameController: this.gameController,
        tooltype: ToolsType.add_energyblock,
        name: 'Tools',
        quantidade: 30));
  }
}
