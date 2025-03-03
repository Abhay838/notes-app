import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int? maxLine;
  const TaskTextField({
    super.key,
    required this.controller,
    required this.text,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine ?? 5,
      controller: controller,
      style: GoogleFonts.aBeeZee(fontSize: 16),
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            )),
      ),
    );
  }
}
