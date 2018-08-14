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
          color: Colors.black,
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [

              Text(
                widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              Text(
                widget.description,
                style: TextStyle(
                    color: Colors.white
                ),
              )

            ],
          )
      );
  }
}