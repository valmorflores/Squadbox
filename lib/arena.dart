import 'dart:ui';
import 'package:SquadBox/controllers/gameController.dart';

class Arena {

  final GameController gameController;
  
  List<List>arenalist;

  Arena( {this.gameController} ){
    arenalist = [];
    
    List<String> list = [];
    for ( int i=0; i<=gameController.screenSize.height+100; i++ ){
      list = [];
      for ( int j=0; j<=gameController.screenSize.width+100; j++ ){
         list.add('0');
      }
      arenalist.add(list);
    }
  }

  Offset addblock( {double top, double left, double height, double width} ){
    double maxheight, maxwidht;
    bool chegoulimite;
    maxheight = 0;
    maxwidht = 0;
    if ( left == null ){
      left =0;
    }
    if ( top == null ){
      top =0;
    }
    for ( double i=top; i<top+height; i++ ){      
      
      for ( double j=left; j<left+width; j++ ){
           
            if ( ( i >= 0 ) &&
                ( j >= 0 ) &&
                ( i < this.gameController.screenSize.height ) && 
                ( j < this.gameController.screenSize.width ) )
              if ( this.arenalist[i.toInt()][j.toInt()] == '0' ){
                this.arenalist[i.toInt()][j.toInt()]='1';
                maxheight = i;
                maxwidht = j;
              }
              else
              {
                
              }
           
      }
    }
    return Offset( maxwidht+1-left, maxheight+1-top ); 
  }
  
  printarena(){
    /*
    String cStr = '';    
    for ( int i=0; i<this.gameController.screenSize.height; i++ ){      
      cStr = '';
      for ( int j=0; j<this.gameController.screenSize.width; j++ ){
         cStr = cStr + this.arenalist[i][j];
      }
      //print( cStr );
    }
    */
  }

  double areaocupada(){
    double ocupacao = 0;
    for ( int i=0; i<this.gameController.screenSize.height; i++ ){
      for ( int j=0; j<this.gameController.screenSize.width; j++ ){
         if ( this.arenalist[i][j] != '0' ){
            ++ocupacao;
         }
      }      
    }
    return ocupacao;
  }


  bool contents( Offset coordenada ){
    double ocupacao, i, j;
    ocupacao = 0;
    j = coordenada.dx;
    i = coordenada.dy;
    if ( j > this.gameController.screenSize.height || j < 0 ){
      return false;
    }
    if ( i > this.gameController.screenSize.width || i < 0 ){
      return false;
    }

    if ( this.arenalist[j.toInt()][i.toInt()] != '0' ){
        ++ocupacao;
    }
    return ( ocupacao > 0 );
  }

}