import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:squadbox/components/blocks.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/models/enum_tools.dart';


class BlockEnergy extends Blocks{ 
  final GameController gameController;
  final ToolsArea? toolArea;
  final double top, left, width, height;
  late Rect energyRect1, energyRect2, energyRect3;
  Color blockColor;
  
  BlockEnergy({
    required this.gameController,
    this.toolArea,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    this.blockColor = Colors.lightGreenAccent,
  }) : super(
          gameController: gameController,
          left: left,
          top: top,
          width: width,
          height: height,
          blockColor: Colors.greenAccent,
          isSpoiled: true,
          isSobreposto: true,
        ) {
     // ajustar retângulos de energia em cima do blockRect criado em Blocks
     super.blockRect = Rect.fromLTWH( left, top, width, height );
     energyRect1 = Rect.fromLTWH( left + 5, top + 5, width - 10, height - 10 );
     energyRect2 = Rect.fromLTWH( left + 10, top + 10, width - 20, height - 20 );
     energyRect3 = Rect.fromLTWH( left + 15, top + 15, width - 30, height - 30 );
  }

  @override 
  void render( Canvas c ){
     Paint cor1 = Paint()..color = Colors.black12;
     Paint cor2 = Paint()..color = Colors.black12;
     Paint cor3 = Paint()..color = Colors.black12;
     super.render(c);
     c.drawRect( energyRect1, cor1 );
     c.drawRect( energyRect2, cor2 );
     c.drawRect( energyRect3, cor3 );      
  }

  @override 
  void update( double t ){
     super.update(t);
  }
}

