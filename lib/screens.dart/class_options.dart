import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:flutter/material.dart';

class optionpage extends StatefulWidget {
  @override
  State<optionpage> createState() => _optionpageState();
}

class _optionpageState extends State<optionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //     // title:
      //     // mainAxisSize: MainAxisSize.min,
      //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     //
      //     ),
      body: SafeArea(
        child: Column(
          children: [
            // SemiCirclePainter(),
            crcl('select the class you want ', context),
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
