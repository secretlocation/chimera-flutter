import 'package:flutter/material.dart';

class LayeredImage extends StatefulWidget {
  const LayeredImage(this.scrollPosition, this.images);
  final double scrollPosition;
  final List<AssetImage> images;

  @override
  State<StatefulWidget> createState() => LayeredImageState();
}

class LayeredImageState extends State<LayeredImage> {
  final List<double> modifiers = [0.6,0.5,0.4,0.3,0.1];

  @override
  Widget build(BuildContext context) {

    double imageWidth = MediaQuery.of(context).size.width;
    double imageHeight = MediaQuery.of(context).size.height;

    var imageLayers = <Widget>[];
    
    for(int i = 0; i < widget.images.length; i++) {
      imageLayers.add(Container(
          transform: Matrix4.translationValues(0.0, widget.scrollPosition * modifiers[i], 0.0),
          width: imageWidth,
          height: imageHeight,
          child: Image(image: widget.images[i]))
      );
    }

    return Stack(
      children: imageLayers
    );

  }



}