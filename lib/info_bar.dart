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

  Icon buttonIconUp =  Icon(Icons.arrow_drop_up);
  Icon buttonIconDown =  Icon(Icons.arrow_drop_down);
  bool isExpanded = false;

  void toggleInfoVisiblity(){
    isExpanded = ! isExpanded;
    setState(() { });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var widgets = <Widget>[];


    widgets.add(DescriptionWidget(widget.title, widget.description));

    widgets.add(
      Container(
        margin: EdgeInsets.all(15.0),
        child: Text(
            "1:23",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ))
    );

    widgets.add(
      new Positioned(
        bottom: -7.0,
        right: 0.0,
        child:
        new IconButton(
          alignment: Alignment.bottomRight,
            iconSize: 50.0,
            icon: (isExpanded)? buttonIconDown : buttonIconUp,
            onPressed: () {toggleInfoVisiblity();}
        ),
      ),
    );

    return
      AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.linear,
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