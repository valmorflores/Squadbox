//import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:SquadBox/components/health_text.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame/timer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SquadBox/arena.dart';
import 'package:SquadBox/components/blocks.dart';
import 'package:SquadBox/components/desafio_status.dart';
import 'package:SquadBox/components/enemy.dart';
import 'package:SquadBox/components/enemy_text.dart';
import 'package:SquadBox/components/health_bar.dart';
import 'package:SquadBox/components/level_counting.dart';
import 'package:SquadBox/components/level_gameover.dart';
import 'package:SquadBox/components/level_percent.dart';
import 'package:SquadBox/components/level_text.dart';
import 'package:SquadBox/components/level_wait_text.dart';
import 'package:SquadBox/components/mark.dart';
import 'package:SquadBox/components/ocupacao_text.dart';
import 'package:SquadBox/components/player.dart';
import 'package:SquadBox/components/score_text.dart';
import 'package:SquadBox/components/tools.dart';
import 'package:SquadBox/components/tools/block_energy.dart';
import 'package:SquadBox/controllers/gameDesafios.dart';
import 'package:SquadBox/controllers/gameLevels.dart';
import 'package:SquadBox/main-old.dart';
import 'package:SquadBox/main.dart';
import 'package:SquadBox/models/enum_coordinates.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:SquadBox/models/enum_fails.dart';
import 'package:SquadBox/models/enum_mark.dart';
import 'package:SquadBox/models/enum_state.dart';
import 'package:SquadBox/models/enum_tools.dart';
import 'package:SquadBox/screens/view_video_get_live.dart';

import '../components/timer_text.dart';

class GameController extends FlameGame {
  SharedPreferences storage;
  Size screenSize;
  BuildContext context;
  ToolsType toolsType;
  Arena arena;
  double tileSize = 10;
  double toolSize = 50;
  Player player;
  List<Enemy> enemies = []; // = new Enemy(5);
  List<Blocks> blocks = [];
  List<Mark> marks = [];
  int inimigos = 0;
  int level = 1;
  int score = 0;
  int inAnalise = 0;
  int lifes = 5;
  int livedown = 1;
  double _admobHeight = 50;
  double ocupacao = 0;
  bool firstTap = false;
  HealthBar healthBar;
  ScoreText scoreText;
  LevelText levelText;
  TimerText timerText;
  HealthText healthText;
  LevelWaitText levelWaitText;
  LevelCounting levelCounting;
  LevelGameOverText levelGameOverText;
  Offset vdragposition;
  Offset hdragposition;
  StateGame state;
  OcupacaoText ocupacaoText;
  DesafioStatus desafioStatus;
  EnemyText enemyText;
  Desafios desafios;
  Tools tools;
  LevelPercent levelPercent;

  GameLevel gameLevel;

  Timer interval;
  int elapsedSecs;

  GameController() {
    initialize();
  }

  Random rnd = Random();
  Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 200;

  void initialize() async {
    //resize();
    Flame.device.fullScreen();

    Timer countdown = Timer(5);
    elapsedSecs = 0;
    interval = Timer(
      1,
      onTick: () => elapsedSecs += 1,
      repeat: true,
    );
    interval.start();

    // Qual nivel salvo? usa ele claro
    if (this.storage == null) {
      await this.startgetprefs();
    }

    if (this.storage != null) {
      int thelevel = this.storage.getInt('level');
      if (thelevel != null) {
        if (thelevel > this.level) {
          this.level = thelevel;
        }
      }
    } else {
      // Erro no storage de level
      print('Puts! Erro ao carregar a fase salva');
    }
    if (context == null) {
      this.screenSize = Size(400, 400);
    } else {
      this.screenSize = Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height);
    }
    this.player = Player(this);
    this.arena = Arena(gameController: this);
    this.desafios = Desafios(gameController: this, items: []);
    this.gameLevel = GameLevel(gameController: this);
    this.healthBar = HealthBar(gameController: this);
    this.scoreText = ScoreText(gameController: this);
    this.levelText = LevelText(gameController: this);
    this.timerText = TimerText(gameController: this);
    this.healthText = HealthText(gameController: this);
    this.ocupacaoText = OcupacaoText(gameController: this);
    this.enemyText = EnemyText(gameController: this);
    this.levelWaitText = LevelWaitText(gameController: this);
    this.levelCounting = LevelCounting(gameController: this);
    this.levelGameOverText = LevelGameOverText(gameController: this);
    this.tools = Tools(gameController: this);
    this.tools.items.clear();
    this.toolsType = ToolsType.none;
    this.firstTap = false;
    this.inimigos = this.inimigos + 1;
    this.ocupacao = 0;
    this.gameLevel.percentual = 50;
    this.state = StateGame.playing;
    this.levelPercent = LevelPercent(gameController: this);
    this.livedown = 1;
    this.gameLevel.extras();
    this.distribuiinimigos();
    this.arena.printarena();
    desafioStatus = DesafioStatus(gameController: this);
    /*
    this.blocks.add(Blocks(
        gameController: this,
        top: 150,
        left: 150,
        width: 50,
        height: 50,
        blockColor: Colors.greenAccent, //.lightBlueAccent,
        isSpoiled: true));
    */
  }

  void render(Canvas c) {
    //print( 'render');
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()
      ..color = Colors.blueGrey; //Color.fromRGBO(255,255,255,1);
    c.drawRect(background, backgroundPaint);
    this.player != null ? this.player.render(c) : null;
    //enemies.map((eni) => eni.render(c));

    //print( this.state );
    if (this.state == StateGame.menu) {
      this.levelWaitText.render(c);
    } else if (this.state == StateGame.gameover) {
      this.enemies.forEach((element) => element.render(c));
      this.blocks.forEach((element) => element.render(c));
      this.levelGameOverText.render(c);
    } else if (this.state == StateGame.counting) {
      this.enemies.forEach((element) => element.render(c));
      this.levelCounting.render(c);
    } else if (this.state == StateGame.playing) {
      this.blocks.forEach((Blocks e) => e.render(c));
      this.levelPercent.render(c);
      this
          .marks
          .forEach((element) => !element.isDead ? element.render(c) : null);
      // enemies aqui <------
      this.healthBar.render(c);
      this.gameLevel.render(c);
      this.enemies.forEach((element) => element.render(c));
      this.tools.render(c);
      this.desafioStatus.render(c);
    }
    if (this.scoreText != null) {
      this.state != StateGame.gameover ? this.scoreText.render(c) : null;
    }
    if (this.levelText != null) {
      this.state != StateGame.gameover ? this.levelText.render(c) : null;
    }
    if (this.timerText != null) {
      this.state != StateGame.gameover ? this.timerText.render(c) : null;
    }
    if (this.healthText != null) {
      this.state != StateGame.gameover ? this.healthText.render(c) : null;
    }
    this.state != StateGame.gameover ? this.enemyText.render(c) : null;
    this.ocupacaoText.render(c);
    //print( 'render now: ' + this.blocks.length.toString());
  }

  void update(double t) {
    if (this.state != StateGame.paused &&
        this.state != StateGame.runningVideo) {
      interval.update(t);
      this.marks.removeWhere((Mark mark) => mark.isDead);
      this.blocks.removeWhere((Blocks block) => block.isDead);
      this.enemies.removeWhere((Enemy enemie) => enemie.isDead);
      this.enemies.forEach((element) => element.update(t));
      this.blocks.forEach((element) => element.update(t));
      this.marks.forEach((element) => element.update(t));
      this.scoreText != null ? this.scoreText.update(t) : null;
      this.levelText != null ? this.levelText.update(t) : null;
      this.timerText != null ? this.timerText.update(t) : null;
      this.healthBar != null ? this.healthBar.update(t) : null;
      this.healthText != null ? this.healthText.update(t) : null;
      this.gameLevel != null ? this.gameLevel.update(t) : null;
      this.levelWaitText != null ? this.levelWaitText.update(t) : null;
      this.levelCounting != null ? this.levelCounting.update(t) : null;
      this.levelGameOverText != null ? this.levelGameOverText.update(t) : null;
      this.ocupacaoText != null ? this.ocupacaoText.update(t) : null;
      this.enemyText != null ? this.enemyText.update(t) : null;
      this.desafioStatus != null ? this.desafioStatus.update(t) : null;
      this.levelPercent.update(t);

      if (this.gameLevel.fail() != FailsGame.none &&
          (this.state == StateGame.playing ||
              this.state == StateGame.gameover)) {
        this.lifes -= this.livedown;
        this.livedown = 0;
        this.state = StateGame.gameover;
        this.gameLevel.finalgameover();
      }

      if ((this.gameLevel.ocupacao().toInt() >=
              this.gameLevel.percentual.toInt()) ||
          this.gameLevel.ocupacao().toString() ==
              this.gameLevel.percentual.toString()) {
        if (this.player.currentHealt <= 0) {
          // End, gameover
        } else if (this.gameLevel.missionSuccess()) {
          this.gameLevel.finalcount();
          if (this.enemiesCount() <= 3) {
            this.gameLevel.up();
            this.gameLevel.startlevel();
            this.gameLevel.start();
          }
        }
      }

      add(
        ParticleSystemComponent(
          particle: Particle.generate(
            count: 10,
            generator: (i) => AcceleratedParticle(
              acceleration: randomVector2(),
              child: CircleParticle(
                paint: Paint()..color = Colors.red,
              ),
            ),
          ),
        ),
      );
    }
    this.tools.update(t);
    //else if (player.currentHealt<=0){
    //  state = StateGame.gameover;
    //  gameLevel.finalgameover();
    //}
  }

  void resetlevels(int value) {
    this.storage.setInt('level', value);
    this.level = value;
  }

  // Criação inimigos
  void distribuiinimigos() {
    print('--[distribuindo]----------------------');
    int diff;
    bool emSerie = false;
    double x, y;
    Random randomico1 = new Random(256);
    Random randomico2 = new Random(256);
    Random randomico3 = new Random(50);
    emSerie = randomico1.nextInt(1) == 1 ? false : true;
    for (var i = 0; i < this.inimigos; i++) {
      randomico2 = Random(256 * i);
      x = randomico1.nextDouble() * 1000;
      y = randomico2.nextDouble() * 1000;
      if (emSerie) {
        x = (i * 5.1);
        y = (i * 5.1);
      }
      diff = randomico3.nextInt(100);
      diff = diff < 50 ? 50 : diff;

      gameController.blocks.forEach((f) {
        if (f.blockRect.contains(Offset(x, y)) ||
            f.blockRect.contains(Offset(x + tileSize, y)) ||
            f.blockRect.contains(Offset(x, y + tileSize)) ||
            f.blockRect.contains(Offset(x + tileSize, y + tileSize))) {
          if (y > (gameController.screenSize.height / 2)) {
            y = gameController.screenSize.height / 2;
            print('Moving [down] enemies=' + x.toString() + '-' + y.toString());
          } else {
            y = gameController.screenSize.height / 2;
            print('Moving [up] enemies=' + x.toString() + '-' + y.toString());
          }
        }
        if ((f.blockRect.contains(Offset(x, y)) ||
            f.blockRect.contains(Offset(x + tileSize, y)) ||
            f.blockRect.contains(Offset(x, y + tileSize)) ||
            f.blockRect.contains(Offset(x + tileSize, y + tileSize)))) {
          y = y + 50;
        }
        if ((f.blockRect.contains(Offset(x, y)) ||
            f.blockRect.contains(Offset(x + tileSize, y)) ||
            f.blockRect.contains(Offset(x, y + tileSize)) ||
            f.blockRect.contains(Offset(x + tileSize, y + tileSize)))) {
          y = gameController.screenSize.height - 200;
        }
        if ((f.blockRect.contains(Offset(x, y)) ||
            f.blockRect.contains(Offset(x + tileSize, y)) ||
            f.blockRect.contains(Offset(x, y + tileSize)) ||
            f.blockRect.contains(Offset(x + tileSize, y + tileSize)))) {
          y = gameController.screenSize.height - 120;
        }
      });

      this
          .enemies
          .add(Enemy(gameController: this, x: x, y: y, difficulty: diff));
    }
  }

  rodavideo() {
    //  if (state == StateGame.getlivebyvideo) {
    this.state = StateGame.runningVideo;

    //run and wait
    /*Navigator.push(
        this.context,
        MaterialPageRoute(
            builder: (context) => ViewVideoGetLive(
                  parametro: '',
                )));
    */
    // }

    // run and wait
    _navigateAndWait(this.context);
  }

  _navigateAndWait(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    /*final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => ViewVideoGetLive(
                parametro: '',
              )),
    );*/

    /*Scaffold.of(this.context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("resultado: $result")));
    */
    print('lives + 1');
    this.lifes = this.lifes + 1;
    this.state = StateGame.menu;
    this.gameLevel.resetall();
    this.initialize();
    this.state = StateGame.playing;
    print('state to ' + this.state.toString());
  }


  restartRun(){
    print('lives + 1');
    this.lifes = this.lifes + 1;
    this.state = StateGame.menu;
    this.gameLevel.resetall();
    this.initialize();
    this.state = StateGame.playing;
    print('state to ' + this.state.toString());
  }

  void resize(Size size) {
    this.screenSize = size;
  }

  void onTapDown(TapDownDetails d) {
    // print('Tap');
    if (this.state == StateGame.menu) {
      //Valmor: teste apenas
      print('Inicia a fase:' + this.state.toString());
      this.state = StateGame.playing;
      this.gameLevel.resetall();
      this.inimigos = this.inimigos - 1;
      this.initialize();
      this.state = StateGame.playing;
    } else if (state == StateGame.getlivebyvideo) {
      if (this.lifes > 0) {
        this.state = StateGame.playing;
        this.gameLevel.resetall();
        this.inimigos = this.inimigos - 1;
        this.initialize();
      } else {
        rodavideo(); //state == StateGame.runningVideo;
      }
    } else if (this.state == StateGame.gameover) {
      if (d.globalPosition.dy < 70) {
        if (this.lifes <= 0) {
          // Abre área de sugestão de vídeo
          /*Navigator.push(
                null,
                MaterialPageRoute(builder: (context) => ViewVideoGetLive()),
            );*/
          print('Sem vidas');
          this.state = StateGame.getlivebyvideo;
          print('Rodar video');
          rodavideo();
        } else {
          print('Com vidas');
          this.state = StateGame.playing;
          this.gameLevel.resetall();
          this.inimigos = this.inimigos - 1;
          this.initialize();
        }
      }
    } else if (this.state == StateGame.playing) {
      if (d.globalPosition.dy >
          this.screenSize.height - (this.tools.height + this._admobHeight)) {
        // Pegar um item do menu
        //print( 'Menu acionado (haha)');
        /*
          if ( toolsType == ToolsType.none ){
             toolsType = ToolsType.add_energyblock;
          }
          else
          {
             toolsType = ToolsType.none;
          }*/
        //if ( this.toolsType == ToolsType.none ){
        this.toolsType = this.tools.onTapDown(d);
        //}
        //else
        //{
        //this.toolsType = ToolsType.none;
        //}
        //print(this.toolsType.toString());
      } else {
        //print(this.toolsType.toString());
        // Padrão, colocar blocos
        if (this.toolsType == ToolsType.none ||
            this.toolsType == ToolsType.add_normalblock) {
          // todo: melhorar o randomico
          Random randnumero = new Random();
          double size = (50 + randnumero.nextInt(100) / 2);
          if (size > 100) {
            size = 20;
          }
          this.adicionablocks(
              type: 'normal',
              posleft: d.globalPosition.dx,
              postop: d.globalPosition.dy);
          //print('tap' + d.globalPosition.dx.toString());
          //print(this.blocks.length);
        } else if (this.toolsType == ToolsType.add_energyblock) {
          if (this.tools.getQuantidade(ToolsType.add_energyblock) > 0) {
            double size = toolSize;
            this.blocks.add(BlockEnergy(
                gameController: this,
                top: d.globalPosition.dy - (size / 2),
                left: d.globalPosition.dx - (size / 2),
                width: 50,
                height: 50));
            this.tools.decrement(ToolsType.add_energyblock);
            //print('Energy');
          }
        }
        this.firstTap = true;
      }
    }
    //print( 'vai caralho');
    //this.adicionablocks(
    //          type: 'normal',
    //          posleft: d.globalPosition.dx,
    //          postop: d.globalPosition.dy);
  }

  void onVerticalDragStart(DragStartDetails d) {
    this.vdragposition = d.globalPosition;

    print('drag vertical.detail.start = ' +
        d.globalPosition.dx.toString() +
        '/' +
        d.globalPosition.dy.toString());
  }

  void onVerticalDragUpdate(DragUpdateDetails d) {
    this.vdragposition = d.globalPosition;
  }

  void onVerticalDragEnd(DragEndDetails d) {
    if (state == StateGame.playing) {
      if (this.vdragposition != null) {
        if (this.tools.getQuantidade(ToolsType.status_cutblock) > 0) {
          marks.add(Mark(
              gameController: this,
              top: this.vdragposition.dy,
              left: this.vdragposition.dx,
              width: 10,
              height: 150));

          this.tools.decrement(ToolsType.status_cutblock);
        }

        //blocks.add( Blocks(gameController: this, top: this.vdragposition.dy, left: this.vdragposition.dx, width: 150, height: 150, blockColor: Colors.pinkAccent));
        print('drag vertical.detail.end.velocity = ' + d.velocity.toString());
      }
    }
  }

  void onHorizontalDragStart(DragStartDetails d) {
    print('drag horizontal detail.start = ' +
        d.globalPosition.dx.toString() +
        '/' +
        d.globalPosition.dy.toString());
  }

  void onHorizontalDragEnd(DragEndDetails d) {
    if (state == StateGame.playing) {
      if (this.hdragposition != null) {
        if (this.tools.getQuantidade(ToolsType.status_cutblock) > 0) {
          marks.add(Mark(
              gameController: this,
              top: this.hdragposition.dy,
              left: this.hdragposition.dx,
              width: 10,
              height: 10,
              direction: MarkDirection.horizontal));
          this.tools.decrement(ToolsType.status_cutblock);
        }

        print('Qtd=' +
            this.tools.getQuantidade(ToolsType.status_cutblock).toString());

        print('drag horizontal.end.velocity = ' + d.velocity.toString());
      }
    }
  }

  void onHorizontalDragUpdate(DragUpdateDetails d) {
    this.hdragposition = d.globalPosition;
  }

  void counting() {}

  void emininateOneEnemy() {
    this.enemies[0].goPrision();
    this.enemies[0].isDead = true;
  }

  int enemyCount(EnemyType enemyTypeNow) {
    int count = 0;
    this.enemies.forEach((f) {
      if (f.enemyType == enemyTypeNow) {
        ++count;
      }
    });
    return count;
  }

  int enemyCountCaptured(EnemyType enemyTypeNow) {
    int count = 0;
    this.enemies.forEach((f) {
      if (f.enemyType == enemyTypeNow) {
        if (f.isCaptured) {
          ++count;
        }
      }
    });
    return count;
  }

  void sendtoJailOneEnemy() {
    int i = 0;
    this.enemies.forEach((f) {
      if (!f.isDead) {
        if (i <= 0) {
          if (!f.isGoingToPrision) {
            f.goPrision();
            ++i;
          }
        }
      }
    });
  }

  int enemiesCount() {
    int i = 0;
    this.enemies.forEach((f) {
      if (!f.isFree) {
        ++i;
      }
    });
    return i;
  }

  void eliminaporcoordenadaLTRB(double left, top, right, bottom) {
    this.enemies.forEach((f) {
      if (f.enemyRect.left >= left &&
          f.enemyRect.top >= top &&
          f.enemyRect.right <= right &&
          f.enemyRect.bottom <= bottom) {
        f.isDead = true;
        print('morte por coordenada');
      }
    });
  }

  Coordinates quadranteMenosImportante() {
    double topLeft = 0, topRight = 0, bottom = 0;
    int i = 0;

    int inTopLeft = 0;
    int inTopRight = 0;
    int inBottomLeft = 0;
    int inBottomRight = 0;
    // pegando a menor e maior coordenada
    // onde ha inimigo
    this.enemies.forEach((f) {
      if (f.enemyRect.left <= topLeft) {
        topLeft = f.enemyRect.left;
      }
      if (f.enemyRect.left > topRight) {
        topRight = f.enemyRect.right;
      }
      if (f.enemyRect.bottom > bottom) {
        bottom = f.enemyRect.bottom;
      }
    });

    inTopLeft = 0;
    inTopRight = 0;
    inBottomLeft = 0;
    inBottomRight = 0;

    this.enemies.forEach((f) {
      if ((f.enemyRect.left <= topRight / 2) &&
          (f.enemyRect.bottom <= bottom / 2)) {
        ++inTopLeft;
      } else if ((f.enemyRect.left <= topRight / 2) &&
          (f.enemyRect.bottom > bottom / 2)) {
        ++inBottomLeft;
      } else if ((f.enemyRect.left > topRight / 2) &&
          (f.enemyRect.bottom < bottom / 2)) {
        ++inTopRight;
      } else if ((f.enemyRect.left > topRight / 2) &&
          (f.enemyRect.bottom > bottom / 2)) {
        ++inBottomRight;
      }
    });

    if ((inTopRight >= inTopLeft) &&
        (inTopRight >= inBottomLeft) &&
        (inTopRight >= inBottomRight)) {
      return Coordinates.topRight;
    }
    if ((inTopLeft >= inTopRight) &&
        (inTopLeft >= inBottomLeft) &&
        (inTopLeft >= inBottomRight)) {
      return Coordinates.topLeft;
    }
    if ((inBottomLeft >= inTopRight) &&
        (inBottomLeft >= inTopLeft) &&
        (inBottomLeft >= inBottomRight)) {
      return Coordinates.bottomLeft;
    }
    if ((inBottomRight >= inTopRight) &&
        (inBottomRight >= inTopLeft) &&
        (inBottomRight >= inBottomLeft)) {
      return Coordinates.bottomRight;
    }
  }

  Coordinates quadranteMaisImportanteHorizontal(double lin) {
    int inTop = 0, inBottom = 0;
    int i = 0;

    // pegando a menor e maior coordenada
    // onde ha inimigo
    this.enemies.forEach((f) {
      if (f.enemyRect.bottom >= lin) {
        inBottom += (f.enemyType == EnemyType.chefao) ? 1000 : 1;
        inBottom += (f.enemyType == EnemyType.chefe) ? 0500 : 1;
        inBottom += (f.enemyType == EnemyType.vitima) ? 2000 : 1;
      } else {
        inTop += (f.enemyType == EnemyType.chefao) ? 1000 : 1;
        inTop += (f.enemyType == EnemyType.chefe) ? 0500 : 1;
        inTop += (f.enemyType == EnemyType.vitima) ? 2000 : 1;
        ;
      }
    });

    if (inTop >= inBottom) {
      return Coordinates.top;
    } else {
      return Coordinates.bottom;
    }
  }

  Coordinates quadranteMaisImportanteVertical(double col) {
    int inLeft = 0, inRight = 0;
    int i = 0;

    // pegando a menor e maior coordenada
    // onde ha inimigo
    this.enemies.forEach((f) {
      if (f.enemyRect.left >= col) {
        inRight += (f.enemyType == EnemyType.chefao) ? 1000 : 1;
        inRight += (f.enemyType == EnemyType.chefe) ? 0500 : 1;
        inRight += (f.enemyType == EnemyType.vitima) ? 2000 : 1;
      } else {
        inLeft += (f.enemyType == EnemyType.chefao) ? 1000 : 1;
        inLeft += (f.enemyType == EnemyType.chefe) ? 0500 : 1;
        inLeft += (f.enemyType == EnemyType.vitima) ? 2000 : 1;
      }
    });

    if (inRight >= inLeft) {
      return Coordinates.rigth;
    } else {
      return Coordinates.left;
    }
  }

  void killifLTWH(left, top, width, height) {
    this.inAnalise = this.enemiesCount() * 2;
    this.enemies.forEach((f) {
      if (f.enemyRect.top >= top &&
          f.enemyRect.left >= left &&
          f.enemyRect.left + f.enemyRect.width <= left + width &&
          f.enemyRect.top + f.enemyRect.height <= top + height) {
        f.killif();
      }
    });
  }

  void killif() {
    this.inAnalise = this.enemiesCount() * 2;
    this.enemies.forEach((f) => f.killif());
  }

  void adicionablocks(
      {type = 'normal', double postop = 0, double posleft = 0}) {
    double osize = 50.0;
    this.blocks.add(new Blocks(
        gameController: this,
        top: postop - (osize / 2),
        left: posleft - (osize / 2),
        width: osize,
        height: osize,
        blockColor: Colors.greenAccent, //.lightBlueAccent,
        isSpoiled: true));
  }

  void startgetprefs() async {
    this.storage = await SharedPreferences.getInstance();
  }
}
