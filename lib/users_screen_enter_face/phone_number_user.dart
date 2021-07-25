import 'package:flutter/material.dart';
import 'package:ibnsina/provider/booling_provider.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:ibnsina/wifgets/circularCountDownTimer.dart';
import 'package:ibnsina/wifgets/custom_textfeild.dart';
import 'package:provider/provider.dart';

class PhoneNo extends StatelessWidget {
  final AuthService _service = AuthService();
  final TextEditingController phone = TextEditingController();
  // final bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    var isBoolIng = Provider.of<BoolIngProvider>(context);
    var isWrong = Provider.of<BoolIngProvider>(context);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
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
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isBoolIng.isBoolIng == true
                          ? circularCountDownTimer(context)
                          : Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.phonelink_sharp,
                                size: 150,
                                color: Color(0xff4A60AF),
                              ),
                            ),
                      Container(
                        child: customTextField(
                          keyboardType: TextInputType.phone,
                          hintText: "+ keyCountry phoneNumber",
                          icon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          context: context,
                          controller: phone,
                          autofocus: false,
                          cursorColor: Colors.blueAccent,
                          obscureText: false,
                          maxLines: 1,
                          minLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                checkTextfeild(context);
                              },
                              child: Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width *
                                    40 /
                                    100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color:isWrong.isWrong==false?Color(0xff4A60AF):Colors.red,),
                                child: Center(
                                  child: Text(
                                    isWrong.isWrong==false? "Login":"Try again",
                                    style: TextStyle(
                                        color:Color(0xffCFF3CB),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkTextfeild(BuildContext context) {
    if (phone.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("phone number can't be empty"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    } else {
      Provider.of<BoolIngProvider>(context, listen: false).isTrueOrNot(true);
      _service.signInByPhone(phone.text.trim(), context);
    }
  }
}
