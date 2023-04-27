import 'package:flutter/rendering.dart';
import 'package:SquadBox/controllers/gameController.dart';

class Blocks {
  final GameController gameController;
  double left;
  double top;
  double width;
  double height;
  Color blockColor;
  Rect blockRect;
  bool isDead;
  bool isSpoiled;
  bool isEnergy;
  bool isSobreposto;
  bool isPortal;
  Rect get qualBlock {
    return this.blockRect;
  }

  Blocks(
      {this.gameController,
      this.left,
      this.top,
      this.width,
      this.height,
      this.blockColor,
      this.isSpoiled = true,
      this.isPortal = false,
      isSobreposto = false}) {
    //print( 'objeto blocks');

    Offset maximus;
    double sizewidth, sizeheight;
    this.isDead = false;
    this.isEnergy = false;
    if (width == null) {
      sizewidth = 50;
    }
    if (top == null) {
      top = 0;
    }
    if (left == null) {
      left = 0;
    }
    sizeheight = height;
    //print( width );
    if (isSobreposto) {
      sizewidth = width;
      sizeheight = height;
    } else {
      maximus = this
          .gameController
          .arena
          .addblock(top: top, left: left, height: height, width: width);
      sizewidth = maximus.dx;
      sizeheight = maximus.dy;
    }

    if (this.isSpoiled) {
      if (sizewidth > 50) {
        sizewidth = 50;
      }
      if (sizeheight > 50) {
        sizeheight = 50;
      }
    }

    if (sizeheight > 0 && sizewidth > 0) {
      this.blockRect = Rect.fromLTWH(left, top, sizewidth, sizeheight);
      /*print( 'Novo Bloco:' + 'l:' + left.toString() + ',' +
                            't:' + top.toString() + ',' + 
                            'w:' + sizewidth.toString() + ',' +
                            'h:' + sizeheight.toString() );
          print( this.gameController.blocks.length.toString() );                  
          */
      this.gameController.killifLTWH(left, top, sizewidth, sizeheight);
      //this.gameController.arena.printarena();
      aggregateToGroup();
      sumOccupation();
    } else {
      this.blockRect = Rect.fromLTWH(-1, -1, 1, 1);
      isDead = true;
    }
  }

  void render(Canvas c) {
    Paint useblockColor = Paint()..color = this.blockColor;
    c.drawRect(this.blockRect, useblockColor);
    //print( 'renderizacao de bloco: ' + this.blockRect.left.toString() +
    //   this.blockRect.top.toString() );
  }

  void update(double t) {}

  void aggregateToGroup() {
    Offset coordenada1, coordenada2, coordenada3, coordenada4;
    double l, t, b, r;
    this.gameController.blocks.forEach((f) {
      l = f.blockRect.left >= 0 ? f.blockRect.left : 0;
      t = f.blockRect.top >= 0 ? f.blockRect.top : 0;
      b = (f.blockRect.bottom <= this.gameController.screenSize.height
          ? f.blockRect.bottom
          : this.gameController.screenSize.height);
      r = (f.blockRect.right <= this.gameController.screenSize.width
          ? f.blockRect.right
          : this.gameController.screenSize.width);
      coordenada1 = Offset(l, t);
      coordenada2 = Offset(l, b);
      coordenada3 = Offset(r, t);
      coordenada4 = Offset(r, b);
      if (!f.isSpoiled) {
        /*print('block (not isSpoiled) normal ' + 't=' + t.toString() + ',' + 
                   'l=' + l.toString() + ',' + 
                   'b=' + b.toString() + ',' + 
                   'r=' + r.toString());
            */
      }
      if (f.isSpoiled) {
        if (this.blockRect.contains(coordenada1) ||
            this.blockRect.contains(coordenada2) ||
            this.blockRect.contains(coordenada3) ||
            this.blockRect.contains(coordenada4)) {
          f.isEnergy = this.isEnergy;
          f.isSpoiled = false;
          f.blockColor = this.blockColor;
          /*print( '> Block: t=' + t.toString() + ',' + 
                   'l=' + l.toString() + ',' + 
                   'b=' + b.toString() + ',' + 
                   'r=' + r.toString()
                  );
                  */
          //f.aggregateToGroup();
        } else {
          /*print( 'Block nao contem: t=' + t.toString() + ',' + 
                   'l=' + l.toString() + ',' + 
                   'b=' + b.toString() + ',' + 
                   'r=' + r.toString()
                  );
                */
        }
      }
    });
  }

  void sumOccupation() {
    this.gameController.ocupacao = this.gameController.arena.areaocupada();
  }
}
