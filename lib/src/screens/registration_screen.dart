import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_app/src/screens/login_screen.dart';
import 'package:notes_app/src/widgets/edit_button.dart';

import '../controllers/auth_controller.dart';
import '../utils/color.dart';
import '../widgets/edit_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthController _authController = Get.find<AuthController>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "Welcome!",
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
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 15.h),
                EditTextField(
                  controller: username,
                  icon: Icons.person_2_outlined,
                  hintText: 'User Name',
                  inputType: TextInputType.name,
                ),
                SizedBox(height: 15.h),
                EditTextField(
                  controller: email,
                  icon: FontAwesomeIcons.envelope,
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15.h),
                EditTextField(
                  controller: phoneNumber,
                  icon: Icons.phone_outlined,
                  hintText: 'Phone Number',
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 15.h),
                EditTextField(
                  controller: password,
                  icon: FontAwesomeIcons.eyeSlash,
                  hintText: 'Password',
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 30.h),
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
                            text: 'Sign up',
                            onPressed: () {
                              _authController.userRegistration(
                                username: username.text.trim(),
                                email: email.text.trim(),
                                password: password.text.trim(),
                                phone: phoneNumber.text.trim(),
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
                      "Already have an account? ",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.aBeeZee(
                          color: kred,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
