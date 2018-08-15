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
    var widgets = <Widget>[];

    if (barIsOpen) {
      widgets.add(new DescriptionWidget(
          widget.title, widget.description));
    }

    widgets.add(
      Container(
        margin: EdgeInsets.all(10.0),
        child: Text(
            "1:23",
            style: TextStyle(color: Colors.black)
        ))
    );

    widgets.add(
      new Positioned(
        bottom: -10.0,
        right: 0.0,
        child:
        new IconButton(
            iconSize: 50.0,
            icon: buttonIcon,
            onPressed: () {toggleInfoVisiblity();}
        ),
      ),
    );

    return
      Container(
        constraints: BoxConstraints(minWidth: 100.0, maxWidth: width-40.0),
        decoration: new ShapeDecoration(
            shadows: [BoxShadow(spreadRadius: 1.0)],
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            )
        ),
        child: Stack(
            alignment: Alignment.bottomLeft,
          children: widgets
        )
      );

  }
}
