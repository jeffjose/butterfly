import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:butterfly/theme.dart' as Theme;

const String talkUri =
    'http://mirrors.standaloneinstaller.com/video-sample/DLP_PART_2_768k.mp4';

class Video extends StatefulWidget {

  final String url;

  const Video({this.url});

  @override
  VideoState createState() => new VideoState();

}

class VideoState extends State<Video> {

  final VideoPlayerController controller = new VideoPlayerController(talkUri);

  @override
  void initState() {

    super.initState();

    Future<Null> initController(VideoPlayerController controller) async {

       final bool controllerInitialized = controller.value.initialized;
       print("-------------------------------");
       print(controllerInitialized);
      controller.setLooping(true);
      controller.play();
      await controller.initialize();
      setState(() {});
    }

    initController(controller);
    //initController(new VideoPlayerController(talkUri));
  }

  Widget build(BuildContext context) {

    return new Center(
        child: new AspectRatio(
          aspectRatio: 1280/720,
          child: new VideoPlayer(controller)
          )
        );
  }

}

class VideoX extends StatefulWidget {

  final VideoPlayerController controller;
  const VideoX(this.controller);

  @override
  VideoXState createState() => new VideoXState();

}

class VideoXState extends State<VideoX> {

  @override
  void initState() {

    super.initState();
    print('-------------- initState (VideoX)--------------');
  }

  @override
  void didUpdateWidget(VideoX oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('-------------- didUpdateWidget (VideoX)--------------');
  }

  @override
  Widget build(BuildContext context) {

    return new AspectRatio(
            aspectRatio: 1280/720,
            child: new VideoPlayer(widget.controller)
            );

  }

}

class VideoXX extends StatefulWidget {

  final String url;
  final VideoPlayerController controller;
  VideoXX(this.url) : controller = new VideoPlayerController(url);

  @override
  VideoXXState createState() => new VideoXXState();

}

class VideoXXState extends State<VideoXX> {

  @override
  void initState() {
    super.initState();
    print('-------------- initState (VideoXX)--------------');

      Future<Null> initController(VideoPlayerController controller) async {

         final bool controllerInitialized = controller.value.initialized;
         print("-------------------------------");
         print(controllerInitialized);
        if(controllerInitialized) {
          controller.pause();
        }
        else {
          controller.setLooping(true);
          controller.play();
          await controller.initialize();
        }
        setState(() {});
      }

      initController(widget.controller);
  }

  @override
  void didUpdateWidget(VideoXX oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('-------------- didUpdateWidget (VideoXX)--------------');
  }


  @override
  Widget build(BuildContext context) {

    return new AspectRatio(
            aspectRatio: 1280/720,
            child: new VideoPlayer(widget.controller)
            );

  }

}

class ImageXX extends StatelessWidget {

  final String url;

  ImageXX(this.url);

  @override
  Widget build(BuildContext context) {
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

