import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ibnsina/provider/booling_provider.dart';
import 'package:ibnsina/users_screen_enter_face/home_screen.dart';
import 'package:ibnsina/wifgets/custom_textfeild.dart';
import 'package:provider/provider.dart';

class AuthService {
  bool createDon = false;
  bool signDon = false;
  UserCredential userCredential;
  User currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference usersReference = FirebaseFirestore.instance.collection('users');
  final TextEditingController code = TextEditingController();

  Future<void> startCreateUserWithEmailAndPassword(String name, String email, String password, BuildContext context) async {
    try {
      await createUserWithEmailAndPassword(email, password)
          .whenComplete(() async {
        if (createDon == true) {
          // await setToCloud(userCredential, name);
          await getCurrentUser();
          pushNavigator(context);
        } else {
          return showError("check your info or network");
        }
      });
    } catch (ex) {
      print(ex.toString());
      showError("check your network");
    }
  }

  Future<void> startSignInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      await signInWithEmailAndPassword(email, password).whenComplete(() async {
        if (signDon == true) {
          await getCurrentUser();
          pushNavigator(context);
        } else {
          return showError("check your info or network");
        }
      });
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(":::createUserWithEmailAndPassword is don:::");
      createDon = true;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(":::signInWithEmailAndPassword is don:::");
      signDon = true;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future <UserCredential> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      userCredential = await auth.signInWithCredential(credential).whenComplete((){});
      await getCurrentUser();
      pushNavigator(context);
    } catch (ex) {
      showError("  check your info or network");
      print("goooooo" + ex.toString());
    }
    return userCredential;
  }

  Future<void> signInByPhone(String number, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: number,
        // timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          Navigator.pop(context);
          userCredential = await auth.signInWithCredential(credential);
          await getCurrentUser();
          Provider.of<BoolIngProvider>(context,listen: false).isWrongV(false);
          if (userCredential.user != null){
           return Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));

          }else{ showError("Some Thing went wrong");}
        },
        verificationFailed: (FirebaseAuthException e) {
            showError('The provided phone number is not valid.');
            Provider.of<BoolIngProvider>(context,listen: false).isTrueOrNot(false);
            Provider.of<BoolIngProvider>(context,listen: false).isWrongV(true);
        },
        codeSent: (String verificationId, int resendToken) async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Positioned(
                  bottom: 0.0,
                  child: AlertDialog(
                    content: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width*80/100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("type a code"),
                          Container(
                            child: Expanded(
                              flex: 1,
                              child: Padding(
                                padding:  EdgeInsets.only(top:8.0),
                                child: customTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  hintText: "code",
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                  ),
                                  context: context,
                                  controller: code,
                                  autofocus: false,
                                  cursorColor: Colors.blueAccent,
                                  obscureText: false,
                                  maxLines: 1,
                                  minLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      GestureDetector(
                          onTap: () async {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: code.text.trim());
                            userCredential =
                                await auth.signInWithCredential(credential);
                            await getCurrentUser();
                            // await setToCloud(userCredential,name);
                            if(userCredential.user!=null){
                              return Navigator.push(
                                context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            }else{showError("Some thing went wrong");}
                          },
                          child: Text("verification"))
                    ],
                  ),
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) async {
          showError(verificationId);
          showError("try again");
          Provider.of<BoolIngProvider>(context,listen: false).isTrueOrNot(false);
          Provider.of<BoolIngProvider>(context,listen: false).isWrongV(true);
        },
      );
    } catch (ex) {
      showError(ex.toString());
      Provider.of<BoolIngProvider>(context,listen: false).isTrueOrNot(false);
      Provider.of<BoolIngProvider>(context,listen: false).isWrongV(true);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
  }

  Future<void> deleteUser() async {
    try {
      await auth.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<User> getCurrentUser() async {
    try {
      currentUser  = auth.currentUser;

      if (currentUser != null) {
        print(currentUser.uid);
        print("current user is don");
      }
    } catch (ex) {
      print(ex.toString());
    }
    return currentUser;
  }

  void pushNavigator(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void showError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
