import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:SquadBox/components/blocks.dart';
import 'package:SquadBox/components/tools/block_cut.dart';
import 'package:SquadBox/components/tools/block_energy.dart';
import 'package:SquadBox/components/tools/block_normal.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/models/enum_state.dart';
import 'package:SquadBox/models/enum_tools.dart';

class Tools {
  double position;
  double height;
  double limit;
  double _admobHeight = 50;
  GameController gameController;
  Blocks toolRect;
  List<ToolsItem> items;

  Tools({this.gameController}) {
    position = this.gameController.screenSize.height -
        this.gameController.screenSize.height * 0.10;
    height = this.gameController.screenSize.height * .10;
    limit = this.gameController.screenSize.height - (height / 2);
    toolRect = new Blocks(
        gameController: this.gameController,
        left: 0,
        top: position -  this._admobHeight,
        width: this.gameController.screenSize.width,
        height: this._admobHeight + this.gameController.screenSize.height * .10,
        blockColor: Color.fromRGBO(0, 0, 0, 0.07),
        isSpoiled: false);
    this.gameController.blocks.add(toolRect);
    this.items = [];

    void add(ToolsItem item) {
      this.items.add(item);
    }
  }

  void update(double t) {
    toolRect.update(t);
    this.items.forEach((ToolsItem f) => f.update(t));
  }

  void render(Canvas c) {
    toolRect.render(c);
    this.items.forEach((ToolsItem f) => f.render(c));
  }

  void decrement(ToolsType tooltype) {
    this.items.forEach((ToolsItem f) {
      if (f.tooltype == tooltype) {
        f.quantidade = (f.quantidade > 0) ? f.quantidade - 1 : 0;
        if (f.quantidade == 0) {
          f.tooltype = ToolsType.none;
          f.isSelect = false;
          this.gameController.toolsType = ToolsType.none;
        }
      }
    });
  }

  void increment(ToolsType tooltype) {
    this.items.forEach((ToolsItem f) {
      if (f.tooltype == tooltype) {
        f.quantidade = f.quantidade + 1;
      }
    });
  }

  int getQuantidade(ToolsType tooltypehere) {
    int quantidade = 0;
    this.items.forEach((ToolsItem f) {
        if (f.tooltype == tooltypehere) {
          quantidade = f.quantidade;
        }
    });
    return quantidade;
  }

  ToolsType onTapDown(TapDownDetails d) {
    ToolsType resposta = ToolsType.none;
    if (this.gameController.state == StateGame.playing) {
      this.items.forEach((ToolsItem f) {
        if (f.itemBlockEnergy != null) {
          if (f.itemBlockEnergy.blockRect.contains(d.globalPosition)) {
            resposta = ToolsType.add_energyblock;
            unselectall();
            f.isSelect = true;
          }
        }
        if (f.itemBlockNormal != null) {          
          if (f.itemBlockNormal.blockRect.contains(d.globalPosition)) {
            resposta = ToolsType.add_normalblock;
            unselectall();
            f.isSelect = true;
          }
        }
      });
    }
    return resposta;
  }

  unselectall(){
    this.items.forEach((ToolsItem f)=>f.isSelect=false);
  }

}


class ToolsItem {
  ToolsType tooltype;
  String name;
  int quantidade;
  BlockEnergy itemBlockEnergy;
  BlockNormal itemBlockNormal;
  BlockCut itemBlockCut;
  GameController gameController;
  bool isSelect;
  Rect selectRect;
  Rect selectRectNormal;
  Rect selectRectCut;
  TextPainter painter;
  TextPainter painterNormal;
  TextPainter painterCut;
  TextPainter paintersecondary;
  Offset position, positionNormal, positionCut, positionsecondary;
  Rect boxTexto;
  Rect boxTextoNormal;
  Rect boxTextoCut;

  ToolsItem({this.gameController, this.name, this.tooltype, this.quantidade}) {
    double _admobHeight = 50;
    if (this.tooltype == ToolsType.add_energyblock) {
      itemBlockEnergy = BlockEnergy(
          gameController: this.gameController,
          top: this.gameController.screenSize.height - ( 60 + _admobHeight ),
          left: 10,
          width: 35,
          height: 35);
      selectRect = Rect.fromLTWH(
          itemBlockEnergy.left - 6,
          itemBlockEnergy.top - 6,
          itemBlockEnergy.width + 12,
          itemBlockEnergy.height + 12);
      this.isSelect = false;
      painter = TextPainter(
          textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      position = Offset.zero;
      boxTexto = Rect.fromLTWH(0, 10, 10, 10);
    }

    if (this.tooltype == ToolsType.add_normalblock) {
      itemBlockNormal = BlockNormal(
          gameController: this.gameController,
          top: this.gameController.screenSize.height - ( 60 + _admobHeight ),
          left: 60,
          width: 35,
          height: 35);
      selectRectNormal = Rect.fromLTWH(
          itemBlockNormal.left - 6,
          itemBlockNormal.top - 6,
          itemBlockNormal.width + 12,
          itemBlockNormal.height + 12);
      this.isSelect = false;
      painterNormal = TextPainter(
          textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      positionNormal = Offset.zero;
      boxTextoNormal = Rect.fromLTWH(0, 10, 10, 10);
    }

    if (this.tooltype == ToolsType.status_cutblock) {
      itemBlockCut = BlockCut(
          gameController: this.gameController,
          top: this.gameController.screenSize.height - ( 60 + _admobHeight ),
          left: this.gameController.screenSize.width - 60,
          width: 35,
          height: 35);
      selectRectCut = Rect.fromLTWH(
          itemBlockCut.left - 6,
          itemBlockCut.top - 6,
          itemBlockCut.width + 12,
          itemBlockCut.height + 12);
      this.isSelect = false;
      painterCut = TextPainter(
          textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      positionCut = Offset.zero;
      boxTextoCut = Rect.fromLTWH(0, 10, 10, 10);
    }

  }

  void render(Canvas c) {
    if (itemBlockEnergy != null) {       
      //select.
      if (this.isSelect) {
        Paint cor3 = Paint()..color = Colors.black38;
        c.drawRect(selectRect, cor3);
      }
      itemBlockEnergy.render(c);
      Paint cor4 = Paint()
        ..color = this.quantidade > 0 ? Colors.green : Colors.blueGrey;
      c.drawRect(boxTexto, cor4);
      painter.paint(c, position);
    }
    if (itemBlockNormal != null) {
      //select.
      if (this.isSelect) {
        Paint cor3 = Paint()..color = Colors.black38;
        c.drawRect(selectRectNormal, cor3);
      }
      itemBlockNormal.render(c);
      Paint cor4 = Paint()
        ..color = this.quantidade > 0 ? Colors.green : Colors.blueGrey;
      c.drawRect(boxTextoNormal, cor4);
      painterNormal.paint(c, positionNormal);
    }
    if (itemBlockCut != null) {
      //select.
      if (this.isSelect) {
        Paint cor3 = Paint()..color = Colors.black38;
        c.drawRect(selectRectCut, cor3);
      }
      itemBlockCut.render(c);
      Paint cor4 = Paint()
        ..color = this.quantidade > 0 ? Colors.green : Colors.blueGrey;
      c.drawRect(boxTextoCut, cor4);
      painterCut.paint(c, positionCut);
    }
  }

  void update(double t) {
    if (itemBlockEnergy != null) {
      itemBlockEnergy.update(t);
      boxTexto = Rect.fromLTWH(itemBlockEnergy.blockRect.left + 17,
          itemBlockEnergy.blockRect.bottom - 7, 25, 18);
      if ((painter.text ?? '') != this.quantidade.toString()) {
        painter.text = TextSpan(
          text: this.quantidade > 99 ? '99+' : this.quantidade.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        );

        painter.layout();
        position = Offset(
          (itemBlockEnergy.blockRect.left + 20),
          (itemBlockEnergy.blockRect.bottom - 7),
          /*,
                ,*/
        );
      }
    }

    if (itemBlockNormal != null) {
      itemBlockNormal.update(t);
      boxTextoNormal = Rect.fromLTWH(itemBlockNormal.blockRect.left + 17,
          itemBlockNormal.blockRect.bottom - 7, 25, 18);
      if ((painterNormal.text ?? '') != this.quantidade.toString()) {
        painterNormal.text = TextSpan(
          text: this.quantidade > 99 ? '99+' : this.quantidade.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        );

        painterNormal.layout();
        positionNormal = Offset(
          (itemBlockNormal.blockRect.left + 20),
          (itemBlockNormal.blockRect.bottom - 7),
          /*,
                ,*/
        );
      }
    }

    if (itemBlockCut != null) {
      itemBlockCut.update(t);
      boxTextoCut = Rect.fromLTWH(itemBlockCut.blockRect.left + 17,
          itemBlockCut.blockRect.bottom - 7, 25, 18);
      if ((painterCut.text ?? '') != this.quantidade.toString()) {
        painterCut.text = TextSpan(
          text: this.quantidade > 99 ? '99+' : this.quantidade.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        );

        painterCut.layout();
        positionCut = Offset(
          (itemBlockCut.blockRect.left + 20),
          (itemBlockCut.blockRect.bottom - 7),
          /*,
                ,*/
        );
      }
    }

  }
}
