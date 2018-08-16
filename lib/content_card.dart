import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';
import 'package:chimera_flutter/info_bar.dart';
import 'package:chimera_flutter/layered_image.dart';
import 'video_view.dart';
import 'custom_material_page_route.dart';

class ContentCard extends StatefulWidget {
  const ContentCard(this.data, this.scrollPosition);
  final VideoContent data;
  final double scrollPosition;

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
            child: LayeredImage(widget.scrollPosition, widget.data.thumbnail),
            height: height,
            width: width,
          ),

          Positioned(
            bottom: 0.0,
            right: 0.0,
            child:
              Opacity(
                opacity: ((150.0 - widget.scrollPosition.abs()) / 150.0).clamp(0.0, 1.0) ,
                child:InfoBar(widget.data.runtime,widget.data.title, widget.data.description ),
              ),
          ),

          Positioned(
            left: (width * 0.3),
            top: (height * 0.5 - (width * 0.2)),
            width: (width * 0.4),
            height: (width * 0.4),
            child:
            FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    FadeRoute(builder: (context) => VideoView(currentVideo:widget.data)),
                  );
                },
              child: new ConstrainedBox(
                constraints: new BoxConstraints.expand(),
                child: Opacity(
                  opacity: ((200.0 - widget.scrollPosition.abs()) / 150.0).clamp(0.0, 1.0) ,
                  child: Stack(
                    children: <Widget>[
                      Image(image: widget.data.playButton, fit: BoxFit.contain, gaplessPlayback: true),
                      Image(image: AssetImage("graphics/play.png"), fit: BoxFit.contain, gaplessPlayback: true),
                    ],
                  ),
                ),
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