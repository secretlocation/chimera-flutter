import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_content.dart';
import 'ms_to_timecode.dart';

class VideoControls extends StatefulWidget
{
  VideoPlayerController controller;
  VideoContent content;
  bool isLoaded = false;
  bool isInteractable = false;

  VideoControls({Key key,
    @required this.controller,
    @required this.content,
    @required this.isLoaded,
    @required this.isInteractable}) : super(key: key);
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

    if(widget.isInteractable) {
      childs.add(
          Positioned(
            left: (width * 0.3),
            top: (height * 0.5 - (width * 0.2)),
            width: (width * 0.4),
            height: (width * 0.4),
            child: GestureDetector(
              onTap: () {
                if (_isPlaying) {
                  widget.controller.pause();
                }
                else {
                  widget.controller.play();
                }
              },
              child: PlayPauseButton(backgroundImage: widget.content.playButton,
                  isPause: _isPlaying),
            ),
          )
      );
    }
    childs.add(VideoControlsBottomBar(widget.controller, widget.content));

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