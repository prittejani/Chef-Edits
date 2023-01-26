import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/Auth/loginScreen.dart';
import 'package:restaurant_app/Pages/Auth/otpScreen.dart';
import 'package:restaurant_app/Pages/Auth/signupScreen.dart';
import 'package:restaurant_app/Pages/splashScreen.dart';
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}