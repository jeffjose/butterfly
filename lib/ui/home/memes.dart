import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/routes.dart';
import 'package:butterfly/theme.dart' as Theme;
import 'package:butterfly/model/memedata.dart';
import 'package:flutter_image/network.dart';
import 'package:video_player/video_player.dart';


class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  AspectRatioVideo(this.controller);

  @override
  AspectRatioVideoState createState() => new AspectRatioVideoState();
}

/// Controls play and pause of [controller].
///
/// Toggles play/pause on tap (accompanied by a fading status icon).
///
/// Plays (looping) on initialization, and mutes on deactivation.
class VideoPlayPause extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPlayPause(this.controller);

  @override
  State createState() {
    return new _VideoPlayPauseState();
  }
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  FadeAnimation imageFadeAnim =
      new FadeAnimation(child: new Icon(Icons.play_arrow, size: 100.0));
  VoidCallback listener;

  _VideoPlayPauseState() {
    listener = () {
      setState(() {});
    };
  }

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
    controller.setVolume(1.0);
    controller.play();
  }

  @override
  void deactivate() {
    controller.setVolume(0.0);
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      new GestureDetector(
        child: new VideoPlayer(controller),
        onTap: () {
          if (!controller.value.initialized) {
            return;
          }
          if (controller.value.isPlaying) {
            imageFadeAnim =
                new FadeAnimation(child: new Icon(Icons.pause, size: 100.0));
            controller.pause();
          } else {
            imageFadeAnim = new FadeAnimation(
                child: new Icon(Icons.play_arrow, size: 100.0));
            controller.play();
          }
        },
      ),
      new Align(
        alignment: Alignment.bottomCenter,
        child: new VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      ),
      new Center(child: imageFadeAnim),
    ];

    return new Stack(
      fit: StackFit.passthrough,
      children: children,
    );
  }
}

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeAnimation({this.child, this.duration: const Duration(milliseconds: 500)});

  @override
  _FadeAnimationState createState() => new _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? new Opacity(
            opacity: 1.0 - animationController.value,
            child: widget.child,
          )
        : new Container();
  }
}

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

/// A widget connecting its life cycle to a [VideoPlayerController].
class PlayerLifeCycle extends StatefulWidget {
  final VideoWidgetBuilder childBuilder;
  final String uri;

  PlayerLifeCycle(this.uri, this.childBuilder);

  @override
  _PlayerLifeCycleState createState() => new _PlayerLifeCycleState();
}

class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

  _PlayerLifeCycleState();

  @override
  void initState() {
    super.initState();
    controller = new VideoPlayerController(widget.uri);
    //controller.addListener(() {
    //  if (controller.value.hasError) {
    //    print(controller.value.errorDescription);
    //  }
    //});
    controller.initialize();
    controller.setLooping(true);
    controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    controller.pause();
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    print("controller.pause()");
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {

    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    print("mounted");
    print(mounted);
    print(initialized);
    print(controller.value.initialized);
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        setState(() {
          initialized = controller.value.initialized;
        });
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;

      return new Container(
        height: 350.0,
        color: Theme.Colors.mediaBackground,
        child: new Center(
          child: new AspectRatio(
            aspectRatio: size.width / size.height,
            child: new VideoPlayPause(controller),
          ),
        )
      );
    } else {
      return new Container(height: 350.0);
    }
  }
}

class JVideoStateless extends StatelessWidget {

  final String url;

  const JVideoStateless(this.url);

  @override
  Widget build(BuildContext context) {

    VideoPlayerController controller = new VideoPlayerController(this.url);
    controller.initialize();
    controller.play();
    return new VideoPlayer(controller);

  }

}

class JVideo extends StatefulWidget {

  final String url;

  JVideo(this.url);

  @override
  _JVideoState createState() => new _JVideoState();
}

class _JVideoState extends State<JVideo> {

   VideoPlayerController controller;
   void initState() {
      this.controller = new VideoPlayerController(widget.url);
      this.controller.initialize();
      this.controller.play();
   }

  @override
  Widget build(BuildContext context) {
    return new VideoPlayer(this.controller);
  }
}

class Media extends StatelessWidget {

  final String url;

  const Media({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (this.url.endsWith('.webm')) {

      return new PlayerLifeCycle(this.url,
          (BuildContext context, VideoPlayerController controller) => new AspectRatioVideo(controller));
    }

    else if (this.url.endsWith('.mp4')) {

      print("XXXXXXXXXXXXXX  3. Media.build(): Building JVideo: " + this.url);

      return new JVideoStateless(this.url);
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

class MemeItem extends StatelessWidget {
  final Meme meme;

  MemeItem(this.meme);

  @override
  Widget build(BuildContext context) {
    final info = new Row(children: <Widget>[
      new Text(meme.url),
      new Icon(Icons.comment),
    ]);

      print("XXXXXXXXXXXXXX  2. MemeItem.build(). Building Media(): " + meme.url);


    final media = new Media(url: meme.url);

    return new Container(
        color: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Column(children: <Widget>[media, info]),
          );
  }
}

class Memes extends StatelessWidget {
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
           //       return new MemeItem(MemeData.memes[index]);
           //     })

          child: new ListView(
            children: MemeData.memes.map((Meme meme) => new MemeItem(meme)).toList()
            )

            ));
  }
}
