import 'package:chimera_flutter/video_content.dart';
import 'package:flutter/material.dart';
import 'video_view.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard(this.data);

  final VideoContent data;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(data.title, style: textStyle),
            Text(data.description, style: textStyle),
            RaisedButton(
              child: Text('Play me'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}