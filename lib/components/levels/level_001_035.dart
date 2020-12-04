import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/components/tools.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/controllers/gameDesafios.dart';
import 'package:SquadBox/models/enum_desafios.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:SquadBox/models/enum_tools.dart';

class Level001035 {
  GameController gameController;

  Level001035({this.gameController}) {
    this.gameController.inimigos = 10;
    this.gameController.gameLevel.percentual = 80;

    int lin = 10, col = 20;
    for (var i = 0; i<20; i++){
        this.gameController.enemies.add(new Enemy(
            gameController: this.gameController,
            x: lin.toDouble() +0.0,
            y: col.toDouble() +0.0,
            difficulty: 20,
            enemyType: EnemyType.chefao));

        col+=30;
        if ( col > this.gameController.screenSize.width ){
           lin += 10 + (i);
           col = ( i+15 );
        }
    }
    this.gameController.enemies
    ..add(new Enemy(
        gameController: this.gameController,
        x: 50,
        y: 50,
        difficulty: 30,
        enemyType: EnemyType.gerente))
    ..add(new Enemy(
        gameController: this.gameController,
        x: 50,
        y: 50,
        difficulty: 50,
        enemyType: EnemyType.gangster))
    ..add(new Enemy(
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

    this.gameController.tools.items.add( ToolsItem(
            gameController: this.gameController,
            tooltype: ToolsType.status_cutblock,
            name: 'Tools',
            quantidade: 7 ) );        
  }
}
