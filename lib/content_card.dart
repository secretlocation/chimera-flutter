import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';
import 'package:chimera_flutter/description_widget.dart';
import 'video_view.dart';

class ContentCard extends StatefulWidget {
  const ContentCard(this.data);
  final VideoContent data;

  _ContentCard createState() => new _ContentCard();
}

class _ContentCard extends State<ContentCard>{

  bool shouldBeShown = false;
  double opactiyForBox = 0.0;

  void showDescription(){
    shouldBeShown = !shouldBeShown;
    setState(() { });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var infoTextElement = shouldBeShown ?
      new Positioned(
        left: (width * 0.2),
        top: (width * 0.55),
        child:
        new Opacity(
          opacity: 1.0,
          child:
          new DescriptionWidget(widget.data),
        ),
      )
      : null;

    return new Container(
      child: new Stack(
        children: <Widget>[

          new Positioned(
              child:
                new Image(
                    fit: BoxFit.cover,
                    image: widget.data.thumbnail[0]
                ),
            height: height,
            width: width,
          ),

          new Positioned(
            left: (width * 0.5 - 25),
            top: (height * 0.5 - 25),
            child:
              new IconButton(
                  iconSize: 50.0,
                  icon: const Icon(Icons.play_circle_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoView()),
                    );
                  }
              ),
          ),

          infoTextElement,

          new Positioned(
            left: (width * 0.825),
            top: (height * 0.3),
            child: new Column(
              children: <Widget>[
                new Text(
                 widget.data.runtime.toString()
                ),
                new IconButton(
                    iconSize: 50.0,
                    icon: const Icon(Icons.info),
                    onPressed: () {showDescription();}
                ),
              ],
            ),
          ),

        ].where((child) => child != null).toList(),
      ),
      alignment: Alignment.bottomRight,
      height: height,
      width: width,
    );
  }
}