// ignore_for_file: use_key_in_widget_constructors

import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/profie_text_edit.dart';
import 'package:edu_app/screens/navbar.dart';
import 'package:flutter/material.dart';

class Prflpage extends StatefulWidget {
  @override
  State<Prflpage> createState() => _PrflpageState();
}

class _PrflpageState extends State<Prflpage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100.0, 10, 0, 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Image.asset(
                          'assets/profile.png',
                          scale: 4.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ishii',
                          style: TextStyle(
                            color: Color.fromARGB(255, 17, 1, 1),
                            letterSpacing: 1.0,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppins',
                          ),
                        ),
                        const Text(
                          '@ishi2048',
                          style: TextStyle(
                            color: Color.fromARGB(255, 17, 1, 1),
                            letterSpacing: 1.0,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: Column(
                      children: [
                        prflTxtEdit(
                            Icons.near_me_rounded, 'Name', 'ishiiii', context),
                        const SizedBox(
                          height: 0,
                        ),
                        prflTxtEdit(
                            Icons.email, 'Email', 'ishu30@gmail', context),
                        const SizedBox(
                          height: 0,
                        ),
                        prflTxtEdit(Icons.lock_open_outlined, 'Password',
                            '52535454436', context),
                        const SizedBox(
                          height: 0,
                        ),
                        prflTxtEdit(Icons.phone_android, 'Phone Number',
                            'Tap to change ', context),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              CustomButton(
                  text: 'Log Out',
                  color: Colors.blue.shade700,
                  textColor: Colors.white,
                  function: () {})
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Nav(),
    );
  }
}

