import 'package:flutter/material.dart';
import 'package:flutter_parallax/flutter_parallax.dart';

class LayeredImage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LayeredImageState();
}

class LayeredImageState extends State<LayeredImage> {

  @override
  Widget build(BuildContext context) {

    return new Stack(
      children: <Widget>[
        new Container( width: 750.0, height: 500.0, child: new Parallax.inside(child: new Image.asset('graphics/example_tile/example_layer5.png'), mainAxisExtent: 2500.0)),
        new Container( width: 750.0, height: 500.0, child: new Parallax.inside(child: new Image.asset('graphics/example_tile/example_layer4.png'), mainAxisExtent: 2000.0)),
        new Container( width: 750.0, height: 500.0, child: new Parallax.inside(child: new Image.asset('graphics/example_tile/example_layer3.png'), mainAxisExtent: 1500.0)),
        new Container( width: 750.0, height: 500.0, child: new Parallax.inside(child: new Image.asset('graphics/example_tile/example_layer2.png'), mainAxisExtent: 1000.0)),
        new Container( width: 750.0, height: 500.0, child: new Parallax.inside(child: new Image.asset('graphics/example_tile/example_layer1.png'), mainAxisExtent: 500.0)),
      ],
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