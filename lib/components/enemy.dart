import 'dart:io';
import 'dart:ui';
import 'package:SquadBox/components/busted_text.dart';
import 'package:flutter/material.dart';
import 'package:SquadBox/components/blocks.dart';
import 'package:SquadBox/components/mark.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_enemy.dart';
import 'package:SquadBox/models/enum_game.dart';
import 'package:SquadBox/models/enum_state.dart';
import 'enum_enemy.dart';

class Enemy {
  final GameController gameController;
  int health = 100;
  int damage = 0;
  int dificuldade = 0;

  double speed;
  Rect enemyRect;
  Rect enemyEyeRect;
  bool isDead = false;
  bool isGoingToPrision = false;
  bool isCaptured = false;
  EnemieDirection direcao;
  EnemyType enemyType;
  double size = 10;
  int walking = 0;
  int limited = 0;
  int qtdtolimited = 10;
  BustedText bustedText;

  Enemy(
      {this.gameController,
      double x,
      double y,
      int difficulty = 50,
      this.enemyType: EnemyType.gangster}) {
    health = 100;
    dificuldade = difficulty;
    speed = this.gameController.tileSize * dificuldade;
    direcao = EnemieDirection.righdown;
    if (enemyType == EnemyType.gangster) {
      size = 10;
    } else if (enemyType == EnemyType.gerente) {
      size = 15;
    } else if (enemyType == EnemyType.chefe) {
      size = 18;
    } else if (enemyType == EnemyType.chefao) {
      size = 24;
    }
    enemyRect = Rect.fromLTWH(x, y, size, size);
    enemyEyeRect = Rect.fromLTWH(
        enemyRect.left + (enemyRect.width / 10),
        enemyRect.top + (enemyRect.height / 10),
        enemyRect.width / 3,
        enemyRect.height / 3);
  }

  Color colorbytype() {
    if (this.enemyType == EnemyType.chefao) {
      return Color.fromRGBO(255, 0, 0, 1 * health / 100);
    } else if (this.enemyType == EnemyType.chefe) {
      return Color.fromRGBO(255, 0, 20, 1 * health / 100);
    } else if (this.enemyType == EnemyType.gangster) {
      return Color.fromRGBO(255, 255, 255, 1 * health / 100);
    } else if (this.enemyType == EnemyType.gerente) {
      return Color.fromRGBO(0, 255, 50, 1 * health / 100);
    } else {
      return Color.fromRGBO(0, 0, 0, 1 * health / 100);
    }
  }

  void render(Canvas c) {
    Color basicblack;
    basicblack = Color.fromRGBO(0, 0, 0, 1 * health / 100);
    Color color;
    color = colorbytype();

    Paint enemyColor = Paint()..color = basicblack;
    c.drawRect(enemyRect, enemyColor);

    Paint enemyEyeColor = Paint()..color = color;
    c.drawRect(enemyEyeRect, enemyEyeColor);

    if ( this.bustedText != null ){
      this.bustedText.render(c);
    }

  }

  void update(double t) {
    bool colidiu;
    if (!isDead) {      
      if (false /*killif()*/) {
        --this.gameController.inAnalise;
      } else {
        double stepDistance = speed * t;
        Offset toDirection = Offset(0, 0);
        if (!this.isGoingToPrision && !this.isCaptured) {
          detectColisionMarks();
          if (!(colidiu = detectColisionBlocks())) {
            colidiu = detectColisionLimit();
          }
          if (this.limited < 99999999) {
            this.walking = this.walking + 1;
            if (colidiu) {
              if (this.walking <= this.qtdtolimited) {
                this.limited = this.limited + 1;
              }
              else
              {
                // zera a contagem de limitação
                this.limited = 0;
              }
              this.walking = 0;
            }
            if (this.limited > 200) {
              print(this.hashCode.toString() + ': personagem foi capturado :D');
              this.limited = 99999999;
              this.isCaptured = true;
              this.health = ( this.health * 0.50 ).toInt();
              this.bustedText = BustedText(gameController: this.gameController,
                   enemyType: this.enemyType,
                   top: this.enemyRect.top, left: this.enemyRect.left );
              
            }
          }
        }

        if (this.isCaptured && !this.isGoingToPrision) {
          enemyRect = Rect.fromLTWH( enemyRect.left, enemyRect.top, size, size);
        } else {
          // Vai para
          if (direcao == EnemieDirection.up) {
            toDirection = Offset(0, -10);
          }
          if (direcao == EnemieDirection.leftup) {
            toDirection = Offset(-10, -10);
          }
          if (direcao == EnemieDirection.leftdown) {
            toDirection = Offset(-10, 10);
          }
          if (direcao == EnemieDirection.righdown) {
            toDirection = Offset(10, 10);
          }
          if (direcao == EnemieDirection.rightup) {
            toDirection = Offset(10, -10);
          }
          Offset stepToPlayer =
              Offset.fromDirection(toDirection.direction, stepDistance);
          enemyRect = enemyRect.shift(stepToPlayer);
        }
        if (this.isGoingToPrision) {
          // Fazer contagem de inimigos e jogar no score
          this.gameController.score +=
              this.enemyRect.top <= 0 && !isDead ? 1 : 0;
          int high = this.gameController.storage.getInt('highscore');
          if (high == null) {
            high = 0;
          }
          if (this.gameController.score > high) {
            this
                .gameController
                .storage
                .setInt('highscore', this.gameController.score);
          }
          isDead = (isDead || this.enemyRect.top <= 0);
        } else if (!isCaptured) {
          //print( enemyRect.bottom.toString() );
          if (this.gameController.state == StateGame.playing) {
            if (this.gameController.inAnalise > 0) {
              if (this.gameController.arena.contents(Offset(
                    this.enemyRect.top,
                    this.enemyRect.left,
                  ))) {
                isDead = isDead; // || detectInnerBlock();
                /*if (isDead) {
                  print('');
                }
                print('Kill now? ' + (isDead ? 'yes' : 'no'));
                */
              }
            }
            if (this.gameController.tools.limit != null) {
              if (enemyRect.bottom > this.gameController.tools.limit) {
                //print( 'saiu, limite: ' + this.gameController.tools.limit.toString() + ' de ' + this.gameController.screenSize.height.toString());
                //print('Saiu na barra abaixo: ' + enemyRect.hashCode.toString());
                reposiciona();
              }
            }
            if (enemyRect.left < -enemyRect.width * 2 ||
                enemyRect.top < -enemyRect.width * 2 ||
                enemyRect.bottom >
                    gameController.screenSize.height + enemyRect.height * 2 ||
                enemyRect.right >
                    gameController.screenSize.width + enemyRect.width * 2) {
              reposiciona();
              //print(
              //    'reposicionado, saiu da arena: ' + this.hashCode.toString());
            }
          }
        }
      }
      if ( this.bustedText != null ){
         if ( this.bustedText.destroy() ){
           this.bustedText = null;
         }
         else
         { 
            this.bustedText.update(t);
         }
      }
    }
    enemyEyeRect = Rect.fromLTWH(
        enemyRect.left + (enemyRect.width / 10),
        enemyRect.top + (enemyRect.height / 10),
        enemyRect.width / 3,
        enemyRect.height / 3);
  }

  void reposiciona() {
    this.enemyRect = Rect.fromLTWH(this.gameController.screenSize.width / 2,
        this.gameController.screenSize.height / 2, size, size);
  }

  void changePos(Offset posicao) {
    this.enemyRect = Rect.fromLTWH(posicao.dx, posicao.dy, size, size);
  }

  void goPrision() {
    if (!this.isGoingToPrision) {
      print('Go to prision: ' + this.hashCode.toString());
      this.isGoingToPrision = true;
      this.direcao = EnemieDirection.up;
      this.size = this.size * 1.15;
      this.enemyRect = Rect.fromLTWH(this.enemyRect.left,
          this.gameController.screenSize.height - 20, size * 2, size * 2);
    }
  }

  // Verdadeiro somente se colidir os 4 cantos do enemy
  bool detectInnerBlock() {
    double ptop, pleft, pbottom, pright;
    Offset posicao;
    ptop = this.enemyRect.top;
    pleft = this.enemyRect.left;
    pbottom = this.enemyRect.bottom;
    pright = this.enemyRect.right;
    /*
      print('---[analise]---');
      print('Position: ' +
          this.hashCode.toString() +
          ' ' +
          ptop.toString() +
          ' ' +
          pleft.toString() +
          ' ' +
          pbottom.toString() +
          ' ' +
          pright.toString());
      */
    int ncolide = 0;
    bool lcolide = false;
    gameController.blocks.forEach((Blocks element) {
      // Teste 1 - left top
      if (!lcolide) {
        ncolide = 0;
        ncolide += (element.blockRect.contains(Offset(pleft, ptop)) ? 1 : 0);
        ncolide += (element.blockRect.contains(Offset(pleft, pbottom)) ? 1 : 0);
        ncolide += (element.blockRect.contains(Offset(pright, ptop)) ? 1 : 0);
        ncolide +=
            (element.blockRect.contains(Offset(pright, pbottom)) ? 1 : 0);
        /* print('block: ' +
              element.blockRect.top.toString() +
              ' ' +
              element.blockRect.left.toString() +
              ' ' +
              element.blockRect.bottom.toString() +
              ' ' +
              element.blockRect.right.toString() +
              ' -> ' +
              ncolide.toString()); 
          */
        if (ncolide >= 4) {
          lcolide = true;
        }
      }
    });
    return lcolide;
  }

  bool detectColisionBlocks() {
    Offset posicao;
    bool lcolide = false;
    this.gameController.blocks.forEach((Blocks element) {
      //element.colide(enemyRect));
      if (direcao == EnemieDirection.leftdown) {
        posicao = Offset(enemyRect.left, enemyRect.bottom);
      } else if (direcao == EnemieDirection.leftup) {
        posicao = Offset(enemyRect.left, enemyRect.top);
      } else if (direcao == EnemieDirection.righdown) {
        posicao = Offset(enemyRect.right, enemyRect.bottom);
      } else if (direcao == EnemieDirection.rightup) {
        posicao = Offset(enemyRect.right, enemyRect.top);
      }
      if (posicao != null && element.blockRect != null) {
        if (element.blockRect.contains(posicao)) {
          if (direcao == EnemieDirection.leftdown) {
            if ((posicao.dx + 10 >= element.blockRect.right) &&
                (posicao.dy - 10 <= element.blockRect.top)) {
              direcao = EnemieDirection.rightup;
            } else if ((posicao.dx + 10) >= element.blockRect.right) {
              direcao = EnemieDirection.righdown;
            } else if (posicao.dy - 10 <= element.blockRect.top) {
              direcao = EnemieDirection.leftup;
            } else {
              direcao = EnemieDirection.righdown;
            }
          } else if (direcao == EnemieDirection.leftup) {
            if ((posicao.dy.toInt() <= element.blockRect.bottom.toInt()) &&
                ((posicao.dx.toInt() == element.blockRect.right.toInt() ||
                    posicao.dx.toInt() <= element.blockRect.left.toInt() ||
                    posicao.dx.toInt() <= 0))) {
              direcao = EnemieDirection.righdown;
            } else if (posicao.dy <= element.blockRect.bottom) {
              if (posicao.dx + 10 <= element.blockRect.right) {
                direcao = EnemieDirection.leftdown;
              } else {
                direcao = EnemieDirection.rightup;
              }
            } else {
              direcao = EnemieDirection.rightup;
            }
          } else if (direcao == EnemieDirection.rightup) {
            if ((posicao.dy.toInt() <= element.blockRect.bottom.toInt() + 1) &&
                ((posicao.dx.toInt() >= element.blockRect.right.toInt() ||
                    posicao.dx.toInt() <= element.blockRect.left.toInt() ||
                    posicao.dx.toInt() >=
                        this.gameController.screenSize.width - 1))) {
              direcao = EnemieDirection.leftdown;
            } else if (posicao.dy <= element.blockRect.bottom) {
              if (posicao.dx - 10 <= element.blockRect.left) {
                direcao = EnemieDirection.leftup;
              } else {
                direcao = EnemieDirection.righdown;
              }
            } else {
              direcao = EnemieDirection.leftup;
            }
          } else if (direcao == EnemieDirection.righdown) {
            if (posicao.dy.toInt() == element.blockRect.top.toInt() &&
                (posicao.dx.toInt() == element.blockRect.left.toInt() ||
                    posicao.dx.toInt() >=
                        this.gameController.screenSize.width)) {
              direcao = EnemieDirection.leftup;
            } else if (posicao.dy - 10 <= element.blockRect.top) {
              direcao = EnemieDirection.rightup;
            } else if (posicao.dx - 10 <= element.blockRect.left) {
              direcao = EnemieDirection.leftdown;
            } else {
              direcao = EnemieDirection.leftdown;
            }
          }
          if (element.isSpoiled) {
            if (element.isEnergy) {
              this.gameController.player.currentHealt++;
            } else {
              this.gameController.player.currentHealt--;
            }
          }
          //print( 'Tocou:' + element.blockColor.toString() );
          lcolide = true;
        }
      }
    });

    return lcolide;
  }

  bool detectColisionMarks() {
    Offset posicao;
    bool lcolide = false;
    this.gameController.marks.forEach((Mark element) {
      //element.colide(enemyRect));
      posicao = Offset(enemyRect.left, enemyRect.top);

      if (element.markRect.contains(posicao)) {
        //gameController.player.currentHealt-=50;
        //print( 'Mark-pegou:' );
        //matar mark -> element.isDead= true;
        lcolide = true;
      }
    });

    return lcolide;
  }

  bool detectColisionLimit() {
    EnemieDirection direcaoinicial = direcao;
    if (direcao == EnemieDirection.leftdown) {
      if (this.enemyRect.left <= 0 &&
          this.enemyRect.bottom >= this.gameController.screenSize.height) {
        direcao = EnemieDirection.rightup;
      } else if (enemyRect.left <= 0) {
        direcao = EnemieDirection.righdown;
      } else if (enemyRect.top + enemyRect.height >=
          this.gameController.screenSize.height) {
        direcao = EnemieDirection.leftup;
      }
    } else if (direcao == EnemieDirection.leftup) {
      if (enemyRect.left <= 0 && enemyRect.top <= 0) {
        direcao = EnemieDirection.righdown;
      } else if (enemyRect.left <= 0) {
        direcao = EnemieDirection.rightup;
      } else if (enemyRect.top <= 0) {
        direcao = EnemieDirection.leftdown;
      }
    } else if (direcao == EnemieDirection.rightup) {
      if (enemyRect.right >= gameController.screenSize.width &&
          enemyRect.top <= 0) {
        direcao = EnemieDirection.leftdown;
      } else if (enemyRect.right >= gameController.screenSize.width) {
        direcao = EnemieDirection.leftup;
      } else if (enemyRect.top <= 0) {
        direcao = EnemieDirection.righdown;
      }
    } else if (direcao == EnemieDirection.righdown) {
      if (enemyRect.bottom >= gameController.screenSize.height &&
          enemyRect.right >= gameController.screenSize.width) {
        direcao = EnemieDirection.leftup;
      } else if (enemyRect.bottom >= gameController.screenSize.height) {
        direcao = EnemieDirection.rightup;
      } else if (enemyRect.right >= gameController.screenSize.width) {
        direcao = EnemieDirection.leftdown;
      }
    }
    return (direcao != direcaoinicial);
  }

  bool killif() {
    if (this.gameController.inAnalise > 0) {
      if (detectInnerBlock()) {
        if (this.gameController.gameLevel.count() > 1) {
          print('Dentro do bloco [ morreu ]' + this.hashCode.toString());
          isDead = true;
        } else {
          print('Dentro do bloco [ último ]' + this.hashCode.toString());
        }
        //reposiciona();
      }
      --this.gameController.inAnalise;
    }
    return this.gameController.inAnalise > 0;
  }
}
