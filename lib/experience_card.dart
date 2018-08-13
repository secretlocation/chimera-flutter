import 'package:flutter/material.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard();

  final String title = 'Title';
  final String description = 'Description';

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
            Text(title, style: textStyle),
            Text(description, style: textStyle),
          ],
        ),
      ),
    );
  }
}