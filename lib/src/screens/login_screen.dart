import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_app/src/controllers/auth_controller.dart';
import 'package:notes_app/src/screens/registration_screen.dart';
import 'package:notes_app/src/utils/color.dart';
import 'package:notes_app/src/widgets/edit_button.dart';
import 'package:notes_app/src/widgets/edit_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.find<AuthController>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Login",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 2, bottom: 2, right: 1),
                    decoration: BoxDecoration(
                        border: Border.all(color: kred, width: 1.5),
                        borderRadius: BorderRadius.circular(25)),
                    child: Icon(
                      Icons.book_rounded,
                      size: 100.h,
                      color: kred,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "Welcome Back !",
                  style: GoogleFonts.aBeeZee(
                    color: kred,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Enter Your Details",
                  style: GoogleFonts.aBeeZee(
                    color: kpurple,
                    fontWeight: FontWeight.w100,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 15.h),
                EditTextField(
                  controller: email,
                  icon: FontAwesomeIcons.envelope,
                  hintText: 'Email Address',
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15.h),
                EditTextField(
                  controller: password,
                  icon: FontAwesomeIcons.eyeSlash,
                  hintText: 'Password',
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 40.h),
                Obx(
                  () {
                    return _authController.isLoading.value
                        ? const Center(
                            child: SizedBox(
                              height: 80,
                              width: 100,
                              child: LoadingIndicator(
                                indicatorType: Indicator.lineScale,
                                colors: [
                                  Colors.green,
                                  Colors.red,
                                  Colors.blue,
                                  Colors.yellow,
                                  Colors.orange,
                                ],
                                strokeWidth: 2,
                                //backgroundColor: Colors.black,
                                pathBackgroundColor: Colors.black,
                              ),
                            ),
                          )
                        : EditButton(
                            text: "Log In",
                            onPressed: () {
                              _authController.loginUser(
                                email: email.text.trim(),
                                password: password.text.trim(),
                              );
                            },
                          );
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don`t have an account? ",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const RegistrationScreen());
                      },
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.aBeeZee(
                          color: kred,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
