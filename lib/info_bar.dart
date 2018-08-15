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
  bool isExpanded = false;

  void toggleInfoVisiblity(){
    if(isExpanded){
      buttonIcon = Icon(Icons.arrow_drop_down);
    }
    else{
      buttonIcon = Icon(Icons.arrow_drop_up);
    }
    isExpanded = ! isExpanded;
    setState(() { });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var widgets = <Widget>[];


    widgets.add(Container(
        constraints: BoxConstraints(minWidth: 500.0, minHeight: 500.0),
        child: DescriptionWidget(widget.title, widget.description)

    ));

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
          alignment: Alignment.bottomRight,
            iconSize: 50.0,
            icon: buttonIcon,
            onPressed: () {toggleInfoVisiblity();}
        ),
      ),
    );

    return
      AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.linear,
        constraints: BoxConstraints(
            minWidth: 100.0,
            maxWidth: (isExpanded)? width - 40.0 : 100.0,
            maxHeight: (isExpanded)? (height / 2) - 30.0 : 40.0
        ),
        decoration: new ShapeDecoration(
            shadows: [BoxShadow(spreadRadius: 1.0)],
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
