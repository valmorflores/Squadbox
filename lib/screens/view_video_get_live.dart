import 'package:flutter/material.dart';

class ViewVideoGetLive extends StatefulWidget {
  final String parametro;

  ViewVideoGetLive({this.parametro}){
    print('Running here. Can show now?');
  }

  @override
  _ViewVideoGetLiveState createState() => _ViewVideoGetLiveState();
}

class _ViewVideoGetLiveState extends State<ViewVideoGetLive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vídeo / Ganhe 1 vida"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Clique aqui para volar!'),
        ),
      ),
    );
  }
}