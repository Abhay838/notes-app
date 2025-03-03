import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/src/utils/color.dart';

class EditButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const EditButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 50.h,
        child: MaterialButton(
          onPressed: onPressed,
          color: kred,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.h),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
