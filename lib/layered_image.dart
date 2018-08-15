import 'package:flutter/material.dart';

class LayeredImage extends StatefulWidget {
  const LayeredImage(this.scrollPosition, this.sensorFusion, this.images);
  final double scrollPosition;
  final List<double> sensorFusion;
  final List<AssetImage> images;

  @override
  State<StatefulWidget> createState() => LayeredImageState();
}

class LayeredImageState extends State<LayeredImage> {
  final List<double> modifiers = [0.7,0.6,0.5,0.4,0.2];
  final sensorModifier = 100.0;

  @override
  Widget build(BuildContext context) {

    double imageWidth = MediaQuery.of(context).size.width;
    double imageHeight = MediaQuery.of(context).size.height;

    var imageLayers = <Widget>[];
    
    for(int i = 0; i < widget.images.length; i++) {
      imageLayers.add(Container(
          transform: Matrix4.translationValues(sensorModifier * widget.sensorFusion[0] * modifiers[i], (widget.scrollPosition + (sensorModifier * widget.sensorFusion[1])) * modifiers[i], 0.0),
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