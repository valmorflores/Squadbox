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

class Level001045 extends Level001builder {
  GameController gameController;

  Level001045({this.gameController}) {
    List<String> map = [
      '2222_111111111111__________________P_',
      '___1_1___G___________1_____________P_',
      '______________________1____________P_',
      '_____R_____R____________1__________P_',
      '__R___________R____________1_______P_',
      '_____R_____R_______________________P_',
      '_________G_________G______1___2____P_',
      '___1________________________________',
      '____________________________________',
      '______1_____1____1____1____1___1____',
      '___22222____________________________',
      '____________2_____________________',
      '____________________________________',
      '_______B____B____B____B_____________',
      '_________B_____B____B_____________',
      '____________G_____G_________________',
      '________________R___________________',
      '_______2____2____2_____2____________',
      '____________________________________',
      '_____E_____E_____E_____E_____2______',
      '_____E_____E_____E_____E_____2______',
      '________E_____E_____E_______________',
      '____________________________________',
      '____333333333333333333333___________',
      '___3____3_____3_____3_______________',
      '__________Y________Y________Y______P_',
      '___________________________________P_',
      '____22____Y___22___Y___22___Y______P_',
      '____22________22_______22__________P_',
      '____22____Y___22___Y___22___Y______P_',
      '___________________________________P_',
      '__________Y________Y________Y______P_',
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
