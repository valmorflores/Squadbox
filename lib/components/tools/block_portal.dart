import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:SquadBox/components/blocks.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_tools.dart';

class BlockPortal extends Blocks {
  GameController gameController;
  ToolsArea toolArea;
  double top, left, width, height;
  Rect energyRect1, energyRect2, energyRect3;
  Color blockColor;

  BlockPortal(
      {this.gameController,
      this.toolArea,
      this.top,
      this.left,
      this.width,
      this.height,
      this.blockColor = Colors.amber}) {
    this.gameController = gameController;
    super.top = top;
    super.left = left;
    super.width = this.gameController.toolSize;
    super.height = this.gameController.toolSize;
    super.blockColor = Colors.amber;
    super.isEnergy = true;
    super.isSobreposto = true;
    super.isPortal = true;
    super.blockRect = Rect.fromLTWH(left, top, width, height);
    energyRect1 = Rect.fromLTWH(left + 5, top + 5, width - 10, height - 10);
    energyRect2 = Rect.fromLTWH(left + 10, top + 10, width - 20, height - 20);
    energyRect3 = Rect.fromLTWH(left + 15, top + 15, width - 30, height - 30);
  }

  @override
  void render(Canvas c) {
    Paint cor1 = Paint()..color = Colors.black12;
    Paint cor2 = Paint()..color = Colors.black12;
    Paint cor3 = Paint()..color = Colors.black12;
    super.render(c);
    c.drawRect(energyRect1, cor1);
    c.drawRect(energyRect2, cor2);
    c.drawRect(energyRect3, cor3);
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
