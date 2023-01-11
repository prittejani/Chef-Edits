import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/signupScreen.dart';
import 'package:restaurant_app/Utilits/colors.dart';

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
      Duration(seconds: 5),
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignupScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: size.height,
          width: size.width,
          color: AppColors.MainGray,
          child: Container(
            height: size.height / 2,
            width: size.width / 2,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
