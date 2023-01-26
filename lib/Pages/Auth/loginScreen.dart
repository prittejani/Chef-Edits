import 'package:flutter/material.dart';
import 'package:restaurant_app/Utilits/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../Utilits/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool ObscureText = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.MainGray,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: size.height / 5,
                  width: size.width / 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/cookinglogo.png'),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: size.height / 12,
                        width: size.width / 2.5,
                        child: AnimatedTextKit(
                          displayFullTextOnTap: false,
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            WavyAnimatedText(
                              "Login",
                              textStyle: GoogleFonts.lobster(
                                  color: Colors.yellow, fontSize: 40),
                              speed: Duration(milliseconds: 500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SpaceBox(height: size.height / 20),
            Container(
              height: size.height / 13,
              width: size.width / 1.1,
              decoration: BoxDecoration(
                color: AppColors.MainYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SpaceBox(width: size.width / 20),
                  Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width / 1.2,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email Can't be Empty";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return "Enter Correct Email";
                        } else {
                          return null;
                        }
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColors.blackColor,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          size: 27,
                          color: AppColors.MainGray,
                        ),
                        labelStyle: TextStyle(color: AppColors.MainGray),
                        labelText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SpaceBox(height: size.height / 20),
            Container(
              height: size.height / 13,
              width: size.width / 1.1,
              decoration: BoxDecoration(
                color: AppColors.MainYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SpaceBox(width: size.width / 20),
                  Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width / 1.2,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Create Password";
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(value!)) {
                          return "Please Enter Valid Password";
                        } else {
                          return null;
                        }
                      },
                      controller: passController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColors.blackColor,
                      obscureText: ObscureText,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              ObscureText = !ObscureText;
                            });
                          },
                          child: Icon(
                            ObscureText
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.MainGray,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_open,
                          size: 27,
                          color: AppColors.MainGray,
                        ),
                        labelStyle: TextStyle(color: AppColors.MainGray),
                        labelText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SpaceBox(height: size.height/25),
            Container(
              alignment: Alignment.center,
              height: size.height / 16,
              width: size.width / 2.5,
              decoration: BoxDecoration(
                color: AppColors.MainYellow,
                borderRadius: BorderRadius.circular(40),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
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
    );
  }
}
