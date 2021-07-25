import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnsina/bloc_auth/auth_bloc.dart';
import 'package:ibnsina/provider/booling_provider.dart';
import 'package:ibnsina/provider/circuler_provider.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'package:ibnsina/users_screen_enter_face/splash_screen.dart';
import 'package:provider/provider.dart';
import 'bloc_auth/auth_state.dart';

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
      ],
      child: MaterialApp(
        title: "Ibn Sina",
        home: MultiBlocProvider(providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc(InitialState(), AuthService()),
          ),
        ], child: SplashScreen()),
      ),
    );
  }
}
