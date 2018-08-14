import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';
import 'package:chimera_flutter/description_widget.dart';

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
    return new Container(
      child: new Stack(
        children: <Widget>[

          new Positioned(
              child:
                new Image(
                    fit: BoxFit.cover,
                    image: new AssetImage('graphics/panda.png')
                ),
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
          ),

          new Positioned(
            left: (MediaQuery.of(context).size.width * 0.5 - 25),
            top: (MediaQuery.of(context).size.width * 0.5 - 25),
            child:
              new IconButton(
                  iconSize: 50.0,
                  icon: const Icon(Icons.play_circle_outline),
                  onPressed: () {}
              ),
          ),

          new Positioned(
            left: (MediaQuery.of(context).size.width * 0.2),
            top: (MediaQuery.of(context).size.width * 0.55),
            child:
            new Opacity(
              opacity: opactiyForBox,
                child:
                  new DescriptionWidget(widget.data),
              ),
          ),

          new Positioned(
            left: (MediaQuery.of(context).size.width * 0.825),
            top: (MediaQuery.of(context).size.width * 0.3),
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

        ],
      ),
      alignment: Alignment.bottomRight,
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
    );
  }
}