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
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
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
    super.dispose();
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
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;
      return new Center(
        child: new AspectRatio(
          aspectRatio: size.width / size.height,
          child: new VideoPlayPause(controller),
        ),
      );
    } else {
      return new Container();
    }
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
      //final VideoPlayerController controller = new VideoPlayerController(this.url,);
      //controller.setLooping(true);
      //controller.play();
      //controller.setVolume(0.0);
      //controller.initialize();

      //return new VideoPlayer(controller);

      //return new Image.network('https://www.webmproject.org/media/images/webm-558x156.png',
      //    height: 400.0,
      //    fit: BoxFit.fitWidth,
      //    gaplessPlayback: true,
      //    );
    }

    else if (this.url.endsWith('.mp4')) {

      return new PlayerLifeCycle(this.url,
          (BuildContext context, VideoPlayerController controller) => new AspectRatioVideo(controller));

      //final VideoPlayerController controller = new VideoPlayerController(this.url,);
      //controller.setLooping(true);
      //controller.play();
      //controller.setVolume(0.0);
      //controller.initialize();

      //return new VideoPlayer(controller);

      //return new Image.network('https://botw-pd.s3.amazonaws.com/styles/logo-thumbnail/s3/112012/mp4_video.jpg',
      //    height: 400.0,
      //    fit: BoxFit.fitWidth,
      //    gaplessPlayback: true,
      //    );
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
