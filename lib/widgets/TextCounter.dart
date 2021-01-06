import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextCounter extends StatefulWidget {
  TextCounter({Key key, @required int duration})
      : _duration = duration,
        super(key: key);

  int _duration;

  @override
  _TextCounterState createState() => _TextCounterState();
}

class _TextCounterState extends State<TextCounter> {
  Timer _timer;

  void startTimer() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (widget._duration == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            widget._duration--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("${widget._duration}", style: TextStyle(color: Colors.blue));
  }
}
