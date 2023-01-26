import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  TextEditingController bdateController = TextEditingController();
  TextEditingController unameController = TextEditingController();

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
                  //verificationId: verificationIdForOtp,
                  // phoneNumber: phoneController.text,
                  ),
            ),
          );

          verificationIdForOtp = verifificationId;
          log("Id ~~>> $verificationIdForOtp");
        },
        codeAutoRetrievalTimeout: (String val) {});
  }

  final _formkey = GlobalKey<FormState>();

  bool ObscureText = true;

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
      body: Form(
        key: _formkey,
        child: Container(
          alignment: Alignment.center,
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpaceBox(height: size.height / 20),
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
                                "Sign-Up",
                                textStyle: GoogleFonts.lobster(
                                    color: Colors.yellow, fontSize:40),
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
              Expanded(
                child: Container(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
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
                                      return "Full Name Can't be Empty";
                                    } else if (!RegExp(r'^[a-z A-Z]+$')
                                        .hasMatch(value!)) {
                                      return "Enter Correct First Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  cursorColor: AppColors.blackColor,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.abc,
                                      size: 30,
                                      color: AppColors.MainGray,
                                    ),
                                    labelStyle:
                                        TextStyle(color: AppColors.MainGray),
                                    labelText: 'Full Name',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SpaceBox(height: size.height / 25),
                        Container(
                          alignment: Alignment.bottomCenter,
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
                                    labelStyle:
                                        TextStyle(color: AppColors.MainGray),
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
                                    labelStyle:
                                        TextStyle(color: AppColors.MainGray),
                                    labelText: 'Password',
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
                                      return "Please Enter Password";
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value!)) {
                                      return "Please Enter Valid Password";
                                    } else if (value != passController.text) {
                                      return "Password is Not Match";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: confirmpassController,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: AppColors.blackColor,
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
                                      Icons.lock,
                                      size: 27,
                                      color: AppColors.MainGray,
                                    ),
                                    labelStyle:
                                        TextStyle(color: AppColors.MainGray),
                                    labelText: 'Confirm Password',
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
                                      return "Username can't be Empty";
                                    } else if (value.length >= 2) {
                                      return "Please enter more than two characters username and small letters";
                                    } else if (!RegExp(r'^[a-z]+$')
                                        .hasMatch(value!)) {
                                      return "Enter Correct username";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: unameController,
                                  keyboardType: TextInputType.name,
                                  cursorColor: AppColors.blackColor,
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      size: 27,
                                      color: AppColors.MainGray,
                                    ),
                                    labelStyle:
                                        TextStyle(color: AppColors.MainGray),
                                    labelText: 'Username',
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
                              SpaceBox(width: size.width / 12),
                              Container(
                                height: size.height / 30,
                                width: size.width / 11.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.MainGray,
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/flag.png'),
                                  ),
                                ),
                              ),
                              SpaceBox(width: 15.0),
                              Text(
                                "+91",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SpaceBox(width: 15.0),
                              Container(
                                alignment: Alignment.center,
                                height: size.height / 14,
                                width: size.width / 1.8,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Mobile Number Can't be Empty";
                                    } else if (!RegExp(r"^^[0-9]*$")
                                        .hasMatch(value!)) {
                                      return "Enter Correct Mobile Number";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (v) {
                                    setState(() {
                                      phoneController.text = v;
                                    });
                                  },
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: AppColors.blackColor,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Phone Number',
                                    labelStyle:
                                        TextStyle(color: AppColors.MainGray),
                                    border: InputBorder.none,
                                    suffixIcon:
                                        phoneController.text.length == 10
                                            ? Container(
                                                height: 1,
                                                width: 1,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.MainGray,
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  color: AppColors.MainYellow,
                                                  size: 30,
                                                ),
                                              )
                                            : null,
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
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2024),
                                        builder: (context, child) {
                                          return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: AppColors.MainGray,
                                                  onPrimary:
                                                      AppColors.MainYellow,
                                                  onSurface:
                                                      AppColors.blackColor,
                                                ),
                                              ),
                                              child: child!);
                                        });
                                    if (pickedDate != null) {
                                      bdateController.text =
                                          pickedDate.day.toString() +
                                              '-' +
                                              pickedDate.month.toString() +
                                              '-' +
                                              pickedDate.year.toString();
                                    } else {
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Please Select Date'),
                                          duration: Duration(seconds: 4),
                                        ),
                                      );
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Birthdate can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: bdateController,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: AppColors.blackColor,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: AppColors.MainGray,
                                      size: 30,
                                    ),
                                    labelStyle:
                                        TextStyle(color: AppColors.MainGray),
                                    labelText: 'Birth Date',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SpaceBox(height: size.height / 20),
                        GestureDetector(
                          onTap: () {
                           // if (_formkey.currentState!.validate()) {
                              //   //sendOtp();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(),
                                ),
                              );
                           // }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height / 16,
                            width: size.width / 1.8,
                            decoration: BoxDecoration(
                              color: AppColors.MainYellow,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: AppColors.MainGray),
                            ),
                          ),
                        ),
                        SpaceBox(height: size.height / 20),
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
                        SpaceBox(height: size.height / 20),
                        Container(
                          height: size.height / 13,
                          width: size.width / 1.1,
                          decoration: BoxDecoration(
                            color: AppColors.MainYellow,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              SpaceBox(width: size.width / 7),
                              Container(
                                height: size.height / 20,
                                width: size.width / 9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/google.png'),
                                  ),
                                ),
                              ),
                              SpaceBox(width: size.width / 10),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(fontSize: 17),
                              ),
                              SpaceBox(width: size.width / 7),
                            ],
                          ),
                        ),
                        SpaceBox(height: size.height / 20),
                        Text(
                          '               By continuing, you agree to our\n Terms of Services Privacy Policy and Content',
                          style: TextStyle(
                              color: AppColors.MainYellow, fontSize: 12),
                        ),
                        SpaceBox(height: size.height / 30),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
