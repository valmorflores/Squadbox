import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:SquadBox/components/blocks.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_tools.dart';


class BlockNormal extends Blocks{ 
  GameController gameController;
  ToolsArea toolArea;
  double top, left, width, height;
  Rect normalRect1, normalRect2, normalRect3;
  Color blockColor;
  
  BlockNormal({this.gameController, this.toolArea, this.top,
       this.left, this.width, this.height, this.blockColor = Colors.lightBlueAccent }){
     this.gameController = gameController;
     super.top = top;
     super.left = left;
     super.width = this.gameController.toolSize;
     super.height = this.gameController.toolSize;
     super.blockColor = Colors.lightBlueAccent;
     super.isEnergy = true;
     super.isSobreposto = true;
     super.blockRect = Rect.fromLTWH( left, top, width, height );
     normalRect1 = Rect.fromLTWH( left + 5, top + 5, width - 10, height - 10 );
      
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

