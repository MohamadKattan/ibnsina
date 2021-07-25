import 'package:flutter/material.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:ibnsina/users_screen_enter_face/login_screen.dart';

class HomeScreen extends StatelessWidget {
 final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                onTap: () async {
                  await _authService.signOut().whenComplete(() =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()),
                          (route) => false));
                },
                child: Text("HomeScreen"))));
  }
}
