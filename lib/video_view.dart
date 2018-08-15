import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_content.dart';

class VideoView extends StatefulWidget
{
  VideoContent currentVideo;
  VideoView({Key key, @required this.currentVideo}) : super(key: key);
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {

  VideoPlayerController _controller;
  bool _isLoaded = false;
  bool _isPlaying = false;
  VoidCallback playingListener;

  // Initialize the playing listener
  _VideoViewState(){
    playingListener = () {
      final bool isPlaying = _controller.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    };
  }

  void playAfterInit(_){
    _isLoaded = true;
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    setState(() {});
    _controller.play();
  }

  void handleError(e)
  {
    print(e.toString());
  }

  @override
  void initState() {
    super.initState();

    _isLoaded = false;

    // Create a video player with listeners to re-render on init and on play
    _controller = VideoPlayerController.network(
      widget.currentVideo.videoUrl
    )
      ..addListener(playingListener)
      ..setVolume(1.0);

    // Initialize the player with content, handling errors
    try {
      _controller.initialize().then(playAfterInit);
    }
    catch(e)
    {
      handleError(e);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller
      ..removeListener(playingListener)
      ..setVolume(0.0);
  }

  @override
  Widget build(BuildContext context) {
    var childs = <Widget>[];

    childs.add(VideoPlayer(_controller));
    if(!_isLoaded) childs.add(LoadingSpinner());
    childs.add(VideoControlsBottomBar(_controller));

    return new Stack(
      children: childs,
    );
  }
}

/*
class _VideoViewState extends State<VideoView> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      // Example content sourced from https://github.com/SamsungInternet/examples
      'https://github.com/SamsungInternet/examples/blob/master/360-video/paris-by-diego.mp4?raw=true',
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _controller.value.isPlaying
              ? _controller.pause
              : _controller.play,
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
*/


class VideoControlsBottomBar extends StatelessWidget
{

  VideoPlayerController controller;

  VideoControlsBottomBar(this.controller);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var widgets = <Widget>[];

    widgets.add(
      Align(
        alignment: Alignment.topCenter,
        child:
          new SizedBox(
            width: width,
            height: 15.0,
            child: new VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              padding: EdgeInsets.all(0.0),
            ),
          ),
        ),
      );


    widgets.add(
      Container(
        margin: EdgeInsets.all(15.0),
        child: Text(
            "1:23",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ))
    );

    return new Align(
      alignment: Alignment.bottomCenter,
      child:
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          margin: EdgeInsets.all(20.0),
          constraints: BoxConstraints(
              minWidth: width - 40.0,
              maxWidth: width - 40.0,
              minHeight: 50.0,
              maxHeight: 50.0,
          ),
          decoration: new ShapeDecoration(
              shadows: [BoxShadow(spreadRadius: 0.2, blurRadius: 5.0)],
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              )
          ),
          child: Stack(
              alignment: Alignment.bottomLeft,
              children: widgets
          )
        ),
      );




      /* new Container(
        constraints: BoxConstraints(minWidth: 100.0, maxWidth: 800-40.0),
        decoration: new ShapeDecoration(
            shadows: [BoxShadow(spreadRadius: 1.0)],
            color: Colors.white,
            shape: Border.all(),
        ),
        child: new ButtonBar(
          children: <Widget>[
            new SizedBox(
              width: 40.0,
              child: new RaisedButton(
                child: new Text("<"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            new RaisedButton(
              child: new Text(convertMsToTimecode(1234)),
              onPressed: (){},
            ),
            new SizedBox(
              width: 100.0,
              child: new VideoProgressIndicator(
                controller,
                allowScrubbing: true,
              ),
            ),
            new RaisedButton(
              child: new Text('Info'),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );*/
  }
}

class LoadingSpinner extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double spinnerWidth;
    double spinnerHeight = spinnerWidth = width * 0.2;

    return new Positioned(
      left: (width - spinnerWidth) * 0.5,
      top: (height - spinnerHeight) * 0.5,
      width: spinnerWidth,
      height: spinnerHeight,
      child: new CircularProgressIndicator(),
    );
  }
}

String convertMsToTimecode(int ms)
{
  String result;
  
  Duration dur = Duration(milliseconds: ms);
  result = dur.inMinutes.toString();
  result += ":" + (dur.inSeconds.remainder(60)).toString().padLeft(2, '0');

  return result;
}
