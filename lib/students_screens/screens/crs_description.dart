// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, sort_child_properties_last

import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/components/profie_text_edit.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/screens/navbar.dart';
import 'package:edu_app/students_screens/screens/payment_method.dart';
import 'package:edu_app/students_screens/screens/review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CourseDescriptionpage extends StatefulWidget {
  @override
  State<CourseDescriptionpage> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescriptionpage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: screenWidth * 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(30),
                    //   bottomRight: Radius.circular(30),
                    // ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/CoursePreview.png',
                        scale: 5,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.33,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28.0, 0, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: txt('Course Info', context),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Sainik School'),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: txt('Description', context),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'this is a description of the course',
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'this is a description of the course',
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: txt('Information', context),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timelapse,
                              size: 40,
                              color: txtColor,
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            Text(
                              '1h 35m',
                              style: TextStyle(color: txtColor, fontSize: 17),
                            ),
                            SizedBox(
                              width: screenWidth * .2,
                            ),
                            Icon(
                              Icons.star,
                              size: 40,
                              color: txtColor,
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            Text(
                              '4.5  Star',
                              style: TextStyle(color: txtColor, fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.008,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.book,
                              size: 40,
                              color: txtColor,
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            Text(
                              'Notes',
                              style: TextStyle(color: txtColor, fontSize: 17),
                            ),
                            SizedBox(
                              width: screenWidth * .239,
                            ),
                            Icon(
                              Icons.message,
                              size: 40,
                              color: txtColor,
                            ),
                            // SizedBox(
                            //   width: screenWidth * .007s,
                            // ),
                            Text(
                              '350 Reviews',
                              style: TextStyle(color: txtColor, fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          children: [
                            // Total price text
                            const Column(
                              children: [
                                Text(
                                  'Total Price :  ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '  RS 12000 only',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),

                            // Continue button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Reviewpage(),
                                  ),
                                );
                              },
                              child: const Text(
                                ' Continue ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: txtColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                        const Row(
                          children: [
                            SizedBox(height: 50),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
