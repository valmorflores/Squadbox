import 'package:flutter/rendering.dart';
import 'package:squadbox/controllers/gameController.dart';

class Blocks {
  final GameController gameController;
  late double left;
  late double top;
  late double width;
  late double height;
  late Color blockColor;
  late Rect blockRect;
  bool isDead = false;
  bool isSpoiled;
  bool isEnergy = false;
  bool isSobreposto;
  bool isPortal = false;
  Rect get qualBlock {
    return this.blockRect;
  }

  Blocks(
      {required this.gameController,
      required this.left,
      required this.top,
      required this.width,
      required this.height,
      required this.blockColor,
      this.isSpoiled = true,
      this.isPortal = false,
      this.isSobreposto = false}) {
    //print( 'objeto blocks');

    Offset maximus;
    double sizewidth = width;
    double sizeheight = height;
    //print( width );
    if (!isSobreposto) {
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
