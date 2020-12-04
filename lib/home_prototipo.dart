import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'models/enum_game.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  double _x1 = 0.0;
  double _x2 = 0.0;
  double _y1 = 0.0;
  double _y2 = 0.0;
  double _vX = 0.0;
  double _vY = 0.0;
  double _top = 500.0;
  double _left = 0.0;
  double _passadas = 0;
  double _startpoint = 0;
  double _right = 0;
  int _vertical = 0; 
  int _horizontal = 0;
  int _desenha = 0;
  EnemieDirection _direction = EnemieDirection.leftup;
  bool _programado = false;

  Color corFundo = Colors.amber;//.redAccent;//Color.fromRGBO(50, 255, 255, 1);
  Color corVertical = Colors.blueAccent; //.fromRGBO(0, 0, 0, 0.25)
  Color corHorizontal = Colors.pink; //.fromRGBO(0, 0, 0, 0.25)
  Ticker _ticker;

   

  _run_timer(){
     if (!_programado){
      _programado = true;
      
      Timer.periodic(Duration(milliseconds: 30),
        (x){ _changeinimigo();
            //print('time now:' + x.toString()); 
          
        });
    }
     
}

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    print('acionar tick');
    _run_timer();
    _reset();
  }

  void _saveend( double x, y ){
    setState(() {

      _x2 = x;
      _y2 = y;
      if ( _x2 <= _x1 ){
        _x2 = _x1 + 10;
      } 
      if ( _y2 <= _y1 ){
        _y2 = _y1 + 10;
      }
 
    });
  }

  void _saveendvertical( double x, y ){
    setState(() {

      _vX = x;
      _vY = y;
       
    });
  }

  void _savestart( double x, y ){
    setState(() {
      _x1 = x;
      _y1 = y;
    });
  }

  void _do(){
    setState(() {
       _desenha = 1;
    });
  }

  Widget _reset(){
    setState(() {
      _x1 = 0.0;
      _y1 = 0.0;
      _x2 = 0.0;
      _y2 = 0.0;
      _vX = 0.0;
      _vY = 0.0;
      _desenha = 0;
      _vertical = 0;
      _horizontal = 0;
    });
    return Container();
  }

  void _setvertical(){
    setState(() {
      _vertical = 1;
      //_horizontal = 0;
    });
  }


  void _sethorizontal(){
    setState(() {
      //_vertical = 0;
      _horizontal = 1;
    });
  }

  _changeinimigo(){
      setState(() {
            var _leftminimo = _vX;
            //_passadas = _passadas +1;
            //if (_passadas<=2){
            //  _passadas = 0 ;
            if (_direction == EnemieDirection.leftdown || _direction == EnemieDirection.leftup ){
               _left = _left-1;
               if ( _left <= _leftminimo ){
                   if (_direction==EnemieDirection.leftdown){
                      _direction=EnemieDirection.righdown;
                   }
               }
            }  
            if (_direction == EnemieDirection.righdown || _direction == EnemieDirection.rightup ){
               _left = _left+1;
               if ( _left > _right-10 ){
                   if (_direction==EnemieDirection.righdown){
                      _direction=EnemieDirection.leftdown;
                   } else if (_direction==EnemieDirection.rightup){
                      _direction=EnemieDirection.leftup;
                   }
               }
            }  
            if (_direction == EnemieDirection.leftdown || _direction == EnemieDirection.leftup ){
               _left = _left-1;
               if ( _left <= _leftminimo ){
                   if (_direction==EnemieDirection.leftdown){
                      _direction=EnemieDirection.righdown;
                   } else 
                   {
                      _direction=EnemieDirection.rightup;
                   }
               }
            }  



              if (_direction == EnemieDirection.leftup || _direction == EnemieDirection.rightup ){
                 _top = _top -3;
              }
              if (_direction == EnemieDirection.leftdown || _direction == EnemieDirection.righdown ){
                 _top = _top +3;
              }
              if ( _top <= _y2 ) {
                if (_direction == EnemieDirection.leftup){
                  _direction = EnemieDirection.leftdown;
                }
                if (_direction == EnemieDirection.rightup){
                  _direction = EnemieDirection.righdown;
                }                
                // _top = _startpoint;
              }
              if ( _top <= 0.0 ){
                //_top = _startpoint;
                if (_direction == EnemieDirection.leftup){
                  _direction = EnemieDirection.leftdown;
                } else if ( _direction == EnemieDirection.rightup){
                  _direction = EnemieDirection.righdown;
                }
              }
              if ( _top >= _startpoint ){
                 if ( _direction == EnemieDirection.righdown ){
                    _direction = EnemieDirection.rightup;
                 } else if ( _direction == EnemieDirection.leftdown ){
                    _direction = EnemieDirection.leftup;
                 }                
              }

            //}
          });
  }


  Widget _inimigo(){
    _changeinimigo();     
    return Positioned( top: _top, left: _left, 
        child: Container( decoration: BoxDecoration( color: Colors.black), 
             width: 20, height: 20, 
            child: Text( 'O'), 
            )
             );
  }

  _setstart( size ){
    _startpoint = size.height;
    _right = size.width;
  }

  @override
  Widget build(BuildContext context) {
     
    var size = MediaQuery.of(context).size;
    _setstart( size );
    return Scaffold(
      /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Stack(children: <Widget>[
            
            Center( child: 
            GestureDetector( 
              onVerticalDragStart: (DragStartDetails start) =>
                 _onDragStartVertical(context, start),
              onVerticalDragUpdate: (DragUpdateDetails update) =>
                 _onDragUpdateVertical(context, update),
              onVerticalDragEnd: (DragEndDetails end) =>
                 _onDragEndVertical(context, end),
              onHorizontalDragStart: (DragStartDetails start) =>
                 _onDragStart(context, start), 
              onHorizontalDragUpdate: (DragUpdateDetails update) =>
                 _onDragUpdate(context, update),
              onHorizontalDragEnd: (DragEndDetails end) =>
                 _onDragEnd( context, end),
            child: 
             Container( 
              //margin: EdgeInsets.fromLTRB(0,0,0,0),
              //alignment: Alignment.topCenter,
              height: size.height, 
              width: size.width, 
              child: Container(),
              //child: new Center( child: Text('Texto padrao $_passadas = (\n$_x1,\n$_y1,\n$_x2,\n$_y2)') ), 
              decoration: BoxDecoration(color: corFundo ), 
              alignment: Alignment(0.0, 0.0), ),          
              
              )
            ),
            _inimigo(),
            _desenha==1 && _horizontal==1?new Positioned( top: 0 /*_y1-20*/, left: 0/*_x1-20*/, 
                child: AnimatedContainer( duration: Duration(seconds:2), 
                curve: Curves.fastOutSlowIn,width: size.width/*_x2-_x1*/, height: _y2 /*-_y1*/,
                 decoration: BoxDecoration(color:corHorizontal),)
              ):Container( child: Text('...' )),
            _desenha==1 && _vertical==1?new Positioned( top: _y2 /*_y1-20*/, left: 0/*_x1-20*/,           
                child: AnimatedContainer( duration: Duration(seconds:2), 
                curve: Curves.fastOutSlowIn,width: _vX/*_x2-_x1*/, height: _vY /*-_y1*/,
                 decoration: BoxDecoration(color:corVertical),)
              ):Container( child: Text('...' )),
            _desenha==1?/*_reset()*/Container():Container(),
            
            
            
            ],
            
            ),
            //Text(
            //  'You have pushed the button this many times:',
            //),
            /*Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),*/
           ],
        ),
      ),
      floatingActionButton: FloatingActionButton(        
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.pink,
        child: Icon(Icons.refresh ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onDragStartVertical(BuildContext context, DragStartDetails start) {
    print(start.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(start.globalPosition);
    print(local.dx.toString() + "-" + local.dy.toString());
    _setvertical();
  }

  _onDragUpdateVertical(BuildContext context, DragUpdateDetails update) {
    //print(update.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(update.globalPosition);
    print(local.dx.toString() + "-" + local.dy.toString());
    _saveendvertical( local.dx, local.dy );
  }

  _onDragStart(BuildContext context, DragStartDetails start) {
    print('começou');
    print(start.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(start.globalPosition);
    print(local.dx.toString() + "|" + local.dy.toString());
    _savestart( local.dx, local.dy );
    _sethorizontal();
  }

  _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    //print(update.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(update.globalPosition);
    _saveend( local.dx, local.dy );
    print(local.dx.toString() + "|" + local.dy.toString());
  }

  _onDragEnd(BuildContext context, DragEndDetails end) {
    //print(update.globalPosition.toString());
    //RenderBox getBox = context.findRenderObject();
    //var local = getBox.globalToLocal(end.toString());
    print('chegou ao final');
    _do();
    //Column( children: <Widget>[ Container( width: 100, height: 100,
    //   decoration: BoxDecoration( color:Colors.redAccent ) ,)],
    //);
  }

  _onDragEndVertical(BuildContext context, DragEndDetails end) {
    //print(update.globalPosition.toString());
    //RenderBox getBox = context.findRenderObject();
    //var local = getBox.globalToLocal(end.toString());
    print('chegou ao final vertical');
    _do();
    //Column( children: <Widget>[ Container( width: 100, height: 100,
    //   decoration: BoxDecoration( color:Colors.redAccent ) ,)],
    //);
  }

}
