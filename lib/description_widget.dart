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
          padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
          margin: EdgeInsets.only(bottom: 40.0),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),

              Text(
                widget.description,
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
