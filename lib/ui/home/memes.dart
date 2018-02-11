import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/routes.dart';
import 'package:butterfly/theme.dart' as Theme;
import 'package:butterfly/model/memedata.dart';
import 'package:flutter_image/network.dart';
//import 'package:flutter_animated/animated_gif.dart';

class MemeItem extends StatelessWidget {
  final Meme meme;

  MemeItem(this.meme);

  @override
  Widget build(BuildContext context) {
    final info = new Row(children: <Widget>[
      new Text(meme.url),
      new Icon(Icons.comment),
    ]);

    final image = new Image(
      fit: BoxFit.fitHeight,
      image: new NetworkImageWithRetry(meme.url),
    );

    return new Column(children: <Widget>[image, info]);
  }
}

class Memes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Flexible(
        child: new Container(
            child: new ListView.builder(
                itemCount: MemeData.memes.length,
                itemBuilder: (BuildContext context, int index) {
                  return new MemeItem(MemeData.memes[index]);
                })));
  }
}
