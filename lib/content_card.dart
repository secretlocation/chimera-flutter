import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';
import 'package:chimera_flutter/description_widget.dart';
import 'package:chimera_flutter/info_bar.dart';

class ContentCard extends StatefulWidget {
  const ContentCard(this.data);
  final VideoContent data;

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
                  onPressed: () {}
              ),
          ),
          new Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            child:
              new InfoBar(widget.data.runtime.toString(),widget.data.title, widget.data.description ),
          ),

        ],
      ),
      alignment: Alignment.bottomLeft,
      height: height,
      width: width,
    );
  }
}