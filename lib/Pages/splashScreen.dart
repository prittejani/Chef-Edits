import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:lottie/lottie.dart';
import 'package:restaurant_app/Pages/Auth/signupScreen.dart';
import 'package:restaurant_app/Utilits/colors.dart';
import 'package:restaurant_app/Utilits/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 7),
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignupScreen(),
        ),
      ),
    );
    speak();
  }


    FlutterTts flutterTts = FlutterTts();
    void speak() async {
     await flutterTts.setLanguage("en-IN");
     await flutterTts.setPitch(1);
     await flutterTts.speak("Welcome to Chef Edit's");
    }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.MainGray,
        body: Center(
          child: Container(
            height: size.height / 1.25,
            width: size.width / 1.25,
            child: Lottie.asset('assets/animation/cooking_animation.json'),
          ),
        ),
      ),
    );
  }
}
