import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:squadbox/components/blocks.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/models/enum_tools.dart';


class BlockNormal extends Blocks{ 
  final GameController gameController;
  final ToolsArea? toolArea;
  final double top, left, width, height;
  late Rect normalRect1, normalRect2, normalRect3;
  Color blockColor;
  
  BlockNormal({
    required this.gameController,
    this.toolArea,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    this.blockColor = Colors.lightBlueAccent,
  }) : super(
          gameController: gameController,
          left: left,
          top: top,
          width: width,
          height: height,
          blockColor: Colors.lightBlueAccent,
          isSpoiled: true,
          isSobreposto: true,
        ){
     normalRect1 = Rect.fromLTWH( left + 5, top + 5, width - 10, height - 10 );
     // normalRect2/3 não usados neste bloco
  }

  @override 
  void render( Canvas c ){
     Paint cor1 = Paint()..color = Colors.lightBlueAccent;
      
     super.render(c);
     c.drawRect( normalRect1, cor1 );
       
  }

  @override 
  void update( double t ){
     super.update(t);
  }
}

