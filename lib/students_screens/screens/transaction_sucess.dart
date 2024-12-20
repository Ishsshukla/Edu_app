// ignore_for_file: sort_child_properties_last

import 'package:edu_app/components/button.dart';
import 'package:edu_app/students_screens/screens/allcrs.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/enrollled_crs.dart';
import 'package:flutter/material.dart';

class transactionpage extends StatefulWidget {
  final String userIdDoc;
  const transactionpage({super.key,required this.userIdDoc});

  @override
  State<transactionpage> createState() => _transactionpageState();
}

class _transactionpageState extends State<transactionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Container(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 140),
                Image.asset(
                  'assets/pana.png',
                  scale: 5,
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/tick.png',
                  scale: 5,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Your Transaction Success',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 1, 1),
                    letterSpacing: 1.0,
                    fontSize: 23.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomButton(
                    text: 'Go to My Lesson',
                    color: const Color(0xFF4A90E2),
                    textColor: Colors.white,
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoursePageStudent(
                            docIdUser: widget.userIdDoc,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // const Divider(color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
