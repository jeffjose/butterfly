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


Rect _globalBoundingBoxFor(BuildContext context) {
  final RenderBox box = context.findRenderObject();
  assert(box != null && box.hasSize);
  return MatrixUtils.transformRect(box.getTransformTo(null), Offset.zero & box.size);
}

class MemeCard extends StatefulWidget {

  final Meme meme;
  final Widget image, video;

  final ScrollController scrollController;
  Widget info;

  double top;

  MemeCard({
    Key key,
    this.meme,
    this.image,
    this.video,
    this.scrollController,
    this.top}) : super(key: key) {


  }

  @override
  MemeCardState createState() => new MemeCardState();

}

class MemeCardState extends State<MemeCard> {

  @override
  void didUpdateWidget(Widget oldWidget){
    super.didUpdateWidget(oldWidget);

    print("######## ${widget.meme.id} UPDATE");

  }

  @override
  void dispose() {
    print("######## ${widget.meme.id} DISPOSE");
    widget.scrollController.removeListener(listener);
    super.dispose();

  }

  @override
  void initState() {

    print("######## ${widget.meme.id} INIT");
    super.initState();
    widget.scrollController.addListener(listener);

  }

  Future<Null> listener() async {

    if (mounted) {
      //print("mounted ${widget.scrollController}");
    }

  }

  @override
  Widget build(BuildContext context) {

    bool inView = false;


    print("######## ${widget.meme.id} BUILD");

    final RenderBox box = context.findRenderObject();
    double offset, viewportDimension, viewportBottom;
    double top, bottom;

    if (box != null) {
      Size size = MediaQuery.of(context).size;

      offset = widget.scrollController.offset;
      viewportDimension = size.height;
      viewportBottom   = offset + viewportDimension;

      Rect bbox = _globalBoundingBoxFor(context);
      top = bbox.top + offset;
      bottom = bbox.bottom + offset;

      if ((top > (offset + widget.top)) && (bottom < viewportBottom)) {
        inView = true;
      }

      else {
        //
      }
    }
    else {
      //print("box is null");
    }


    Widget info;

    if (box != null) {
      info = new Row(children: <Widget>[
        new Text("${widget.meme.id}"),
        new Icon(Icons.comment),
      ]);
    }
    else {
      info = new Row(children: <Widget>[
        new Text("${widget.meme.id}"),
        new Icon(Icons.comment),
      ]);
    }

    //Widget x = new ImageXX("http://via.placeholder.com/350x250.png");

    if (inView == true) {

      BorderSide border = new BorderSide(width: 6.0, color: Theme.Colors.activeColor);

      return new Container(
          decoration: new BoxDecoration(
            //border: new Border(top: border, bottom: border)
            //color: Theme.Colors.activeColor
            ),
          child: new Column(
            children: <Widget>[
              widget.video,
              //info,
              new Text("Completely inview - ${inView}", style: new TextStyle(color: Colors.green))
            ]
            )

          );
    }
    else {
      BorderSide border = new BorderSide(width: 6.0, color: Theme.Colors.inactiveColor);
      return new Container(
          decoration: new BoxDecoration(
            //border: new Border(top: border, bottom: border)
            ),
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[widget.video, widget.image]),
            //widget.image,
              //info,
              new Text("Completely inview - ${inView}")
            ]
            )

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

  double top = 0.0;

  double offset;

  @override
  void initState() {
    super.initState();

    setState((){
      top = 0.0;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {

    if (notification is ScrollStartNotification)  {
      //
    }
    else if (notification is ScrollEndNotification)  {

      Rect bbox = _globalBoundingBoxFor(context);

      setState((){
        top = bbox.top;
      });

    }


    return false;

  }

  @override
  Widget build(BuildContext context) {

    print("Memes BUILD");

    return new Flexible(
        child: new NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,

          child: new ListView(
            controller: scrollController,

            children: MemeData.memes.map((Meme meme){

              ImageXX image = new ImageXX("${meme.url}.png");
              ImageXX video = new ImageXX("${meme.url}.webp");
              //ImageXX video = new ImageXX("${meme.url}.png");
              //VideoXX video = new VideoXX("${meme.url}.mp4");
              return new MemeCard(meme: meme, image: image, video: video, scrollController: scrollController, top: top);

            }).toList()

            )
          )
        );
  }

}
