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
  final Media media;

  Widget widgets;

  MemeCard({Key key, this.meme}) : media = new Media(url: meme.url), super(key: key) {

    print("============================================");
    print("");
    print("");
    print("MemeCard");
    print("");
    print("============================================");

    final info = new Row(children: <Widget>[
      new Text(this.meme.url),
      new Icon(Icons.comment),
    ]);

    this.widgets = new Container(
        color: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Column(children: <Widget>[this.media, info]),
          );

  }

  @override
  MemeCardState createState() => new MemeCardState();

}

class MemeCardState extends State<MemeCard> {

  @override
  void initState() {

    print("XXXXXXXXXXXXXX  2a. MemeCard.initState(). Building Media(): " + widget.meme.url);
    //media = new Media(url: widget.meme.url);
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    //final info = new Row(children: <Widget>[
    //  new Text(widget.meme.url),
    //  new Icon(Icons.comment),
    //]);

    print("XXXXXXXXXXXXXX  2. MemeCard.build(). Returning Card: " + widget.meme.url);

    return widget.widgets;
    //return new Container(
    //    color: Colors.green,
    //    padding: const EdgeInsets.symmetric(vertical: 10.0),
    //    margin: const EdgeInsets.symmetric(vertical: 10.0),
    //    child: new Column(children: <Widget>[widget.media, info]),
    //      );
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

      //Future<Null> initController(VideoPlayerController controller) async {

      //   final bool controllerInitialized = controller.value.initialized;
      //   //print("-------------------------------");
      //   //print(controllerInitialized);
      //  controller.setLooping(true);
      //  controller.play();
      //  await controller.initialize();
      //  setState(() {});
      //}

      //initController(controller);
  }

  @override
  Widget build(BuildContext context) {

    return new Flexible(
    child: new ListView(
        children: <Widget>[
          new Text("VideoXX"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'),
          new Text("Inline"),
          //new Video(url: "foobar"),
          //new VideoPlayer(controller),
          //  new AspectRatio(
          //  aspectRatio: 1280/720,
          //  child: new VideoPlayer(controller)
          //),
          new Text("foobar"),
          //new Text("Inline"),
          //  new AspectRatio(
          //  aspectRatio: 1280/720,
          //  child: new VideoPlayer(controller)
          //),
          new Text("VideoXX"),
          //new VideoXX('http://mirrors.standaloneinstaller.com/video-sample/DLP_PART_2_768k.mp4'),
          new Text("foobar"),
          new Text("VideoX"),
          //new VideoX(controller),
          new Text("png"),
          new ImageXX('http://via.placeholder.com/350x150.png'),
          new Text("foobar"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("jpg"),
          new ImageXX('http://via.placeholder.com/350x150.jpg'),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("gif"),
          new ImageXX('http://via.placeholder.com/350x150.gif'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4'),
          new Text("xxxx"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("xxxx"),
          new Text("foobar"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("webm"),
          //new VideoXX('https://giant.gfycat.com/WaryGorgeousCamel.webm'),
          new Text("foobar"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("xxxx"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("webm"),
          //new VideoXX('https://giant.gfycat.com/oddballscrawnyadeliepenguin.webm'),
          new Text("foobar"),
          new Text("gif"),
          new ImageXX('http://via.placeholder.com/350x150.gif'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'),
          new Text("foobar"),
          new Text("foobar"),
          new Text("xxxx"),
          new Text("foobar"),
          new VideoXX('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
          new Text("foobar"),
          ]
          )
          );
  }
}
