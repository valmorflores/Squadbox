import 'package:SquadBox/screens/level_menu.dart';
import 'package:SquadBox/screens/level_reset_position.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SquadBox/controllers/gameController.dart';
import 'package:flame/util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SquadBox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    int _highscore = 0;
    MyGame game; 
    Widget oGame;
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-9586126202838633~9512397826" )
       ..then((response){myBanner..load()..show();});
    if ( oGame == null ){
      game = MyGame(contexto: context);
      game.startgetprefs();
      int i=0;
      while ( game.storage == null && i<1 ){
         print( i.toString() + ': Waiting get storage functions...');
         ++i;
      }
      game.getStatus();
      _highscore = game.getHightScore();
      oGame = game.widget;
    } 

    return Scaffold(
      body: Column(children: <Widget>[
        Text( "Level: ${game.level.toString()}" ),
        Text( "HighScore: $_highscore" ),
        RaisedButton(
            child: Text("Play"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return oGame; //MyGame()
                }),
              );
            }),
            RaisedButton(
            child: Text("Reset levels"),
            onPressed: () {
              Navigator.push(
                context,                
                MaterialPageRoute(builder: (context) => LevelReset( gameController: game, )),
              );
            }),
            RaisedButton(
            child: Text("Selecionar local"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelMenu()),
              );
            }),
      ],
      )
      
    );
  }

  @override
  void dispose(){
    myBanner.dispose();
    myInterstitial.dispose();
  }

}


MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'games', 'ads', 'beautiful apps','uber'],
  contentUrl: 'https://flutter.io',
  //birthday: DateTime.now(),
  childDirected: false,
  //designedForFamilies: false,
  //gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  //testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-9586126202838633/3996540782",/*"ca-app-pub-9586126202838633/3996540782"*//*BannerAd.testAdUnitId*/
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);





class MyGame extends GameController {
  BuildContext contexto;
  SharedPreferences _storage;
  
  MyGame({this.contexto}) {

    context = contexto;
    Util flameUtil = Util();
    storage = _storage;
    
    flameUtil.addGestureRecognizer( VerticalDragGestureRecognizer() 
      ..onStart = this.onVerticalDragStart
      ..onEnd = this.onVerticalDragEnd
      ..onUpdate = this.onVerticalDragUpdate );

    flameUtil.addGestureRecognizer( HorizontalDragGestureRecognizer()
      ..onStart = this.onHorizontalDragStart
      ..onEnd = this.onHorizontalDragEnd
      ..onUpdate = this.onHorizontalDragUpdate );

    flameUtil.addGestureRecognizer( TapGestureRecognizer()
      ..onTapDown = this.onTapDown );
    

    @override
    void render(Canvas c) {
      super.render(c);
    }

    @override
    void update(double t) {
      super.update(t);
    }

    @override
    void onTapDown(TapDownDetails d) {
      
        print('Tap no myGame bro.');
        super.onTapDown(d);
      
    }

    @override
    void onHorizontalDragStart(DragStartDetails d) {
       super.onHorizontalDragStart(d);
    }
     
    @override
    void onHorizontalDragEnd(DragEndDetails d) {
      super.onHorizontalDragEnd(d);
    }

    @override
    void onHorizontalDragUpdate(DragUpdateDetails d) {
      super.onHorizontalDragUpdate(d);
    }
    
    @override
    void onVerticalDragStart(DragStartDetails d) {
       super.onVerticalDragStart(d);
    }
     
    @override
    void onVerticalDragEnd(DragEndDetails d) {
      super.onVerticalDragEnd(d);
    }

    @override
    void onVerticalDragUpdate(DragUpdateDetails d) {
      super.onVerticalDragUpdate(d);
    }


  }
   @override
    void startgetprefs() async {
      super.startgetprefs();    
    }
  

    getStatus(){
      if ( this.storage != null ){
        if ( this.storage.getInt('level')??0 > 1 ){
          this.level = this.storage.getInt('level');
        }
      }
        
    }

    int getHightScore(){
      if ( this.storage != null ){
          if ( this.storage.getInt('highscore')??0 > 1 ){
              return this.storage.getInt('highscore');
          }
          else
          {
            return 0;
          }
      }
      else
      { 
        return 0; 
      }
    }
}
