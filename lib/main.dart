import 'package:flutter/material.dart';
import 'package:chimera_flutter/data.dart';
import 'package:chimera_flutter/content_card.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Vusr Chimera',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: new MyHomePage(title: 'Vusr Chimera'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController =
  PageController(viewportFraction: 1.0);

  ValueNotifier<double> pageCurrent = ValueNotifier<double>(0.0);
  ValueNotifier<double> pageScrollPosition = ValueNotifier<double>(0.0);

  List<double> _gyroscopeValues = [0.0, 0.0, 0.0];
  List<double> _sensorGroundTruth;
  List<double> _sensorFusion = [0.0, 0.0, 0.0];

  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return new Scaffold(
      backgroundColor: Colors.black,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.depth == 0 && notification is ScrollUpdateNotification) {
            _sensorGroundTruth = null;
            pageCurrent.value = _pageController.page;
            pageScrollPosition.value = notification.metrics.pixels;
            setState(() {});
          }
          return false;
        },
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          children: _buildPages(),
        ),
      )
    );
  }

  Iterable<Widget> _buildPages() {

    // Create tiles
    double height = MediaQuery.of(context).size.height;
    final List<Widget> tiles = [];
    for (int i = 0; i < data.length; i++) {
      var element = data[i];
      tiles.add(new ContentCard(element, pageScrollPosition.value - (i * height), _sensorFusion));
    }

    final List<Widget> pages = <Widget>[];

    for (int index = 0; index < tiles.length; index++) {
      double position = (pageCurrent.value - index);
      var rotateFactor = ((position * 0.75));
      var scaleAmount = 0.5;
      var scaleFactor = (1.0 - position.abs()) * scaleAmount;

      pages.add(Container(
          child: OverflowBox(
              maxWidth: double.infinity,
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(rotateFactor)
                  ..scale(1.0 + scaleAmount - scaleFactor.abs(), 1.0 + scaleAmount - scaleFactor.abs())
                ,
                child: tiles[index],
              )
          )
      ));
    }
    return pages;
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();

    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[_gyroscopeValues[0] + event.y, _gyroscopeValues[1] + event.x, 0.0];
        updateSensorFusion();
      });
    }));

  }

  void updateSensorFusion() {
    if (_gyroscopeValues == null) return null;

    final double clampValue = 10.0;
    if (_gyroscopeValues[0] > clampValue) _gyroscopeValues[0] = clampValue;
    if (_gyroscopeValues[0] < -clampValue) _gyroscopeValues[0] = -clampValue;
    if (_gyroscopeValues[1] > clampValue) _gyroscopeValues[1] = clampValue;
    if (_gyroscopeValues[1] < -clampValue) _gyroscopeValues[1] = -clampValue;

//    final double returnSpeed = 0.1;
//    if (_gyroscopeValues[0] > 0) _gyroscopeValues[0] -= returnSpeed;
//    if (_gyroscopeValues[0] < 0) _gyroscopeValues[0] += returnSpeed;
//    if (_gyroscopeValues[1] > 0) _gyroscopeValues[1] -= returnSpeed;
//    if (_gyroscopeValues[1] < 0) _gyroscopeValues[1] += returnSpeed;

    // starting offset
    if (_sensorGroundTruth == null) {
      _sensorGroundTruth = _gyroscopeValues;
    }

    // Adjust for ground truth
    _sensorFusion = [
      _sensorFusion[0] + 0.7 * (_gyroscopeValues[0] - _sensorGroundTruth[0] - _sensorFusion[0]),
      _sensorFusion[1] + 0.7 * (_gyroscopeValues[1] - _sensorGroundTruth[1] - _sensorFusion[1]), 0.0];
  }
}
