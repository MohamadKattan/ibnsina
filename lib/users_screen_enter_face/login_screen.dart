import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibnsina/provider/circuler_provider.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:ibnsina/users_screen_enter_face/phone_number_user.dart';
import 'package:ibnsina/users_screen_enter_face/register_screen.dart';
import 'package:ibnsina/wifgets/custom_circle_prgross.dart';
import 'package:ibnsina/wifgets/custom_textfeild.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
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
                      children: [
                        GestureDetector(
                          onTap: () {
                            checkTextField(context);
                          },
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Color(0xff4A60AF)),
                            child: Center(
                              child: Text(
                                "Login",
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
                        Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                              color: Color(0xffCFF3CB),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          })),
                          child: Text(
                            "Register ",
                            style: TextStyle(
                                color: Color(0xff4A60AF),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xff4A60AF),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Center(
                      child: Text("Or",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Color(0xffCFF3CB))),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:(){
                           return  Navigator.push(context, MaterialPageRoute(builder:(context)=>PhoneNo()
                             ));
                          },
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff4A60AF),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.phone,
                                  color: Color(0xff4A60AF),
                                  size: 25,
                                ),
                                radius: 28,
                                backgroundColor: Color(0xffCFF3CB),
                              )),
                        ),
                        SizedBox(
                          width: 28.0,
                        ),
                        GestureDetector(
                          onTap:()async{
                            Provider.of<CircularProvider>(context, listen: false)
                                .circularLoading(true);
                          await  _authService.signInWithGoogle(context);

                            Provider.of<CircularProvider>(context, listen: false)
                                .circularLoading(false);
                          },
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff4A60AF),
                              child: CircleAvatar(
                                child: Text(
                                  "G",
                                  style: TextStyle(
                                      color: Color(0xff4A60AF),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                radius: 28,
                                backgroundColor: Color(0xffCFF3CB),
                              )),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              loading.isLoading == true ? CustomCircleProgress() : Text(""),
            ],
          )),
        ));
  }

  void checkTextField(BuildContext context) {
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

  void clearTextFields() {
    _emailController.clear();
    _passWordController.clear();
  }
}
