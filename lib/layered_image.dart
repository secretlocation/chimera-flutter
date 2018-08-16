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
  final List<double> modifiers = [0.9,0.8,0.7,0.6,0.1];
  List<double> modifiersSensor = [10.0, 8.0, 5.0, 3.0, 1.0];

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double imageWidth = screenWidth;
    double imageHeight = screenHeight;

    double modifiersMultiplier = screenWidth/1080;
    modifiersSensor = [modifiersMultiplier*10.0, modifiersMultiplier*8.0, modifiersMultiplier*5.0, modifiersMultiplier*3.0, modifiersMultiplier*1.0];

    var imageLayers = <Widget>[];
    
    for(int i = 0; i < widget.images.length; i++) {
      imageLayers.add(Container(
          transform: Matrix4.translationValues(modifiersSensor[i] * widget.sensorFusion[0] * modifiers[i], (widget.scrollPosition + (modifiersSensor[i] * widget.sensorFusion[1])) * modifiers[i], 0.0),
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