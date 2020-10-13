import 'package:flutter/material.dart';

import './progress_painter.dart';

import 'dart:async';

import 'dart:ui';

class CurvedProgressBar extends StatefulWidget {
  var _visible;

  CurvedProgressBar(this._visible);
  @override
  _CurvedProgressBarState createState() => _CurvedProgressBarState();
}

class _CurvedProgressBarState extends State<CurvedProgressBar>
    with SingleTickerProviderStateMixin {
  double _percentage;
  double _nextPercentage;
  AnimationController _progressAnimationController;

  Timer _timer;

  bool isPlaying = false;

  double _totalSeconds = 100;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _percentage = 0.0;
    _nextPercentage = 0.0;
    _timer = null;
    _totalSeconds = 203;
    initAnimationController();
  }

  initAnimationController() {
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )..addListener(() {
        setState(() {
          _percentage = lerpDouble(
              _percentage, _nextPercentage, _progressAnimationController.value);
        });
      });
  }

  start() {
    Timer.periodic(Duration(seconds: 1), handleTicker);
  }

  handleTicker(Timer timer) {
    _timer = timer;
    if (_nextPercentage < _totalSeconds) {
      publishProgress();
    } else {
      timer.cancel();
    }
  }

  startProgress() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    setState(() {
      _percentage = 0.0;
      _nextPercentage = 0.0;
      start();
    });
  }

  stopProgress() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    setState(() {
      _percentage = 0.0;
      _nextPercentage = 0.0;
    });
  }

  printDuration() {
    var processedSeconds = _nextPercentage.toInt();

    var totalSeconds = _totalSeconds.toInt() - processedSeconds;
    int min = (totalSeconds ~/ 60);

    int seconds = totalSeconds % 60;

    return min.toString().padLeft(2, '0') +
        " : " +
        seconds.toString().padLeft(2, '0');
  }

  getProgessText() {
    return Text(
      printDuration(),
      style: TextStyle(fontSize: 15, color: Colors.black),
    );
  }

  progressView() {
    return CustomPaint(
      child: Center(),
      foregroundPainter: ProgressPainter(
          defaultCircleColor: Colors.grey[350],
          percentageCompletedCircleColor: Colors.black,
          completedPercentage: _percentage,
          circleWidth: 5.0,
          totalSeconds: _totalSeconds),
    );
  }

  publishProgress() {
    setState(() {
      _percentage = _nextPercentage;
      _nextPercentage += 1;

      if (_nextPercentage > _totalSeconds) {
        _percentage = 0.0;
        _nextPercentage = 0.0;
      }
      _progressAnimationController.forward(from: 0.0);
    });
  }

  getIcon() {
    if (isPlaying) {
      return Icons.pause;
    } else {
      return Icons.play_arrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenHeight * 0.6,
      height: screenHeight * 0.6,
      child: Column(
        children: [
          AnimatedOpacity(
            opacity: widget._visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 250),
            child: Container(
              width: screenHeight * 0.4,
              height: screenHeight * 0.4,
              padding: EdgeInsets.all(20),
              child: progressView(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedOpacity(
            opacity: widget._visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 250),
            child: getProgessText(),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: (widget._visible) ? 100 : 80,
              margin: EdgeInsets.only(top: (widget._visible) ? 0 : 30),
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.shuffle,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                  Stack(
                    children: [
                      Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          height: (widget._visible) ? 50 : 40,
                          width: screenWidth * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.fast_rewind,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(
                                    Icons.fast_forward,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: screenWidth * 0.5,
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: (widget._visible) ? 35 : 30,
                            backgroundColor: Colors.black,
                            child: IconButton(
                                icon: Icon(
                                  getIcon(),
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isPlaying) {
                                      isPlaying = false;
                                      stopProgress();
                                    } else {
                                      isPlaying = true;
                                      startProgress();
                                    }
                                  });
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.repeat,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
