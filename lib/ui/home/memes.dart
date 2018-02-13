import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/routes.dart';
import 'package:butterfly/theme.dart' as Theme;
import 'package:butterfly/model/memedata.dart';
import 'package:flutter_image/network.dart';
//import 'package:flutter_animated/animated_gif.dart';
import 'package:video_player/video_player.dart';

class Media extends StatelessWidget {

  final String url;

  const Media({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (this.url.endsWith('.webm')) {

      return new Image.network('https://www.webmproject.org/media/images/webm-558x156.png',
          height: 400.0,
          fit: BoxFit.fitWidth,
          gaplessPlayback: true,
          );
    }

    else if (this.url.endsWith('.mp4')) {

      return new Image.network('https://botw-pd.s3.amazonaws.com/styles/logo-thumbnail/s3/112012/mp4_video.jpg',
          height: 400.0,
          fit: BoxFit.fitWidth,
          gaplessPlayback: true,
          );
    }
    else {
      return new Image.network(this.url,
          height: 400.0,
          fit: BoxFit.fitWidth,
          gaplessPlayback: true,
          );
    }

  }

}

class MemeItem extends StatelessWidget {
  final Meme meme;

  MemeItem(this.meme);

  @override
  Widget build(BuildContext context) {
    final info = new Row(children: <Widget>[
      new Text(meme.url),
      new Icon(Icons.comment),
    ]);

    //final image = new Image.network(
    //    meme.url,
    //    height: 400.0,
    //    fit: BoxFit.fitWidth,
    //    gaplessPlayback: true
    //    );


    final media = new Media(url: meme.url);

    return new Column(children: <Widget>[media, info]);
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
