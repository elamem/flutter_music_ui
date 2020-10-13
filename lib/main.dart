import 'package:flutter/material.dart';

import 'dart:ui';

import './progressBar/curvedProgressBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChanged = false;
  var bannerWidth;
  var bannerHeight;
  var bannerRadius = 100.0;
  var _visible = true;
  var title = "Let You Down";

  List<Map<String, Object>> songAlbum = [
    {'name': "Intro III", 'duration': '4:28'},
    {'name': "Outcast", 'duration': '5:25'},
    {'name': "10 Feet Down", 'duration': '3:37'},
    {'name': "Green Lights", 'duration': '3:01'},
    {'name': "Dreams", 'duration': '3:41'},
    {'name': "Let You Down", 'duration': '3:32'},
    {'name': "Destiny", 'duration': '3:59'},
    {'name': "My Life", 'duration': '3:35'},
    {'name': "You're Special", 'duration': '5:12'},
    {'name': "If You Want Love", 'duration': '3:19'},
    {'name': "Remember This", 'duration': '4:00'},
    {'name': "Know", 'duration': '3:58'},
    {'name': "Lie", 'duration': '3:29'},
    {'name': "3 A.M.", 'duration': '3:38'},
    {'name': "One Hundred", 'duration': '3:12'},
    {'name': "Outro", 'duration': '3:32'},
  ];
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    if (isChanged) {
      bannerWidth = screenWidth * 0.6;
      bannerHeight = screenHeight * 0.5;
      bannerRadius = 200.0;
      _visible = false;
      title = "Perception";
    } else {
      bannerWidth = screenWidth * 0.6;
      bannerHeight = screenHeight * 0.7;
      bannerRadius = 200.0;
      _visible = true;
      title = "Let You Down";
    }

    return Scaffold(
      backgroundColor: Color(0xFFe6e7e8),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.35,
                ),
                Center(
                  child: CurvedProgressBar(_visible),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {},
                onPanUpdate: (details) {
                  if (details.delta.dy > 0) {
                    // swiping in down direction
                    setState(() {
                      isChanged = false;
                    });
                  } else if (details.delta.dy < 0) {
                    setState(() {
                      isChanged = true;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  width: bannerWidth,
                  height: bannerHeight,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("images/cover.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(bannerRadius),
                      bottomRight: Radius.circular(bannerRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[700],
                          blurRadius: 50,
                          spreadRadius: 0.1,
                          offset: Offset(-1, 15))
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "NF",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: (!_visible) ? 1.0 : 0.0,
              duration: Duration(milliseconds: 250),
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.50),
                height: screenHeight * 0.35,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ...songAlbum.map((songDetail) {
                      return Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  songDetail['name'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Expanded(
                                  child: Text(
                                    songDetail['duration'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
