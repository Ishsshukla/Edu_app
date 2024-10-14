// ignore_for_file: sort_child_properties_last

import 'package:edu_app/components/button.dart';
import 'package:edu_app/students_screens/screens/home.dart';
import 'package:flutter/material.dart';

class Paysucesspage extends StatefulWidget {
  const Paysucesspage({super.key});

  @override
  State<Paysucesspage> createState() => _PaysucessState();
}

class _PaysucessState extends State<Paysucesspage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenHeight * 0.02, screenWidth * 0.05, 0),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.2),
                Image.asset(
                  'assets/pay.png',
                  scale: screenWidth * 0.01,
                ),
                SizedBox(height: screenHeight * 0.05),
                Image.asset(
                  'assets/tick.png',
                  scale: screenWidth * 0.015,
                ),
                SizedBox(height: screenHeight * 0.08),
                const Text(
                  'Congratulations !',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 1, 1),
                    letterSpacing: 1.0,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
                const Text(
                  ' You’ve Become a Member',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 1, 1),
                    letterSpacing: 1.0,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                SizedBox(
                  width: screenWidth,
                  child: CustomButton(
                    text: 'Back to Home',
                    color: const Color(0xFF4A90E2),
                    textColor: Colors.white,
                    function: () {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(builder: (context) => Homepage()),
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
