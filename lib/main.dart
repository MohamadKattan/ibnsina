import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ibnsina/provider/booling_provider.dart';
import 'package:ibnsina/provider/circuler_provider.dart';
import 'package:ibnsina/provider/doble_value.dart';
import 'package:ibnsina/users_screen_enter_face/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CircularProvider()),
        ChangeNotifierProvider(create: (context) => BoolIngProvider()),
        ChangeNotifierProvider(create: (context) => DoubleProvider()),
      ],
      child: MaterialApp(
        title: "Ibn Sina",
        home: SplashScreen(),
      ),
    );
  }
}
