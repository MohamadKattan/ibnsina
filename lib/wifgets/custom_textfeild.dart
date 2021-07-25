import 'package:flutter/material.dart';

Widget customTextField({
  BuildContext context,
 TextEditingController controller,
  TextInputType keyboardType,
  Color cursorColor,
  bool autofocus,
  bool obscureText,
  int maxLength,
  int  maxLines,
  int minLines,
  String hintText,
  Widget icon
}) {
  final _width = MediaQuery.of(context).size.width * 90 / 100;
  return Container(
    height: 60.0,
    width: _width,
    decoration: BoxDecoration(
      color: Color(0xffA3E29F),
      borderRadius: BorderRadius.circular(4.0),
      boxShadow: [
        BoxShadow(
            color: Color(0xffCFF3CB),
            blurRadius: 0.6,
            spreadRadius: 1.0,
            offset: Offset(0.6, 0.6))
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        autofocus: autofocus,
        obscureText:obscureText,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        controller: controller,
        cursorColor: cursorColor,
        style: TextStyle(color: Colors.black, fontSize: 16.0),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: hintText,
            icon: icon,
            hintStyle: TextStyle(color: Colors.white)),
      ),
    ),
  );
}
