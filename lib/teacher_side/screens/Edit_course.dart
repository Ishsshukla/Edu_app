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

class EditCourseDescriptionpage extends StatefulWidget {
  @override
  State<EditCourseDescriptionpage> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<EditCourseDescriptionpage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Section
              Container(
                width: screenWidth,
                child: Image.asset(
                  'assets/CoursePreview.png',
                  fit: BoxFit.cover,
                  height: screenHeight * 0.4, // Adjust height as needed
                ),
              ),
              // Transform the next container to move it upwards, creating the overlap
              Transform.translate(
                offset: Offset(
                    0,
                    -screenHeight *
                        0.07), // Moves it up by 5% of the screen height
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: editabletxtforteacher('write here', context),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: txt('Description', context),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: editabletxtforteacher(
                              'write here the description of the course',
                              context),
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
                            Container(
                              width: screenWidth * 0.2,
                              child: TextField(
                                controller:
                                    TextEditingController(text: '1h 35m'),
                                style: TextStyle(color: txtColor, fontSize: 15),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * .16,
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
                        const Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
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
                            ' Save & Continue',
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: txtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
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
