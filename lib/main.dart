import 'dart:io';

import 'package:squadbox/main-old.dart';
import 'package:squadbox/screens/level_menu.dart';
import 'package:squadbox/screens/level_reset_position.dart';

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squadbox/controllers/gameController.dart';

import 'screens/experiments_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'squadbox',
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
    final game = MyGame(contexto: context);
    game.startgetprefs();
    game.getStatus();
    final int _highscore = game.getHightScore();
    final Widget oGame = GestureDetector(
      child: GameWidget(game: game),
      onTapDown: (details) {
        debugPrint('Tap on game');
        game.onTapDown(details);
      },
      onHorizontalDragStart: (details) {
        game.onHorizontalDragStart(details);
      },
      onHorizontalDragEnd: (details) {
        game.onHorizontalDragEnd(details);
      },
      onHorizontalDragUpdate: (details) {
        game.onHorizontalDragUpdate(details);
      },
      onVerticalDragStart: (details) {
        game.onVerticalDragStart(details);
      },
      onVerticalDragEnd: (details) {
        game.onVerticalDragEnd(details);
      },
      onVerticalDragUpdate: (details) {
        game.onVerticalDragUpdate(details);
      },
    );
    /*FirebaseAdMob.instance.initialize(appId: ADMOB_APP_ID)
      ..then((response) {
        myBanner
          ..load()
          ..show();
      });*/
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        ListTile(
            title: Text(
              'squadbox',
              style: TextStyle(fontSize: 28),
            ),
            subtitle: Text(
              'version 1.0.03',
              style: TextStyle(fontSize: 11),
            )),
        Text("Level: ${game.level.toString()}"),
        Text("HighScore: $_highscore"),
        SizedBox(
          height: 55,
        ),
        ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Play",
                style: TextStyle(fontSize: 64),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return oGame; //MyGame()
                }),
              );
            }),
        SizedBox(
          height: 5,
        ),
        ElevatedButton(
            child: Text("Reset levels"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LevelReset(
                          gameController: game,
                        )),
              );
            }),
        SizedBox(
          height: 5,
        ),
        ElevatedButton(
            child: Text("Experimentos"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExperimentsMenu(gameController: game,)),
              );
            }),
        SizedBox(
          height: 5,
        ),
        ElevatedButton(
            child: Text("Selecionar local"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelMenu()),
              );
            }),
        //levelListSelector()
      ],
    ));
  }

  @override
  void dispose() {
    //myBanner.dispose();
    //myInterstitial.dispose();
  }
}

Widget levelListSelector() {
  return FutureBuilder(
    future: levelList(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );
          break;
        case ConnectionState.done:
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            final data = snapshot.data as List<LevelModel>?;
            if (data == null) {
              return const SizedBox.shrink();
            }
            return ListView(
              children:
                  data.map((e) => ListTile(title: Text(e.name))).toList(),
            );
          }
          break;
        default:
          return Text('Unhandle State');
      }
    },
  );
}

Future<List<LevelModel>> levelList() async {
  List<LevelModel> levels = [];
  levels.add(LevelModel(
      id: 0,
      name: 'Terreo, ala A',
      description:
          'Área básica 1 - Prenda os poucos fugitivos que estão neste setor'));
  levels.add(LevelModel(
      id: 0,
      name: 'Terreo, setor A1',
      description:
          'Área básica A1 - Eles estão se aglomerando neste setor. Reduza seus espaços.'));
  levels.add(LevelModel(
      id: 0,
      name: 'Terreo, setor B',
      description:
          'Área básica B - Muitos estão tentando escapar. Reuna a equipe e neutralize os fugitivos.'));
  return levels;
}

class LevelModel {
  final int id;
  final String name;
  final String description;
  final int score;

  LevelModel({
    required this.id,
    required this.name,
    required this.description,
    this.score = 0,
  });
}

/*
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'games', 'ads', 'beautiful apps', 'uber'],
  contentUrl: 'https://flutter.io',
  //birthday: DateTime.now(),
  childDirected: false,
  //designedForFamilies: false,
  //gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  //testDevices: <String>[], // Android emulators are considered test devices
);*/

/*BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: ADMOB_UNIT_ID,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);
*/

/*InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);*/

class MyGame extends GameController {
  final BuildContext contexto;

  MyGame({required this.contexto}) {
    context = contexto;
    /////// -- Util flameUtil = Util();
    // `storage` será inicializado em `startgetprefs`.

    /* -- flameUtil.addGestureRecognizer(VerticalDragGestureRecognizer()
      ..onStart = this.onVerticalDragStart
      ..onEnd = this.onVerticalDragEnd
      ..onUpdate = this.onVerticalDragUpdate);

    flameUtil.addGestureRecognizer(HorizontalDragGestureRecognizer()
      ..onStart = this.onHorizontalDragStart
      ..onEnd = this.onHorizontalDragEnd
      ..onUpdate = this.onHorizontalDragUpdate);

    flameUtil.addGestureRecognizer(
        TapGestureRecognizer()..onTapDown = this.onTapDown);
  */
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

  getStatus() {
    final storedLevel = storage.getInt('level') ?? 0;
    if (storedLevel > 1) {
      level = storedLevel;
    }
  }

  int getHightScore() {
    final highScore = storage.getInt('highscore') ?? 0;
    if (highScore > 1) {
      return highScore;
    }
    return 0;
  }
}
