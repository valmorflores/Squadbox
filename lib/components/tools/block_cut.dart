import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:squadbox/components/blocks.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/models/enum_tools.dart';

class BlockCut extends Blocks{ 
  final GameController gameController;
  final ToolsArea? toolArea;
  final double top, left, width, height;
  late Rect normalRect1, normalRect2, normalRect3;
  Color blockColor;
  
  BlockCut({
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
     normalRect2 = Rect.fromLTWH( left + 5, top + 5, width / 2 - 10, height / 2 );
     normalRect3 = Rect.fromLTWH( left + 15, top + 10, width / 2 - 10, height - 15 );
  }

  @override 
  void render( Canvas c ){
     Paint cor1 = Paint()..color = Colors.lightBlueAccent;
     Paint cor2 = Paint()..color = Colors.blue;
     Paint cor3 = Paint()..color = Colors.redAccent;
     
     super.render(c);
     c.drawRect( normalRect1, cor1 );
     c.drawRect( normalRect2, cor2 );
     c.drawRect( normalRect3, cor3 );
       
  }

  @override 
  void update( double t ){
     super.update(t);
  }
}
