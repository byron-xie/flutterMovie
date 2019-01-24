import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holoclub/My.dart';

import 'GlobelFiled.dart';
import 'page_games.dart';

void main() => runApp(MyApp());
bool isShowFloatingActionButton = true;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          highlightColor: const Color(0xFF63CA6C),
          splashColor: Colors.brown,
          primaryColor: const Color(0xFF63CA6C)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static const platform =
      const MethodChannel('samples.flutter.io/getMovieList');
  TabController _controller;
  int tabIndex = 0;
  String _batteryLevel = 'Unknown battery level.';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 5);
    _controller.addListener(_handleTabSelection);
    _getBatteryLevel();
  }

  Future<Null> _getBatteryLevel() async {
    try {
      final String result = await platform.invokeMethod('getMovieList');
      _batteryLevel = 'Battery level at ' + result;
    } on PlatformException catch (e) {
      _batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller.removeListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (tabIndex == _controller.index) {
      return;
    } else {
      setState(() {
        tabIndex = _controller.index;
      });
    }
    print("controller.index:" + "${_controller.index}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        centerTitle: false,
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              menuItemName(tabIndex),
              style: Theme.of(context).textTheme.title,
            ),
            Padding(padding: EdgeInsets.only(right: 8.0)),
            Icon(Icons.person, size: 28.0, color: Colors.black),
          ],
        ),
        actions: <Widget>[
          Center(
            child: IconButton(
                onPressed: () => {},
                icon: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.shopping_cart,
                          size: 28.0, color: Colors.black),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.green,
                        child: Text("13",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10.0)),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      body: _buildPage(),
      bottomNavigationBar: buildBottomWidget(),
      floatingActionButtonLocation: isShowFloatingActionButton
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.movie, size: 40),
      ),
    );
  }

  Row tabs() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.home,
          size: 40,
        ),
        Icon(Icons.movie, size: 40),
        Icon(Icons.movie, size: 40),
//                Icon(Icons.add_a_photo, size: 40),
        Icon(Icons.person, size: 40),
      ],
    );
  }

  Widget _buildPage() {
    switch (tabIndex) {
      case PageCategory.home:
        return GamesPage();
      case PageCategory.movie:
        return Text("dsadas");

      case PageCategory.person:
        return My();
    }
    return null;
  }

  Widget buildBottomWidget() {
    return isShowFloatingActionButton
        ? BottomAppBar(
            color: Colors.lightBlue,
            shape: CircularNotchedRectangle(),
            child: tabs(),
          )
        : Material(
            elevation: 8,
            child: new Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                          style: BorderStyle.solid),
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 3),
                          color: Colors.white,
                          blurRadius: 0.3,
                          spreadRadius: 3),
                    ]),
                child: TabBar(
                    controller: _controller,
                    indicatorColor: Colors.orangeAccent,
                    labelColor: Colors.orangeAccent,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Icon(
                        Icons.home,
                        size: 40,
                      ),
                      Icon(Icons.movie, size: 40),
//                Icon(Icons.add_a_photo, size: 40),
                      Icon(Icons.person, size: 40),
                    ])),
          );
  }
}

String menuItemName(int tabIndex) {
  switch (tabIndex) {
    case PageCategory.home:
      return PageCategory.home_title;
    case PageCategory.movie:
      return PageCategory.movie_title;
    case PageCategory.person:
      return PageCategory.person_title;
  }
  print("_batteryLevel is  aaaaaaaaaa  tabIndex" + "$tabIndex");
  return "";
}
