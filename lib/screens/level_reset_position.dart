import 'package:SquadBox/controllers/gameController.dart';
import 'package:SquadBox/main-old.dart';
import 'package:flutter/material.dart';

class LevelReset extends StatefulWidget {
  GameController gameController;
  LevelReset({this.gameController});

  @override
  _LevelResetState createState() => _LevelResetState();
}

class _LevelResetState extends State<LevelReset> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
              child: Text("Go to level 30"),
              onPressed: () {
                print('Sending reset msg to 30');
                gameController.resetlevels(30);
              }),
          RaisedButton(
              child: Text("Go to level 35"),
              onPressed: () {
                print('Sending reset msg to 35');
                gameController.resetlevels(35);
              }),
          RaisedButton(
              child: Text("Go to level 40"),
              onPressed: () {
                print('Sending reset msg to 40');
                gameController.resetlevels(40);
              }),
          RaisedButton(
              child: Text("Go to level +1"),
              onPressed: () {
                print('Sending reset msg to +1');
                gameController.resetlevels(gameController.level + 1);
              }),
          RaisedButton(
              child: Text("Go to level -1"),
              onPressed: () {
                print('Sending reset msg to -1');
                gameController.resetlevels(gameController.level - 1);
              }),
          RaisedButton(
              child: Text("Reset levels"),
              onPressed: () {
                print('Sending reset msg');
                gameController.resetlevels(5);
              }),
          new Text(
            "9:50",
            style: new TextStyle(color: Colors.lightGreen, fontSize: 12.0),
          ),
          new CircleAvatar(
            backgroundColor: Colors.lightGreen,
            radius: 10.0,
            child: new Text(
              "2",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }
}
