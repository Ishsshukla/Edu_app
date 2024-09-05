import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edu_app/constants/constants.dart';

class CustomButton extends StatelessWidget {
  void Function()? function;
  Color color;
  Color textColor;
  String text;
  CustomButton(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      radius: 2,
      onTap: function,
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.symmetric( vertical: 5),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 12)],
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.dmSans(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
