import 'package:flutter/material.dart';
import 'package:butterfly/ui/home/appbar.dart';
import 'package:butterfly/ui/home/memes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
          children: <Widget>[
            new AppBarX("demo"),
            new MemesX(),
    ]));
  }
}
