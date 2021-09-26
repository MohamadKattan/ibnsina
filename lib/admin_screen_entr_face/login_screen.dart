import 'package:flutter/material.dart';
import 'package:ibnsina/provider/circuler_provider.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:ibnsina/wifgets/custom_circle_prgross.dart';
import 'package:ibnsina/wifgets/custom_textfeild.dart';
import 'package:provider/provider.dart';

class LoginAdminScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<CircularProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login as a admin",
            style: TextStyle(color: Color(0xff4A60AF)),
          ),
          centerTitle: false,
          backgroundColor: Color(0xffCFF3CB),
        ),
        body: Builder(
            builder: (context) => Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: AssetImage("images/background.png"),
                      ),
                    ),
                    Positioned(
                        top: 0.0,
                        left: 0.0,
                        child: Container(
                            child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Container(
                              child: Image.asset(
                            "images/splash.png",
                            width: 115.0,
                            height: 115.0,
                          )),
                        ))),
                    Padding(
                      padding: EdgeInsets.only(top: 200.0),
                      child: Container(
                        child: ListView(children: [
                          Center(
                            child: customTextField(
                                keyboardType: TextInputType.emailAddress,
                                hintText: "email",
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                context: context,
                                controller: _emailController,
                                autofocus: false,
                                obscureText: false),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Center(
                            child: customTextField(
                              keyboardType: TextInputType.visiblePassword,
                              hintText: "PassWord",
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              context: context,
                              controller: _passWordController,
                              autofocus: false,
                              obscureText: true,
                              maxLines: 1,
                              minLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  checkTextField(context);
                                },
                                child: Container(
                                  height: 35,
                                  width: MediaQuery.of(context).size.width *
                                      40 /
                                      100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Color(0xff4A60AF)),
                                  child: Center(
                                    child: Text(
                                      "Enter",
                                      style: TextStyle(
                                          color: Color(0xffCFF3CB),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                        ]),
                      ),
                    ),
                    loading.isLoading == true
                        ? CustomCircleProgress()
                        : Text(""),
                  ],
                )),
      ),
    );
  }

  void checkTextField(BuildContext context) {
    if (_emailController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Email can't be empty"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
    if (_emailController.text != "admin88@admin88.com") {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Email is wrong"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
    if (_passWordController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("password can't be empty"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
      if (_passWordController.text != "admin88") {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("password is wrong"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ));
      } else {
        Provider.of<CircularProvider>(context, listen: false)
            .circularLoading(true);
        _authService
            .startSignInWithEmailAndPassword(
          _emailController.text.trim(),
          _passWordController.text.trim(),
          context,
        )
            .whenComplete(() {
          Provider.of<CircularProvider>(context, listen: false)
              .circularLoading(false);
          clearTextFields();
        });
      }
    }
  }

  void clearTextFields() {
    _emailController.clear();
    _passWordController.clear();
  }
}
