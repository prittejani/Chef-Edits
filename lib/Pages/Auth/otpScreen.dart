import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Utilits/colors.dart';
import 'package:restaurant_app/Utilits/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
    ),
  );
}

class OtpScreen extends StatefulWidget {
  String verificationId = '';
  String phoneNumber = '';
  String ReVerificationIdForOtp = '';

  OtpScreen({Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  AppWidgets appWidgets = AppWidgets();
  FirebaseAuth auth = FirebaseAuth.instance;
  String ReVerificationIdForOtp = '';

  int start = 60;
  bool isVisible = false;

  void show() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void otpTimer() {
    const oneSec = Duration(seconds: 01);
    Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        timer.cancel();
        //show();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  VerifyOtp() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: '${widget.verificationId}',
          smsCode: '${otpController.text}');

      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Verify Successfully')));

      log(user?.uid ?? '');
      log(user?.phoneNumber ?? '');
    } on FirebaseAuthException catch (exception) {
      log('Verification Id for Otp :   ${widget.verificationId}');
      log("Error ~~>> ${exception.code}");
    }
  }

  @override
  void initState() {
    otpTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    otpController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: otpController.text.length,
      ),
    );
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.MainGray,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Container(
                  height: size.height / 10,
                ),
                Container(
                  height: size.height / 6,
                  width: size.width / 3,
                  child: Image.asset('assets/images/logo.png'),
                ),
                appWidgets.SpaceBox(height: size.height / 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appWidgets.SpaceBox(width: size.width / 13),
                    Text(
                      'Verification Code',
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 22),
                    ),
                  ],
                ),
                appWidgets.SpaceBox(height: size.height / 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter OTP sent on your registered phone number',
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 13),
                    ),
                  ],
                ),
                appWidgets.SpaceBox(height: size.height / 30),
                Container(
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
                        alignment: Alignment.center,
                        height: size.height / 14,
                        width: size.width / 1.2,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              otpController.text = value;
                            });
                          },
                          controller: otpController,
                          keyboardType: TextInputType.phone,
                          cursorColor: AppColors.blackColor,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: AppColors.MainGray),
                              labelText: 'Enter Otp',
                              hintStyle: TextStyle(color: AppColors.MainGray),
                              border: InputBorder.none,
                              suffixIcon: otpController.text.length == 6
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
                                  : null),
                        ),
                      ),
                    ],
                  ),
                ),
                appWidgets.SpaceBox(height: size.height / 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Otp Resend In',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                    Text(
                      "\t00:$start",
                      style: TextStyle(color: AppColors.MainYellow),
                    ),
                    Text(
                      '\tseconds',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ],
                ),
                appWidgets.SpaceBox(height: size.height / 30),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: true,
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 20,
                    width: size.width / 2.5,
                    decoration: BoxDecoration(
                      color: AppColors.MainYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        auth.verifyPhoneNumber(
                            phoneNumber: '+91${widget.phoneNumber}',
                            timeout: const Duration(seconds: 60),
                            verificationCompleted:
                                (AuthCredential credential) {},
                            verificationFailed:
                                (FirebaseAuthException authException) {
                              log(authException.code);
                            },
                            codeSent: (String verifificationId, int? id) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Code ReSent Successfully'),
                                ),
                              );

                              ReVerificationIdForOtp = verifificationId;
                              log("Id ~~>> $ReVerificationIdForOtp");
                            },
                            codeAutoRetrievalTimeout: (String val) {});
                      },
                      child: Text(
                        'ReSend OTP',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.MainGray),
                      ),
                    ),
                  ),
                ),
                appWidgets.SpaceBox(height: size.height / 30),
                Container(
                  alignment: Alignment.center,
                  height: size.height / 20,
                  width: size.width / 2.5,
                  decoration: BoxDecoration(
                    color: AppColors.MainYellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      VerifyOtp();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.MainGray),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
