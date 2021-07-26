import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibnsina/provider/booling_provider.dart';
import 'package:ibnsina/provider/doble_value.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:provider/provider.dart';

Widget customDrawer(BuildContext context) {
  final AuthService _authService = AuthService();
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff4A90AF),
        Color(0xff4A80AF),
        Color(0xff4A70AF),
        Color(0xff4A60AF),
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 10.0),
                Text(
                  "User",
                  style: TextStyle(color: Color(0xffCFF3CB), fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 4.0,
            ),
            ListTile(
              onTap: () => null,
              leading: Icon(Icons.home, color: Color(0xffCFF3CB)),
              title: Text(
                "HomeScreen",
                style: TextStyle(color: Color(0xffCFF3CB)),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            ListTile(
              onTap: () => null,
              leading: Icon(Icons.home, color: Color(0xffCFF3CB)),
              title: Text(
                "HomeScreen",
                style: TextStyle(color: Color(0xffCFF3CB)),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            ListTile(
              onTap: () => null,
              leading: Icon(Icons.home, color: Color(0xffCFF3CB)),
              title: Text(
                "HomeScreen",
                style: TextStyle(color: Color(0xffCFF3CB)),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            ListTile(
              onTap: () => null,
              leading: Icon(Icons.home, color: Color(0xffCFF3CB)),
              title: Text(
                "HomeScreen",
                style: TextStyle(color: Color(0xffCFF3CB)),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            ListTile(
              onTap: () => null,
              leading: Icon(Icons.home, color: Color(0xffCFF3CB)),
              title: Text(
                "HomeScreen",
                style: TextStyle(color: Color(0xffCFF3CB)),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            ListTile(
              onTap: ()  {

                _authService.signOut(context);
              },
              leading: Icon(Icons.exit_to_app, color: Color(0xffCFF3CB)),
              title: Text(
                "SignOut",
                style: TextStyle(color: Color(0xffCFF3CB)),
              ),
            )
          ],
        )
      ],
    ),
  );
}
