import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircleProgress extends StatelessWidget {
  const CustomCircleProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Opacity(
        opacity: 0.3,
        child: Container(
            height: _height,
            width: _width,
            color: Colors.grey[700],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    strokeWidth: 4.0,
                    backgroundColor: Color(0xffA3E29F),
                   ),
                SizedBox(height: 16.0,),
                Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 24.0),)
              ],
            )),
      ),
    );
  }
}
