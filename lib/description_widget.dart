import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget(this.data);
  final VideoContent data;

  _DescriptionWidget createState() => new _DescriptionWidget();
}

class _DescriptionWidget extends State<DescriptionWidget> {

  Widget build(BuildContext context) {
    return
        new Stack(
          children: <Widget>[
            new Positioned(
              child: new Image(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.cover,
                      image: new AssetImage('graphics/background-popup.png')
              ),
            ),
              new Positioned(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.65,
                top: 35.0,
                child:
                  new Text(widget.data.description),
              ),
          ],
      );

  }
}
