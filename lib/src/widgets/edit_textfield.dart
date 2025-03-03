import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTextField extends StatelessWidget {
  final TextInputType inputType;
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  const EditTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hintText,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      style: GoogleFonts.aBeeZee(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.aBeeZee(fontSize: 14),
        suffixIcon: Icon(
          icon,
          color: Colors.black54,
          size: 22,
        ),
      ),
    );
  }
}
