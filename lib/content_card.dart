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
  double opactiyForBox = 0.0;

  void showDescription(){
    if(shouldBeShown){
      opactiyForBox = 1.0;
    }
    else{
      opactiyForBox = 0.0;
    }
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

          /*new Positioned(
            left: (width * 0.2),
            top: (width * 0.55),
            child:
            new Opacity(
              opacity: opactiyForBox,
                child:
                  new DescriptionWidget(widget.data),
              ),
          ),*/

          new Positioned(
            left: (width * 0.15),
            top: (height * 0.8),
            child:
              new InfoBar(widget.data.runtime.toString(),widget.data.title, widget.data.description ),
          ),

        ],
      ),
      alignment: Alignment.bottomRight,
      height: height,
      width: width,
    );
  }
}