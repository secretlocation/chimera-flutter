import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_content.dart';
import 'video_controls.dart';

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
  bool _controlsVisible = false;

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
      ..setVolume(0.0)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    var childs = <Widget>[];
    childs.add(GestureDetector(
        onTap: () {
          setState(() {
            _controlsVisible = !_controlsVisible;
          });
        },
        child: VideoPlayer(_controller),
    ));
    if(!_isLoaded){
      childs.add(LoadingSpinner(widget.currentVideo.customColor));
    }
    childs.add(
        AnimatedOpacity(
          opacity: _controlsVisible ? 1.0: 0.0,
          duration: Duration(milliseconds: 200),
          child: VideoControls(controller: _controller,
            content: widget.currentVideo,
            isLoaded: _isLoaded,
            isInteractable: _controlsVisible,),
        ));

    return Stack(
      children: childs,
    );
  }
}

class LoadingSpinner extends StatelessWidget
{
  Color mainColor;
  LoadingSpinner(this.mainColor);

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
      child: new CircularProgressIndicator(
        backgroundColor: mainColor,
      ),
    );
  }
}