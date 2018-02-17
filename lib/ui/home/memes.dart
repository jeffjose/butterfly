import 'dart:async';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/routes.dart';
import 'package:butterfly/theme.dart' as Theme;
import 'package:butterfly/model/memedata.dart';
import 'package:flutter_image/network.dart';
import 'package:video_player/video_player.dart';

import 'package:butterfly/ui/components/video.dart';




class Media extends StatelessWidget {

  final String url;

  const Media({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //if (this.url.endsWith('.webm')) {

    //  return new PlayerLifeCycle(this.url,
    //      (BuildContext context, VideoPlayerController controller) => new AspectRatioVideo(controller));
    //}

    //else if (this.url.endsWith('.mp4')) {
    if (this.url.endsWith('.mp4')) {

      print("XXXXXXXXXXXXXX  3. Media.build(): Building JVideo: " + this.url);

      return new Video(url: this.url);
      //return new JVideo(this.url);
      //return new PlayerLifeCycle(this.url,
      //    (BuildContext context, VideoPlayerController controller) => new AspectRatioVideo(controller));
    }
    else {
      return new Container(
          color: Theme.Colors.mediaBackground,
          height: 350.0,
          child: new Image.network(this.url,
            fit: BoxFit.fitWidth,
            gaplessPlayback: true,
          )
          );
    }

  }

}

class MemeCard extends StatefulWidget {

  final Meme meme;
  final Widget media;
  Widget info;

  MemeCard({Key key, this.meme, this.media}) : super(key: key) {

    print("============================================");
    print("");
    print("");
    print("MemeCard");
    print("");
    print("============================================");

    info = new Row(children: <Widget>[
      new Text(this.meme.url),
      new Icon(Icons.comment),
    ]);


  }

  @override
  MemeCardState createState() => new MemeCardState();

}

class MemeCardState extends State<MemeCard> {

  @override
  void initState() {

    print("XXXXXXXXXXXXXX  2a. MemeCard.initState(). Building Media(): " + widget.meme.url);
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    print("XXXXXXXXXXXXXX  2. MemeCard.build(). Returning Card: " + widget.meme.url);

    return new Column(
        children: <Widget>[
          widget.media,
          widget.info
        ]
        );
  }
}

class Memes extends StatefulWidget {

  const Memes({Key key});

  @override
  MemesState createState() => new MemesState();

}

class MemesState extends State<Memes> {

  List<MemeCard> memes;

  @override
  void initState() {

    memes = MemeData.memes.map((Meme meme) => new MemeCard(meme: meme)).toList();

  }

  @override
  Widget build(BuildContext context) {

    print("XXXXXXXXXXXXXX  1. Memes.build()");

    return new Flexible(
        child: new Container(
           // child: new ListView.builder(
           //     itemCount: MemeData.memes.length,
           //     itemBuilder: (BuildContext context, int index) {
           //       print("XXXXXXXXXXXXXXXXXX");
           //       print("building");
           //       print(index);
           //       print("XXXXXXXXXXXXXXXXXX");
           //       return new MemeCard(MemeData.memes[index]);
           //     })

          child: new ListView(
            children: memes
            )

            ));
  }
}

class MemesX extends StatefulWidget {

  MemesX({Key key}) : super(key: key) {

  }

  @override
  MemesXState createState() => new MemesXState();
}

class MemesXState extends State<MemesX> {

    final VideoPlayerController controller = new VideoPlayerController('http://mirrors.standaloneinstaller.com/video-sample/DLP_PART_2_768k.mp4');

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return new Flexible(
        child: new ListView(
          //children: GIFS.memes.map((Meme meme) => new ImageXX(meme.url)).toList()
          children: WEBP.memes.map((Meme meme){

            // TODO: Assumption that this is always going to be ImageXX
            ImageXX media = new ImageXX(meme.url);
            return new MemeCard(meme: meme, media: media);
          }).toList()

          )
        );
  }

}
