import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';
import 'package:chimera_flutter/info_bar.dart';
import 'package:chimera_flutter/layered_image.dart';
import 'video_view.dart';

class ContentCard extends StatefulWidget {
  const ContentCard(this.data, this.scrollPosition, this.sensorFusion);
  final VideoContent data;
  final double scrollPosition;
  final List<double> sensorFusion;

  _ContentCard createState() => new _ContentCard();
}

class _ContentCard extends State<ContentCard>{

  bool shouldBeShown = false;

  void showDescription(){
    shouldBeShown = !shouldBeShown;
    setState(() { });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: ClipRect(
        child: Stack(
        children: <Widget>[

          Positioned(
            child: LayeredImage(widget.scrollPosition, widget.sensorFusion, widget.data.thumbnail),
            height: height,
            width: width,
          ),

          Positioned(
            bottom: 0.0,
            right: 0.0,
            child:
              InfoBar(widget.data.runtime.toString(),widget.data.title, widget.data.description ),
          ),

          Positioned(
            left: (width * 0.35),
            top: (height * 0.5 - (width * 0.15)),
            width: (width * 0.3),
            height: (width * 0.3),
            child:
            FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoView(currentVideo:widget.data)),
                  );
                },
              child: new ConstrainedBox(
                constraints: new BoxConstraints.expand(),
                child: new Image(image: widget.data.playButton, fit: BoxFit.cover, gaplessPlayback: true),
              ),
            ),
          ),

        ],
      ),
      ),
      alignment: Alignment.bottomLeft,
      height: height,
      width: width,
    );
  }
}