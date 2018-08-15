import 'package:flutter/material.dart';

class LayeredImage extends StatefulWidget {
  const LayeredImage(this.scrollPosition, this.images);
  final double scrollPosition;
  final List<AssetImage> images;

  @override
  State<StatefulWidget> createState() => LayeredImageState();
}

class LayeredImageState extends State<LayeredImage> {

  @override
  Widget build(BuildContext context) {

    double imageWidth = MediaQuery.of(context).size.width;
    double imageHeight = MediaQuery.of(context).size.height;
    List<double> modifiers = [0.20,0.5,0.5,0.25,0.1];
    var imageLayers = <Widget>[];
    
    for(int i = 0; i < widget.images.length; i++)
    {
      imageLayers.add(new Container( transform: Matrix4.translationValues(0.0, widget.scrollPosition * modifiers[i], 0.0), width: imageWidth, height: imageHeight, child: Image(image: widget.images[i])),);
    }

    return new Stack(
      children: imageLayers
    );






//    return Stack(
//      alignment: const Alignment(0.6, 0.6),
//      children: <Widget>[
//        new ParallaxImage(
//          image: new AssetImage('graphics/example_tile/example_layer5.png'),
//          // Extent of this widget in scroll direction.
//          // In this case it is vertical scroll so extent defines
//          // the height of this widget.
//          // The image is scaled with BoxFit.fitWidth which makes it
//          // occupy full width of this widget.
//          // After image is scaled it should normally have height greater
//          // than this value to allow for parallax effect to be
//          // visible.
//          extent: 60.0,
//          // Optionally specify child widget.
//          child: new Text('Panda'),
//          // Optinally specify scroll controller.
//        ),
//        new ParallaxImage(
//          image: new AssetImage('graphics/example_tile/example_layer4.png'),
//          // Extent of this widget in scroll direction.
//          // In this case it is vertical scroll so extent defines
//          // the height of this widget.
//          // The image is scaled with BoxFit.fitWidth which makes it
//          // occupy full width of this widget.
//          // After image is scaled it should normally have height greater
//          // than this value to allow for parallax effect to be
//          // visible.
//          extent: 80.0,
//          // Optionally specify child widget.
//          child: new Text('Panda'),
//          // Optinally specify scroll controller.
//        ),
//        new ParallaxImage(
//          image: new AssetImage('graphics/example_tile/example_layer3.png'),
//          // Extent of this widget in scroll direction.
//          // In this case it is vertical scroll so extent defines
//          // the height of this widget.
//          // The image is scaled with BoxFit.fitWidth which makes it
//          // occupy full width of this widget.
//          // After image is scaled it should normally have height greater
//          // than this value to allow for parallax effect to be
//          // visible.
//          extent: 100.0,
//          // Optionally specify child widget.
//          child: new Text('Panda'),
//          // Optinally specify scroll controller.
//        ),
//        new ParallaxImage(
//          image: new AssetImage('graphics/example_tile/example_layer2.png'),
//          // Extent of this widget in scroll direction.
//          // In this case it is vertical scroll so extent defines
//          // the height of this widget.
//          // The image is scaled with BoxFit.fitWidth which makes it
//          // occupy full width of this widget.
//          // After image is scaled it should normally have height greater
//          // than this value to allow for parallax effect to be
//          // visible.
//          extent: 120.0,
//          // Optionally specify child widget.
//          child: new Text('Panda'),
//          // Optinally specify scroll controller.
//        ),
//        new ParallaxImage(
//          image: new AssetImage('graphics/example_tile/example_layer1.png'),
//          // Extent of this widget in scroll direction.
//          // In this case it is vertical scroll so extent defines
//          // the height of this widget.
//          // The image is scaled with BoxFit.fitWidth which makes it
//          // occupy full width of this widget.
//          // After image is scaled it should normally have height greater
//          // than this value to allow for parallax effect to be
//          // visible.
//          extent: 140.0,
//          // Optionally specify child widget.
//          child: new Text('Panda'),
//          // Optinally specify scroll controller.
//        ),//        new Positioned(
//      ],
//    );




  }



}