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
  bool _controlsVisible = true;

  void playAfterInit(_){
    _isLoaded = true;
    _controlsVisible = false;
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
      ..setVolume(0.0);
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
    childs.add(
        AnimatedOpacity(
          opacity: _controlsVisible ? 1.0: 0.0,
          duration: Duration(milliseconds: 200),
          child: VideoControls(controller: _controller, content: widget.currentVideo, isLoaded: _isLoaded,),
        ));

    return Stack(
      children: childs,
    );
  }
}

class VideoControls extends StatefulWidget
{
  VideoPlayerController controller;
  VideoContent content;
  bool isLoaded = false;

  VideoControls({Key key, @required this.controller, this.content, this.isLoaded}) : super(key: key);
  @override
  _VideoControlsState createState() => _VideoControlsState();
}
class _VideoControlsState extends State<VideoControls>
{
  bool _isPlaying = false;
  VoidCallback playingListener;

  // Initialize the playing listener
  _VideoControlsState(){
    playingListener = () {
      final bool isPlaying = widget.controller.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    };
  }

  @override
  void initState() {
    super.initState();
    widget.controller
      ..addListener(playingListener);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var childs = <Widget>[];

    if(!widget.isLoaded) childs.add(LoadingSpinner(widget.content.customColor));
    else {
      childs.add(
        Positioned(
          left: (width * 0.3),
          top: (height * 0.5 - (width * 0.2)),
          width: (width * 0.4),
          height: (width * 0.4),
          child: GestureDetector(
            onTap: () {
              if(_isPlaying){
                widget.controller.pause();
              }
              else {
                widget.controller.play();
              }
            },
            child: PlayPauseButton(backgroundImage: widget.content.playButton, isPause: _isPlaying),
          ),
        )
      );
      childs.add(VideoControlsBottomBar(widget.controller, widget.content));
    }

    return new Stack(
      children: childs,
    );
  }

  @override
  void deactivate() {
    widget.controller
      ..removeListener(playingListener);
    super.deactivate();
  }
}

class VideoControlsBottomBar extends StatelessWidget
{

  VideoPlayerController controller;
  VideoContent content;

  VideoControlsBottomBar(this.controller, this.content);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var widgets = <Widget>[];

    widgets.add(
      Align(
        alignment: Alignment.bottomCenter,
        child:
          new SizedBox(
            width: width,
            height: 15.0,
            child: new VideoProgressIndicator(
              controller,
              colors: VideoProgressColors(
                playedColor: content.customColor,
                backgroundColor: Color(0xFFF1EFF1),
              ),
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
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: widgets
            ),
          ),
        ),
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

class PlayPauseButton extends StatelessWidget
{
  AssetImage backgroundImage;
  bool isPause;
  PlayPauseButton({@required this.backgroundImage, @required this.isPause});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(image: backgroundImage, fit: BoxFit.contain, gaplessPlayback: true),
        Image(image: AssetImage( isPause ? "graphics/pause.png" : "graphics/play.png"), fit: BoxFit.contain, gaplessPlayback: true),
      ],
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
