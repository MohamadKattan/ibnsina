import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibnsina/provider/booling_provider.dart';
import 'package:provider/provider.dart';

Widget circularCountDownTimer(BuildContext context) {
  final CountDownController  countDownController = CountDownController();
  return CircularCountDownTimer(
    duration: 120,
    initialDuration: 0,
    controller: countDownController,
    width: MediaQuery.of(context).size.width / 2,
    height: MediaQuery.of(context).size.height / 2,
    ringColor: Colors.grey[300],
    fillColor: Color(0xffCFF3CB),
    backgroundColor: Color(0xff4A60AF),
    strokeWidth: 20.0,
    strokeCap: StrokeCap.round,
    textStyle: TextStyle(
        fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
    textFormat: CountdownTextFormat.S,
    isReverse: true,
    isReverseAnimation: true,
    isTimerTextShown: true,
    autoStart:true,
    onStart: () {
      print('Countdown Started');
    },
    onComplete: () {
     Provider.of<BoolIngProvider>(context,listen: false).isTrueOrNot(false);
    },
  );
}
