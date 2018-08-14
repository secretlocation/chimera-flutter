import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatefulWidget {
  const ContentCard(this.data);
  final VideoContent data;

  _ContentCard createState() => new _ContentCard();
}

class _ContentCard extends State<ContentCard>{

  bool shouldShowDescription = false;
  String descriptionText = "";

  void showDescription(){
    if(shouldShowDescription){
      descriptionText = widget.data.description;
    }
    else{
      descriptionText = "";
    }
    shouldShowDescription = !shouldShowDescription;
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
            left: (MediaQuery.of(context).size.width * 0.5 - 25),
            top: (MediaQuery.of(context).size.width * 0.75),
            child:
              new Text(descriptionText),
          ),

          //make information popupclass call function on that to show/hide

          new Positioned(
            left: (MediaQuery.of(context).size.width * 0.825),
            top: (MediaQuery.of(context).size.width * 0.6),

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

                new IconButton(
                    iconSize: 50.0,
                    icon: const Icon(Icons.settings),
                    onPressed: () {}
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