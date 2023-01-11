import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Pages/Auth/otpScreen.dart';
import 'package:restaurant_app/Utilits/colors.dart';
import 'package:restaurant_app/Utilits/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: SignupScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AppWidgets appWidgets = AppWidgets();
  TextEditingController phoneController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdForOtp = '';

  sendOtp() {
    auth.verifyPhoneNumber(
        phoneNumber: '+91${phoneController.text}',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) {},
        verificationFailed: (FirebaseAuthException authException) {
          log(authException.code);
        },
        codeSent: (String verifificationId, int? id) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationIdForOtp,
                phoneNumber: phoneController.text,
              ),
            ),
          );

          verificationIdForOtp = verifificationId;
          log("Id ~~>> $verificationIdForOtp");
        },
        codeAutoRetrievalTimeout: (String val) {});
  }
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.MainGray,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height / 6,
                width: size.width / 3,
                child: Image.asset('assets/images/logo.png'),
              ),
              appWidgets.SpaceBox(height: size.height / 20),
              Text(
                "Welcome to Chef Edit's",
                style: TextStyle(color: AppColors.MainYellow, fontSize: 20),
              ),
              appWidgets.SpaceBox(height: size.height / 20),
              Form(
                key: formkey,
                child: Container(
                  height: size.height / 13,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    color: AppColors.MainYellow,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      appWidgets.SpaceBox(width: size.width / 20),
                      Container(
                        height: size.height / 20,
                        width: size.width / 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.MainGray,
                          image: DecorationImage(
                            image: AssetImage('assets/images/flag.png'),
                          ),
                        ),
                      ),
                      appWidgets.SpaceBox(width: 15.0),
                      Text(
                        "+91",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      appWidgets.SpaceBox(width: 15.0),
                      Container(
                        alignment: Alignment.center,
                        height: size.height / 14,
                        width: size.width / 1.8,
                        //color: Colors.black,
                        child: TextField(
                          onChanged: (v) {
                            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = new RegExp(pattern);
                            if (phoneController.toString().isEmpty) {
                              'Please enter mobile number';
                            }
                            else if (!regExp.hasMatch(phoneController.text)) {
                               'Please enter valid mobile number';
                            }
                          },
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          cursorColor: AppColors.blackColor,
                          decoration: InputDecoration(
                              hintText: 'Enter Phone Number',
                              hintStyle: TextStyle(color: AppColors.MainGray),
                              border: InputBorder.none,
                              suffixIcon: phoneController.text.length == 10
                                  ? Container(
                                      height: 1,
                                      width: 1,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.MainGray),
                                      child: Icon(
                                        Icons.check,
                                        color: AppColors.MainYellow,
                                        size: 30,
                                      ),
                                    )
                                  : null,),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              appWidgets.SpaceBox(height: size.height / 20),
              GestureDetector(
                onTap: () {
                  if(formkey.currentState!.validate()){
                   sendOtp();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height / 13,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    color: AppColors.MainYellow,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: AppColors.MainGray),
                  ),
                ),
              ),
              appWidgets.SpaceBox(height: size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width / 2.5,
                    height: size.height / 1000,
                    color: AppColors.whiteColor,
                  ),
                  Text(
                    '    OR\t\t',
                    style: TextStyle(color: AppColors.MainYellow),
                  ),
                  Container(
                    width: size.width / 2.5,
                    height: size.height / 1000,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
              appWidgets.SpaceBox(height: size.height / 20),
              Container(
                height: size.height / 13,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  color: AppColors.MainYellow,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    appWidgets.SpaceBox(width: size.width / 7),
                    Container(
                      height: size.height / 20,
                      width: size.width / 9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/google.png'),
                        ),
                      ),
                    ),
                    appWidgets.SpaceBox(width: size.width / 10),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 17),
                    ),
                    appWidgets.SpaceBox(width: size.width / 7),
                  ],
                ),
              ),
              appWidgets.SpaceBox(height: size.height / 10),
              Text(
                '               By continuing, you agree to our\n Terms of Services Privacy Policy and Content',
                style: TextStyle(color: AppColors.MainYellow, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
