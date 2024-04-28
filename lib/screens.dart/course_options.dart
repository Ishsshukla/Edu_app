import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:flutter/material.dart';

class courseoptionpage extends StatefulWidget {
  @override
  State<courseoptionpage> createState() => _optionpageState();
}

class _optionpageState extends State<courseoptionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // SemiCirclePainter(),
            crcl('Choose your Exam here ', context),
            SizedBox(height: 40, width: double.infinity),

            clstxt('Elementary School', context),
            clstxt('Junior High School', context),
            clstxt('Senior High School', context),
            clstxt('Junior High School', context),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              text: 'Next',
              color: Colors.blue,
              textColor: Colors.white,
              function: () {
                Navigator.pushNamed(context, 'homepage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
