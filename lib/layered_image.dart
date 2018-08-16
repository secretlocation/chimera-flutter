import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

class LayeredImage extends StatefulWidget {
  const LayeredImage(this.scrollPosition, this.images);
  final double scrollPosition;
  final List<AssetImage> images;

  @override
  State<StatefulWidget> createState() => LayeredImageState();
}

class LayeredImageState extends State<LayeredImage> {
  final List<double> modifiers = [0.9,0.8,0.7,0.6,0.1];
  List<double> modifiersSensor = [10.0, 8.0, 5.0, 3.0, 1.0];

  List<double> _gyroscopeValues = [0.0, 0.0, 0.0];
  List<double> _sensorFusion = [0.0, 0.0, 0.0];

  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];


  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void updateSensorFusion() {
    if (_gyroscopeValues == null) return null;

    final double clampValue = 10.0;
    if (_gyroscopeValues[0] > clampValue) _gyroscopeValues[0] = clampValue;
    if (_gyroscopeValues[0] < -clampValue) _gyroscopeValues[0] = -clampValue;
    if (_gyroscopeValues[1] > clampValue) _gyroscopeValues[1] = clampValue;
    if (_gyroscopeValues[1] < -clampValue) _gyroscopeValues[1] = -clampValue;

    // Adjust for ground truth
    _sensorFusion = [
      _sensorFusion[0] + 0.5 * (_gyroscopeValues[0] - _sensorFusion[0]),
      _sensorFusion[1] + 0.5 * (_gyroscopeValues[1] - _sensorFusion[1]), 0.0];
  }

  @override
  void initState() {
    super.initState();

    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[
          _gyroscopeValues[0] + event.y, _gyroscopeValues[1] + event.x, 0.0];
        updateSensorFusion();
      });
    }));

  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double imageWidth = screenWidth;
    double imageHeight = screenHeight;
    double scaleFactor = 1.2;

    double modifiersMultiplier = screenWidth/1080;
    modifiersSensor = [modifiersMultiplier*10.0, modifiersMultiplier*8.0, modifiersMultiplier*5.0, modifiersMultiplier*3.0, modifiersMultiplier*1.0];

    var imageLayers = <Widget>[];
    
    for(int i = 0; i < widget.images.length; i++) {
      imageLayers.add(Container(
          transform: Matrix4
              .translationValues(modifiersSensor[i] * _sensorFusion[0] * modifiers[i] + imageWidth*(1-scaleFactor)/2 , (widget.scrollPosition + (modifiersSensor[i] * _sensorFusion[1])) * modifiers[i] + imageHeight*(1-scaleFactor)/2, 0.0)
              ..scale(scaleFactor),
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