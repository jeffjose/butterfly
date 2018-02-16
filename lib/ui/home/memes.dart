import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/routes.dart';
import 'package:butterfly/theme.dart' as Theme;
import 'package:butterfly/model/memedata.dart';
import 'package:flutter_image/network.dart';

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

  const MemeCard({Key key, this.meme});

  @override
  MemeCardState createState() => new MemeCardState();

}

class MemeCardState extends State<MemeCard> {

  Media media;

  @override
  void initState() {

    print("XXXXXXXXXXXXXX  2a. MemeCard.initState(). Building Media(): " + widget.meme.url);
    media = new Media(url: widget.meme.url);
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    final info = new Row(children: <Widget>[
      new Text(widget.meme.url),
      new Icon(Icons.comment),
    ]);

    print("XXXXXXXXXXXXXX  2. MemeCard.build(). Returning Card: " + widget.meme.url);

    return new Container(
        color: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Column(children: <Widget>[media, info]),
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
