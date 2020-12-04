import 'package:flutter/material.dart';

class LevelMenu extends StatefulWidget {
  @override
  _LevelMenuState createState() => _LevelMenuState();
}

class _LevelMenuState extends State<LevelMenu> {
  double topOne = 0;
  double topTwo = 100;
  double rateZero = 0;
  double rateOne = 0;
  double rateTwo = 0;
  double rateThree = 0;
  double rateFour = 0;
  double rateFive = 0;
  double rateSix = 0;
  double rateSeven = 0;
  double rateEight = 90;
  double leftOne = 0;
  double rateZeroLeft = -10;
  double rateOneLeft = 0;
  double rateTwoLeft = 0;
  double rateThreeLeft = 0;
  double _startX = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
          onNotification: (v) {
            // print( 'Drag sscroll ' + v.toString()  );
            // print(v.runtimeType);
            if (v is ScrollUpdateNotification) {
              setState(() {
                //print( v.dragDetails.globalPosition.direction..distance.toString() );
                topOne = topOne - v.scrollDelta / 3;
                topTwo = topTwo - v.scrollDelta / 1;
                rateEight -= v.scrollDelta / 1;
                rateSeven -= v.scrollDelta / 1.5;
                rateSix -= v.scrollDelta / 2;
                rateFive -= v.scrollDelta / 2.5;
                rateFour -= v.scrollDelta / 3;
                rateThree -= v.scrollDelta / 3.5;
                rateTwo -= v.scrollDelta / 4;
                rateOne -= v.scrollDelta / 4.5;
                rateZero -= v.scrollDelta / 5;
                /*
              rateZeroLeft -= v.scrollDelta / 3;
              rateOneLeft -= v.scrollDelta / 5;
              rateTwoLeft -= v.scrollDelta / 3.6;
              rateThreeLeft -= v.scrollDelta / 3.5;
              */
                rateZeroLeft -= 0;
                rateOneLeft -= 0;
                rateTwoLeft -= 0;
                rateThreeLeft -= 0;
              });
            }
          },
          child: Stack(
            children: <Widget>[
              ParallaxWidget(
                  left: rateZeroLeft, top: -110 + rateZero, asset: "parallax0"),
              ParallaxWidget(
                  left: rateOneLeft, top: 0 + rateOne, asset: "parallax1"),
              ParallaxWidget(
                  left: -25 + rateTwoLeft,
                  top: 0 + rateTwo,
                  width: 1100,
                  asset: "parallax2"),
              ParallaxWidget(
                  left: -50 + rateThreeLeft,
                  top: 0 + rateThree,
                  asset: "parallax3"),
              ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  GestureDetector(
                    onHorizontalDragStart: (v) {
                      setState(() {
                        _startX = v.globalPosition.dx;
                      });
                    },
                    onHorizontalDragUpdate: (v) {
                      dragUpdate(v);
                    },
                    child: Container(
                      height: 485,
                      color: Colors.transparent,
                    ),
                  ),
                  GestureDetector(
                    onHorizontalDragStart: (v) {
                      setState(() {
                        _startX = v.globalPosition.dx;
                      });
                    },
                    onHorizontalDragUpdate: (v) {
                      dragUpdate(v);
                    },
                    child: Container(
                      color: Color(0xff210002),
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Base Operacional",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: "MontSerrat-ExtraLight",
                                letterSpacing: 1.8,
                                color: Color(0xffffaf00)),
                          ),
                          Text(
                            "Center",
                            style: TextStyle(
                                fontSize: 51,
                                fontFamily: "MontSerrat-Regular",
                                letterSpacing: 1.8,
                                color: Color(0xffffaf00)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 190,
                            child: Divider(
                              height: 1,
                              color: Color(0xffffaf00),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Mission",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat-Extralight",
                              letterSpacing: 1.3,
                              color: Color(0xffffaf00),
                            ),
                          ),
                          Text(
                            "Invasão de prédio",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Montserrat-Regular",
                              letterSpacing: 1.8,
                              color: Color(0xffffaf00),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  dragUpdate(DragUpdateDetails v) {
    setState(() {
      if (v.globalPosition.dx > _startX) {
        if (rateZeroLeft < -10) {
          // print( 'left:' + _startX.toString() + '/' + v.globalPosition.dx.toString() );
          double fator = v.globalPosition.dx - _startX / 100;
          fator = 5;
          rateZeroLeft += fator * 0.90; //= v.globalPosition.dx;
          rateOneLeft += fator * 1.05; //v.globalPosition.dx;
          rateTwoLeft += fator * 1.20; // v.globalPosition.dx;
          rateThreeLeft += fator * 1.50; //v.globalPosition.dx;
          _startX = v.globalPosition.dx;
        }
      } else {
        _startX = v.globalPosition.dx;
        if (rateZeroLeft > -500) {
          double fator = 5;
          //print( 'right:' + _startX.toString() + '/' + v.globalPosition.dx.toString() );
          rateZeroLeft -= fator * 0.90; //v.globalPosition.dx;
          rateOneLeft -= fator * 1.05; // v.globalPosition.dx;
          rateTwoLeft -= fator * 1.20; //v.globalPosition.dx;
          rateThreeLeft -= fator * 1.50; //v.globalPosition.dx;
        }
      }
      //_lights = true;
    });
  }
}

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key key,
    @required this.left,
    @required this.top,
    this.width,
    @required this.asset,
  }) : super(key: key);

  final double left;
  final double top;
  final String asset;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        height: 550,
        width: width == null ? 900 : width,
        child: Image.asset("assets/images/$asset.png", fit: BoxFit.cover),
      ),
    );
  }
}
