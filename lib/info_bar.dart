import 'package:flutter/material.dart';
import 'package:chimera/description_widget.dart';
import 'ms_to_timecode.dart';

class InfoBar extends StatefulWidget {
  const InfoBar(this.runtime, this.title, this.description);
  final int runtime;
  final String title;
  final String description;

  _InfoBar createState() => new _InfoBar();
}

class _InfoBar extends State<InfoBar> {

  Icon buttonIconUp =  Icon(Icons.keyboard_arrow_up);
  Icon buttonIconDown =  Icon(Icons.keyboard_arrow_down);
  bool isExpanded = false;

  void toggleInfoVisibility(){
    isExpanded = ! isExpanded;
    setState(() { });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var widgets = <Widget>[];


    widgets.add(OverflowBox(
      alignment: Alignment.topLeft,
      maxHeight: double.infinity,
      maxWidth: width - 40,
      child:DescriptionWidget(widget.title, widget.description))
    );

    widgets.add(
      Container(
        color: Colors.white,
        margin: EdgeInsets.all(15.0),
        child: Text(
            convertMsToTimecode(widget.runtime),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF686868)
            )
        ))
    );

    widgets.add(
      new Positioned(
        bottom: 0.0,
        right: 0.0,
        child:
        new IconButton(
          color: Color(0xFF686868),
          alignment: Alignment.bottomRight,
            iconSize: 30.0,
            icon: (isExpanded)? buttonIconDown : buttonIconUp,
            onPressed: () {toggleInfoVisibility();}
        ),
      ),
    );

    return
      AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
        margin: EdgeInsets.all(20.0),
        constraints: BoxConstraints(
            minWidth: 100.0,
            maxWidth: (isExpanded)? width - 40.0 : 110.0,
            maxHeight: (isExpanded)? (height / 2) - 30.0 : 50.0
        ),
        decoration: new ShapeDecoration(
            shadows: [BoxShadow(spreadRadius: 0.2, blurRadius: 5.0)],
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            )
        ),
        child: Stack(
            alignment: Alignment.bottomLeft,
          children: widgets
        )
      );

  }
}
