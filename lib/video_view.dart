import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget
{
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {

  VideoPlayerController _controller;
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

    // Create a video player with listeners to re-render on init and on play
    _controller = VideoPlayerController.network(
      // Example content sourced from https://github.com/SamsungInternet/examples
      'https://github.com/SamsungInternet/examples/blob/master/360-video/paris-by-diego.mp4?raw=true',
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

    return new Stack(
      children: <Widget>[
        new VideoPlayer(_controller),
        new VideoControlsBar(),
      ],
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


class VideoControlsBar extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ButtonBar(

      children: <Widget>[
        new FlatButton(
          child: new Text('Play'),
          onPressed: null,
        ),
        new SizedBox(
          width: 160.0,
          child: new LinearProgressIndicator(
            value: 0.5,
          ),
        ),
        new FlatButton(
          child: new Text('Info'),
          onPressed: null,
        ),
      ],
    );
  }
    /*return new Positioned(
        top: 0.0,
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: new ButtonBar());
  }*/
}