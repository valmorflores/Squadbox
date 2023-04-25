import 'dart:ui';

import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/components/levels/level_001_002.dart';
import 'package:SquadBox/components/levels/level_001_003.dart';
import 'package:SquadBox/components/levels/level_001_004.dart';
import 'package:SquadBox/components/levels/level_001_005.dart';
import 'package:SquadBox/components/levels/level_001_009.dart';
import 'package:SquadBox/components/levels/level_001_010.dart';
import 'package:SquadBox/components/levels/level_001_015.dart';
import 'package:SquadBox/components/levels/level_001_020.dart';
import 'package:SquadBox/components/levels/level_001_025.dart';
import 'package:SquadBox/components/levels/level_001_030.dart';
import 'package:SquadBox/components/levels/level_001_035.dart';
import 'package:SquadBox/components/levels/level_001_038.dart';
import 'package:SquadBox/components/levels/level_001_039.dart';
import 'package:SquadBox/components/levels/level_001_040.dart';
import 'package:SquadBox/components/levels/level_001_042.dart';
import 'package:SquadBox/components/tools.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/controllers/gameDesafios.dart';
import 'package:SquadBox/models/enum_desafios.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:SquadBox/models/enum_fails.dart';
import 'package:SquadBox/models/enum_state.dart';
import 'package:SquadBox/models/enum_tools.dart';

import 'package:SquadBox/components/levels/level_001_001.dart';
import 'package:SquadBox/components/levels/level_001_008.dart';

import '../components/levels/level_001_041.dart';

class GameLevel {
  int level = 0;
  int enemies = 1;
  int highscore = 0;
  int difficulty = 30;
  double percentual = 50;

  GameController gameController;
  GameLevel({this.gameController, this.percentual}) {}

  void up() {
    this.level++;
    this.gameController.level = this.gameController.level + 1;
    int savedlevel = this.gameController.storage.getInt('level');
    if (savedlevel == null) {
      savedlevel = 0;
    }
    if (this.gameController.level > savedlevel) {
      this.gameController.storage.setInt('level', this.gameController.level);
    }
  }

  void down() {
    this.level--;
  }

  void startlevel() {
    this.enemies = this.level;
    this.difficulty = this.difficulty + 2;
  }

  double ocupacao() {
    double lin, col;
    double areatotal = 0;
    double areaocupada = 0;
    Offset posicao;
    areatotal = this.gameController.screenSize.width *
        this.gameController.screenSize.height;

    areaocupada = this.gameController.ocupacao;
    if (((areaocupada / areatotal) * 100) < 1.0) {
      return 0;
    } else if (((areaocupada / areatotal) * 100) >= 99.0) {
      return 99;
    } else {
      return (areaocupada / areatotal) * 100;
    }
  }

  double start() {
    this.gameController.blocks.forEach((f) => f.isDead = true);
    this.gameController.enemies.forEach((f) => f.isDead = true);
    this.enemies += 1;
    print('Start' + this.enemies.toString());
    this.gameController.initialize();
    this.startlevel();
  }

  void resetall() {
    this.gameController.blocks.forEach((f) => f.isDead = true);
    this.gameController.enemies.forEach((f) => f.isDead = true);
    this.enemies += 0;
    print('Reset' + this.enemies.toString());
  }

  void render(Canvas c) {}

  void update(double t) {}

  void finalcount() {
    // Mostrar contagem
    this.gameController.state = StateGame.counting;
  }

  void finalgameover() {
    //this.gameController.score += 1;
  }

  int count() {
    int i = 0;
    this.gameController.enemies.forEach((f) => i++);
    return i;
  }

  FailsGame fail() {
    FailsGame fail = FailsGame.none;
    int captura;
    this.gameController.desafios.items.forEach((f) {
      if (f.desafio == DesafiosGame.capturar) {
        captura = 0;
        this.gameController.enemies.forEach((enemy) {
          if (enemy.enemyType == f.enemytype) {
            ++captura;
          }
        });
        if (captura < f.quantidade) {
          fail = FailsGame.enemykilled;
          fail =
              (f.enemytype == EnemyType.chefao) ? FailsGame.bosskilled : fail;
          fail = (f.enemytype == EnemyType.gerente)
              ? FailsGame.managerkilled
              : fail;
          fail = (f.enemytype == EnemyType.gangster)
              ? FailsGame.enemykilled
              : fail;
        }
      }
    });
    //fail = FailsGame.none;
    if (this.gameController.player.currentHealt <= 0) {
      fail = FailsGame.health;
    }
    return fail;
  }

  void extras() {
    print('Extras para fase: ' + this.gameController.level.toString());
    // Ferramenta basica, todas as fases;
    this.gameController.tools.items.add(ToolsItem(
        gameController: this.gameController,
        tooltype: ToolsType.add_normalblock,
        name: 'Tools',
        quantidade: 1000000000));

    /*
      this.gameController.tools.items.add(ToolsItem(
        gameController: this.gameController,
        tooltype: ToolsType.status_cutblock,
        name: 'Tools - Cut Status',
        quantidade: 1000000000 ));
     */

    // Fases
    if (this.gameController.level == 1) {
      Level001001(gameController: this.gameController);
    } else if (this.gameController.level == 2) {
      Level001002(gameController: this.gameController);
    } else if (this.gameController.level == 3) {
      Level001003(gameController: this.gameController);
    } else if (this.gameController.level == 4) {
      Level001004(gameController: this.gameController);
    } else if (this.gameController.level >= 5 &&
        this.gameController.level <= 7) {
      Level001005(gameController: this.gameController);
    } else if (this.gameController.level == 8) {
      Level001008(gameController: this.gameController);
    } else if (this.gameController.level == 9) {
      Level001009(gameController: this.gameController);
    } else if (this.gameController.level >= 10 &&
        this.gameController.level <= 14) {
      Level001010(gameController: this.gameController);
    } else if (this.gameController.level >= 15 &&
        this.gameController.level <= 19) {
      Level001015(gameController: this.gameController);
    } else if (this.gameController.level >= 20 &&
        this.gameController.level <= 24) {
      Level001020(gameController: this.gameController);
    } else if (this.gameController.level >= 25 &&
        this.gameController.level <= 29) {
      Level001025(gameController: this.gameController);
    } else if (this.gameController.level >= 30 &&
        this.gameController.level <= 34) {
      Level001030(gameController: this.gameController);
    } else if (this.gameController.level >= 35 &&
        this.gameController.level <= 37) {
      Level001035(gameController: this.gameController);
    } else if (this.gameController.level >= 38 &&
        this.gameController.level <= 38) {
      Level001038(gameController: this.gameController);
    } else if (this.gameController.level >= 39 &&
        this.gameController.level <= 39) {
      Level001039(gameController: this.gameController);
    } else if (this.gameController.level == 40) {
      Level001040(gameController: this.gameController);
    } else if (this.gameController.level == 41) {
      Level001041(gameController: this.gameController);
    } else if (this.gameController.level >= 42 &&
        this.gameController.level <= 80) {
      Level001042(gameController: this.gameController);
    } else if (this.gameController.level >= 81 &&
        this.gameController.level <= 99) {
      Level001041(gameController: this.gameController);
    } else if (this.gameController.level >= 100) {
      this.gameController.enemies.add(new Enemy(
          gameController: this.gameController,
          x: 50,
          y: 50,
          difficulty: 10,
          enemyType: EnemyType.chefao));
      this.gameController.enemies.add(new Enemy(
          gameController: this.gameController,
          x: 150,
          y: 150,
          difficulty: 25,
          enemyType: EnemyType.chefao));
    }
  }
}
