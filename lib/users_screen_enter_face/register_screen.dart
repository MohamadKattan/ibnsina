import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibnsina/provider/circuler_provider.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:ibnsina/users_screen_enter_face/login_screen.dart';
import 'package:ibnsina/wifgets/custom_circle_prgross.dart';
import 'package:ibnsina/wifgets/custom_textfeild.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    var loading = Provider.of<CircularProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) => SafeArea(
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
                          keyboardType: TextInputType.name,
                          hintText: "Name",
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          context: context,
                          controller: _nameController,
                          autofocus: false,
                          cursorColor: Colors.blueAccent,
                          obscureText: false),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
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
                          cursorColor: Colors.blueAccent,
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
                        cursorColor: Colors.blueAccent,
                        obscureText: true,
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color(0xff4A60AF)),
                          child: GestureDetector(
                            onTap: () {
                              return checkTextField(context);
                            },
                            child: Center(
                              child: Text(
                                "Register",
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Already do you have an account?",
                            style: TextStyle(
                                color: Color(0xffCFF3CB),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LogInScreen();
                            })),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Color(0xff4A60AF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              loading.isLoading==true? CustomCircleProgress(): Text(""),
            ],
          )),
        ));
  }

  void checkTextField(BuildContext context) {
    if (_nameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Name can't be empty"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
    if (_emailController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Email can't be empty"),
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
    } else {
      Provider.of<CircularProvider>(context,listen: false).circularLoading(true);
      _authService
          .startCreateUserWithEmailAndPassword(
            _nameController.text,
            _emailController.text.trim(),
            _passWordController.text.trim(),
            context,
          )
          .whenComplete(() =>{
      Provider.of<CircularProvider>(context,listen: false).circularLoading(false),
        clearTextFields()
      });
    }
  }

  void clearTextFields() {
    _nameController.clear();
    _emailController.clear();
    _passWordController.clear();
  }
}
