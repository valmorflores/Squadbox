import 'package:SquadBox/components/blocks.dart';
import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/components/tools.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/controllers/gameDesafios.dart';
import 'package:SquadBox/models/enum_desafios.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:SquadBox/models/enum_tools.dart';
import 'package:flutter/material.dart';

class Level001015 {
  GameController gameController;

  Level001015({this.gameController}) {
    
    int i;
    int p;
    int pos;
    pos = 0;
    double t = 20.0;
    for ( i = 1; i< 10;++i ){ 
      p=i;
      pos = pos + 40;
      
      this.gameController.blocks.add(
                Blocks(gameController: this.gameController, 
          top: t+=0,
          left: (pos).toDouble(),
          width: 200,
          height: 20,
          blockColor: Colors.redAccent, 
          isSpoiled: false ) );
      
      this.gameController.blocks.add(
                Blocks(gameController: this.gameController, 
          top: t+=40,
          left: (pos).toDouble(),
          width: 200,
          height: 20,
          blockColor: Colors.green, 
          isSpoiled: false ) );
      
      pos = pos + 40;
      p=i;
      int l=20;
      this.gameController.blocks.add(
        Blocks(gameController: this.gameController, 
          top: t+=40,
          left: pos/1,
          width: 200,
          height: 20,
          blockColor: Colors.amber, 
          isSpoiled: false ) );
      
     this.gameController.blocks.add(
        Blocks(gameController: this.gameController, 
          top: t+=40,
          left: pos/1,
          width: 200,
          height: 20,
          blockColor: Colors.amber, 
          isSpoiled: false ) );
      
    }
    
    
    this.gameController.inimigos = 40;
    this.gameController.gameLevel.percentual = 60;
    this.gameController.enemies.add(new Enemy(
        gameController: this.gameController,
        x: 50,
        y: 50,
        difficulty: 20,
        enemyType: EnemyType.chefao));
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
          quantidade: 1,
        ));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Gangster',
          enemytype: EnemyType.gangster,
          desafio: DesafiosGame.capturar,
          quantidade: 20,
        ));
    this.gameController.desafios.add(new DesafiosItem(
          name: 'Chefao',
          enemytype: EnemyType.chefao,
          desafio: DesafiosGame.capturar,
          quantidade: 1,
        ));
    this.gameController.tools.items.add(ToolsItem(
        gameController: this.gameController,
        tooltype: ToolsType.add_energyblock,
        name: 'Tools',
        quantidade: 30));

    
    this.gameController.tools.items.add( ToolsItem(
            gameController: this.gameController,
            tooltype: ToolsType.status_cutblock,
            name: 'Tools',
            quantidade: 2) );
    
  }
}
