import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const String talkUri =
    'http://mirrors.standaloneinstaller.com/video-sample/DLP_PART_2_768k.mp4';

class VideoBuilder extends StatefulWidget {

  const VideoWidgetBuilder childBuilder;
  final String url;

  const VideoBuilder({this.url, this.childBuilder});

  @override
  VideoBuilderState createState() => new VideoBuilderState();
}

class VideoBuilderState extends State<VideoBuilder> {

  VideoPlayerController controller;

  @override
  void initState() {

    super.initState();
    controller = new VideoPlayerController(widget.uri);

    controller.initialize();
    controller.setLooping(true);
    controller.play();
  }


  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }
}

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
       print("INITIALIZING");
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
          child: new VideoBuilder(talkUri,
            (BuildContext context, VideoPlayerController controller) =>
              new VideoPlayer(controller))
          )
        );
  }

}
