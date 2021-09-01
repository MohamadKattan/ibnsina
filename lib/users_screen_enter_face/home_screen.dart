import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ibnsina/provider/booling_provider.dart';
import 'package:ibnsina/provider/doble_value.dart';
import 'package:ibnsina/wifgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var value = Provider.of<DoubleProvider>(context).value;
    var isTrue = Provider.of<BoolIngProvider>(context).isBoolIng;

    return Scaffold(
        body: Builder(
      builder: (context) => SafeArea(
        child: Stack(
          children: [
            customDrawer(context),
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: value),
                duration: Duration(milliseconds: 700),
                builder: (_, double val, __) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 300 * val)
                      ..rotateY((pi / 6) * val),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                    ),
                  );
                }),
          isTrue==false?
          Positioned(
              top: 0.0,
              left: 0.0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      Provider.of<DoubleProvider>(context, listen: false)
                          .value0Or1(1);
                      Provider.of<BoolIngProvider>(context, listen: false)
                          .isTrueOrNot(true);
                    },
                    child: CircleAvatar(
                        backgroundColor: Color(0xff4A60AF),
                        radius: 25,
                        child: Icon(
                          Icons.format_list_numbered_rtl_rounded,
                          color: Color(0xffCFF0CB),
                          size: 30,
                        ))),
              ),
            ):Text(""),
            isTrue==false?
           Text(""):Positioned(
              bottom: 0.0,
              left: 220.0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      Provider.of<DoubleProvider>(context, listen: false)
                          .value0Or1(0);
                      Provider.of<BoolIngProvider>(context, listen: false)
                          .isTrueOrNot(false);
                    },
                    child: CircleAvatar(
                        backgroundColor: Color(0xffCFF0CB),
                        radius: 25,
                        child: Icon(
                          Icons.format_list_numbered,
                          color: Color(0xff4A60AF),
                          size: 30,
                        ))),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
