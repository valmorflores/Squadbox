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
    return Scaffold(
      appBar: AppBar(title: Text('Fase Settings')),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('${gameController.level}'),
          ElevatedButton(
              child: Text("Go to level 30"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to 30');
                  gameController.resetlevels(30);
                });
              }),
          ElevatedButton(
              child: Text("Go to level 35"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to 35');
                  gameController.resetlevels(35);
                });
              }),
          ElevatedButton(
              child: Text("Go to level 40"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to 40');
                  gameController.resetlevels(40);
                });
              }),
          ElevatedButton(
              child: Text("Go to level 50"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to 50');
                  gameController.resetlevels(50);
                });
              }),
          ElevatedButton(
              child: Text("Go to level 60"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to 60');
                  gameController.resetlevels(60);
                });
              }),
          ElevatedButton(
              child: Text("Go to level +10"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to +10');
                  gameController.resetlevels(gameController.level + 10);
                });
              }),
          ElevatedButton(
              child: Text("Go to level -10"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to -10');
                  gameController.resetlevels(gameController.level - 10);
                });
              }),
          ElevatedButton(
              child: Text("Go to level +1"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to +1');
                  gameController.resetlevels(gameController.level + 1);
                });
              }),
          ElevatedButton(
              child: Text("Go to level -1"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg to -1');
                  gameController.resetlevels(gameController.level - 1);
                });
              }),
          ElevatedButton(
              child: Text("Reset levels"),
              onPressed: () {
                setState(() {
                  print('Sending reset msg');
                  gameController.resetlevels(5);
                });
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
