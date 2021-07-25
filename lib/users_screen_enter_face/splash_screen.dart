import 'package:flutter/material.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:ibnsina/users_screen_enter_face/home_screen.dart';
import 'package:ibnsina/users_screen_enter_face/login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
   AnimationController _animationController;
   AuthService _authService = AuthService();
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
        lowerBound: 0.1,
        upperBound: 0.9);
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            // return LogInScreen() ;
            return _authService.auth.currentUser==null ? LogInScreen() : HomeScreen();
          }),
        );
      }
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: _height,
              width: _width,
              child: Image.asset(
                "images/background.png",
                fit: BoxFit.cover,
              ),
            ),
            ScaleTransition(
              scale: _animationController,
              child: Container(
                height: _height,
                width: _width,
                child: Image.asset("images/splash.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
}
