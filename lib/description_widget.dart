import 'package:flutter/material.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget(this.title, this.description);
  final String title;
  final String description;

  _DescriptionWidget createState() => new _DescriptionWidget();
}

class _DescriptionWidget extends State<DescriptionWidget> {
  Widget build(BuildContext context) {
    return
      new Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(bottom: 40.0),
          alignment: Alignment.topLeft,
          child: Column(
            children: [

              Text(
                widget.title,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),

              Text(
                widget.description,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black
                ),
              )

            ],
          )
      );
  }
}
