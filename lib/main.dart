import 'package:flutter/material.dart';
import 'package:chimera_flutter/data.dart';
import 'package:chimera_flutter/content_card.dart';

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

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      body:           NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.depth == 0 && notification is ScrollUpdateNotification) {
            pageCurrent.value = _pageController.page;
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
    final List<Widget> tiles = [];
    data.forEach((element) => tiles.add(new ContentCard(element)));

    final List<Widget> pages = <Widget>[];

    for (int index = 0; index < tiles.length; index++) {
      double position = (pageCurrent.value - index);
      var rotateFactor = ((position * 1.0));
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
}

