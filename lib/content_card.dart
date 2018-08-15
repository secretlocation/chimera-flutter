import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';
import 'package:chimera_flutter/info_bar.dart';
import 'video_view.dart';

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

    return Container(
      child: Stack(
        children: <Widget>[

          Positioned(
              child:
              Image(
                    fit: BoxFit.cover,
                    image: widget.data.thumbnail[0]
                ),
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
            left: (width * 0.5 - 25),
            top: (height * 0.5 - 25),
            child:
            IconButton(
                iconSize: 50.0,
                icon: const Icon(Icons.play_circle_outline),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoView(currentVideo:widget.data)),
                  );
                }
            ),
          ),

        ],
      ),
      alignment: Alignment.bottomLeft,
      height: height,
      width: width,
    );
  }
}