import 'package:flutter/material.dart';
import 'package:chimera_flutter/description_widget.dart';

class InfoBar extends StatefulWidget {
  const InfoBar(this.time, this.title, this.description);
  final String time;
  final String title;
  final String description;

  _InfoBar createState() => new _InfoBar();
}

class _InfoBar extends State<InfoBar> {

  Icon buttonIcon =  Icon(Icons.arrow_drop_up);
  bool barIsOpen = false;

  void toggleInfoVisiblity(){
    if(barIsOpen){
      buttonIcon = Icon(Icons.arrow_drop_down);
    }
    else{
      buttonIcon = Icon(Icons.arrow_drop_up);
    }
    barIsOpen = ! barIsOpen;
    setState(() { });
  }

  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return
      new Stack(
        children: <Widget>[
          new Positioned(
            child: new Image(
                width: width * 0.8,
                height: width * 0.075,
                fit: BoxFit.cover,
                image: new AssetImage('graphics/background-popup.png')
            ),
          ),
          new Positioned(
            left: 25.0,
            top:5.0,
            child:
            new Text(widget.time),
          ),

          new Positioned(
          top: -20.0,
          left: MediaQuery.of(context).size.width * 0.6,
            child:
            new IconButton(
                iconSize: 50.0,
                icon: buttonIcon,
                onPressed: () {toggleInfoVisiblity();}
            ),
          ),

          new Positioned(
            bottom: 25.0,
            child:
            new Opacity(
              opacity: 1.0,
              child:
              new DescriptionWidget(widget.title, widget.description),
            ),
          ),
        ],
      );

  }
}
