
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:squadbox/components/enemy.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/controllers/gameDesafios.dart';
import 'package:squadbox/models/enum_desafios.dart';
import 'package:squadbox/models/enum_enemy.dart';
import 'package:squadbox/models/enum_state.dart';

class DesafioStatus {
  final GameController gameController;
  late Rect statusRect;
  late TextPainter painterChefao;
  late TextPainter painterGangster;
  late TextPainter painterGerente;
  late Offset positionChefao;
  late Offset positionGangster;
  late Offset positionGerente;
  int perc = 0;
  double nCiclos = 0;
  
  List<DesafiosItem>? desafios;
  late Enemy enemyChefao;
  late Enemy enemyGangster;
  late Enemy enemyGerente;

  DesafioStatus({required this.gameController}) {
     statusRect = const Rect.fromLTWH(10, 40, 100, 110);
     // Gangster
     enemyGangster = Enemy( gameController: this.gameController,
               enemyType: EnemyType.gangster, x: 15, y: 50 );
     painterGangster = TextPainter(
          textAlign: TextAlign.center, textDirection: TextDirection.ltr);
     positionGangster = Offset( 45, 50 );
     // Gerente
     enemyGerente = Enemy( gameController: this.gameController,
               enemyType: EnemyType.gerente, x: 15, y: 80 );
     painterGerente = TextPainter(
          textAlign: TextAlign.center, textDirection: TextDirection.ltr);
     positionGerente = Offset( 45, 80 );
     // Chefao
     enemyChefao = Enemy( gameController: this.gameController,
               enemyType: EnemyType.chefao, x: 15, y: 110 );
     painterChefao = TextPainter(
          textAlign: TextAlign.center, textDirection: TextDirection.ltr);
     positionChefao = Offset( 45, 110 );
     
  }

  void update( double t ){
    if ( this.gameController.state == StateGame.playing ) {
      // hoje não usamos a lista diretamente aqui, mas garantimos que existe
      desafios = gameController.desafios.items;
        /*
        if ( e.desafio == DesafiosGame.capturar ){
            painter.color = Colors.redAccent;
        }
        if ( e.desafio == DesafiosGame.resgatar ){
            painter.color = Colors.teal;
        }
        if ( e.desafio == DesafiosGame.matar ){
            painter.color = Colors.amber;
        }
        */
      });
      // Gangster
      if ((painterGangster.text ?? '') != '0000') {
        painterGangster.text = TextSpan(
          text: this.gameController.enemyCountCaptured(EnemyType.gangster).toString() + ' / ' + this.gameController.desafios.countbyenemytype(EnemyType.gangster).toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        );

        painterGangster.layout();
         
      }

      // Gerente
      if ((painterGerente.text ?? '') != '0000') {
        painterGerente.text = TextSpan(
          text: this.gameController.enemyCountCaptured(EnemyType.gerente).toString() + '/' + 
                this.gameController.desafios.countbyenemytype(EnemyType.gerente).toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        );
        painterGerente.layout();
      }
      
      // Chefao
      if ((painterChefao.text ?? '') != '0000') {
        painterChefao.text = TextSpan(
          text: this.gameController.enemyCountCaptured(EnemyType.chefao).toString() + '/' +
                this.gameController.desafios.countbyenemytype(EnemyType.chefao).toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        );
        painterChefao.layout();
      }

      // Alerta / Piscar
      int ini_gangsters = this.gameController.desafios.countbyenemytype(EnemyType.gangster); 
      int ini_gangsters_vivos = this.gameController.enemyCount( EnemyType.gangster); 
      int ini_gangsters_alerta = ( ini_gangsters + (ini_gangsters * .30) ).toInt();
      if ( ini_gangsters_vivos <= ini_gangsters_alerta ) {
        if ( this.nCiclos * t > 0.20 ){
           this.perc<=2?++this.perc:this.perc=0;
           //print( this.nCiclos * t );
           this.nCiclos = 0;                      
        }
        ++this.nCiclos;
      }
      else 
      { 
         this.perc=0; 
      }

    }
  }

  void render(Canvas c){
    double nI=0.10;
    Paint silverColor = Paint()..color = Color.fromRGBO( 0, 0, 0, nI );
    if ( this.perc == 0 ){
       nI=0.12;
       silverColor = Paint()..color = Color.fromRGBO( 0, 0, 0, nI );
    }
    else if ( this.perc == 2 ){
      nI=0.30;
      silverColor = Paint()..color = Color.fromRGBO( 255, 0, 0, nI );
    }
    else if ( this.perc == 3 ){
      nI=0.50;
      silverColor = Paint()..color = Color.fromRGBO( 0, 0, 0, nI );
    }
    
    c.drawRect( statusRect, silverColor);
    enemyGangster.render(c);
    enemyGerente.render(c);
    enemyChefao.render(c);
    painterGangster.paint(c, positionGangster);
    painterGerente.paint(c, positionGerente);
    painterChefao.paint(c, positionChefao);
  }

}