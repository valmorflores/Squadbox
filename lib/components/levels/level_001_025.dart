import 'package:squadbox/components/blocks.dart';
import 'package:squadbox/components/enemy.dart';
import 'package:squadbox/components/tools.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/controllers/gameDesafios.dart';
import 'package:squadbox/models/enum_desafios.dart';
import 'package:squadbox/models/enum_enemy.dart';
import 'package:squadbox/models/enum_tools.dart';
import 'package:flutter/material.dart';

class Level001025 {
  final GameController gameController;

  Level001025({required this.gameController}) {
    
    int i;
    int p;
    int pos;
    pos = 0;
    for ( i = 1; i< 10;++i ){ 
      p=i;
      pos = pos + 40;
      
      this.gameController.blocks.add(
                Blocks(gameController: this.gameController, 
          top: 20,
          left: (pos).toDouble(),
          width: 040,
          height: 40,
          blockColor: Color.fromRGBO(0,0,0,0.50), 
          isSpoiled: false ) );
      
      this.gameController.blocks.add(
                Blocks(gameController: this.gameController, 
          top: 100,
          left: (pos).toDouble(),
          width: 040,
          height: 40,
          blockColor: Color.fromRGBO(0,0,0,0.20), 
          isSpoiled: false ) );
      
      pos = pos + 40;
      p=i;
      int l=20;
      this.gameController.blocks.add(
        Blocks(gameController: this.gameController, 
          top: 60,
          left: pos/1,
          width: 40,
          height: 40,
          blockColor: Color.fromRGBO(0,0,0,0.50), 
          isSpoiled: false ) );
      
     this.gameController.blocks.add(
        Blocks(gameController: this.gameController, 
          top: 140,
          left: pos/1,
          width: 40,
          height: 40,
          blockColor: Color.fromRGBO(0,0,0,0.20), 
          isSpoiled: false ) );
      
    }
    
    
    this.gameController.inimigos = 40;
    this.gameController.gameLevel.percentual = 74;
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
