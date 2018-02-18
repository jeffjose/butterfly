import 'dart:async';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final ScrollController scrollController;
  Widget info;

  double endPos;

  MemeCard({Key key, this.meme, this.media, this.scrollController, this.endPos}) : super(key: key) {



  }

  @override
  MemeCardState createState() => new MemeCardState();

}

class MemeCardState extends State<MemeCard> {


  @override
  void didUpdateWidget(Widget oldWidget){
    super.didUpdateWidget(oldWidget);

    print("######## UPDATE ${widget.meme.url}");

  }

  @override
  void dispose() {
    print("######## DISPOSE ${widget.meme.url} ${widget.scrollController}");
    widget.scrollController.removeListener(listener);
    super.dispose();

  }

  @override
  void initState() {

    print("######## INIT ${widget.meme.url}");
    super.initState();
    widget.scrollController.addListener(listener);

  }

  // The bounding box for context in global coordinates.
  Rect _globalBoundingBoxFor(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    assert(box != null && box.hasSize);
    return MatrixUtils.transformRect(box.getTransformTo(null), Offset.zero & box.size);
  }


  Future<Null> listener() async {

    if (mounted) {
      //print("mounted ${widget.scrollController}");

    }

  }

  @override
  Widget build(BuildContext context) {


    print("######## BUILD ${widget.meme.url}");
    final RenderBox box = context.findRenderObject();
    bool inView = false;
    if (box != null) {
      double offset = widget.scrollController.offset;
      double viewportDimension = widget.scrollController.position.viewportDimension;
      double viewportBottom   = offset + viewportDimension;
      double viewportMidpoint = offset + (viewportDimension/2);

      Rect bbox = _globalBoundingBoxFor(context);
      double top = bbox.top + offset;
      double bottom = bbox.bottom + offset;
      double widgetMidpoint = (top + bottom) / 2;

     // print("${widget.meme.url} ${widget.scrollController.position.viewportDimension} ${widget.scrollController.offset} ${context.size}");
      //print("${widget.meme.url} ${_globalBoundingBoxFor(context)}");
      //print("${widget.meme.url} viewportMidpoint: ${viewportMidpoint} widgetMidpoint: ${widgetMidpoint}");

      print("-------------");

      print("${widget.meme.url} bbox ${bbox}");
      print("${widget.meme.url} offset ${offset}");
      print("${widget.meme.url} top: ${top} -> bottom: ${bottom}");
      print("${widget.meme.url} viewportend ${offset + viewportDimension}");
      print("-------------");

      if ((top > offset) && (bottom < viewportBottom)) {
        print("${widget.meme.url} completly inside");
        inView = true;
      }

      //else if ((widgetMidpoint > offset) && (widgetMidpoint < offset + viewportDimension) ) {
      //  inView = false;
      //  print("${widget.meme.url} is in view");

      //}
      else {
        //print("${widget.meme.url} NOT is in view");
        inView = false;
      }
    }
    else {
      print("box is null");
      inView = false;
    }


    Widget info = new Row(children: <Widget>[
      new Text("${widget.meme.url} ${widget.endPos} ${inView}"),
      new Icon(Icons.comment),
    ]);

    Widget x = new ImageXX("http://via.placeholder.com/350x150.png");

    if (inView == true) {
      return new Column(
          children: <Widget>[
            widget.media,
            info,
          ]
          );
    }
    else {
      return new Column(
          children: <Widget>[
            x,
            info,
          ]
          );

    }
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
  final ScrollController scrollController = new ScrollController();

  double endPos = 10.0;

  double offset;

  @override
  void initState() {
    super.initState();

    //scrollController.addListener(listener);
    setState((){
      endPos = 0.0;
    });
  }


  //Future<Null> listener() async {
  //  print("");
  //  //print("positions: ${scrollController.position}");
  //  print("offset: ${scrollController.offset}");
  //  print(context.size);

  //  //setState(() => offset = scrollController.offset);

  //}

  bool _handleScrollNotification(ScrollNotification notification) {

    if (notification is ScrollStartNotification)  {
      //print("Starting to scroll ${notification.metrics.pixels}");

    }
    else if (notification is ScrollEndNotification)  {
      //print("End scroll at card: ~${notification.metrics.pixels ~/ 390}");
      setState((){
        endPos = notification.metrics.pixels;
      });

    }


    return false;

  }

  @override
  Widget build(BuildContext context) {

    return new Flexible(
        child: new NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,

          child: new ListView(
            controller: scrollController,
            //children: GIFS.memes.map((Meme meme) => new ImageXX(meme.url)).toList()

            //children: WEBP.memes.map((Meme meme){

            //  // TODO: Assumption that this is always going to be ImageXX
            //  ImageXX media = new ImageXX(meme.url);
            //  return new MemeCard(meme: meme, media: media);
            //}).toList()

            children: MemeData.memes.map((Meme meme){

              ImageXX media = new ImageXX("${meme.url}.png");
              return new MemeCard(meme: meme, media: media, scrollController: scrollController, endPos: endPos);

            }).toList()

            )
          )
        );
  }

}
