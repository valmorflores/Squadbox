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

class Level001044 extends Level001builder {
  GameController gameController;

  Level001044({this.gameController}) {
    List<String> map = [
      '_____111111111111__________2________',
      '___1_1___G______2____1______________',
      '________________2_____1_____________',
      '_____R_____R____2_______1___________',
      '__R___________R_2__________1________',
      '_____R_____R____2___________________',
      '_________G_________G______1___2_____',
      '___1________________________________',
      '____________________________________',
      '______1_____1____1____1____1___1____',
      '___22222____________________________',
      '____________2__________________P____',
      '____________________________________',
      '_______B____B____B____B_____________',
      '_________B_____B____B________P______',
      '____________G_____G_________________',
      '________________R___________________',
      '_______2____2____2_____2________P___',
      '____________________________________',
      '_____E_____E_____E_____E____________',
      '_____E_____E_____E_____E____________',
      '________E_____E_____E__________P____',
      '_______________________________P____',
      '____333333333333333333333___________',
      '___3____3_____3_____3_______________',
      '__________Y________Y________Y_______',
      '____________________________________',
      '__________Y________Y________Y_______',
      '____________________________________',
      '__________Y________Y________Y_______',
      '____________________________________',
      '__________Y________Y________Y_______',
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
