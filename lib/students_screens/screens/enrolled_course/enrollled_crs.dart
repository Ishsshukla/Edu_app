import 'package:edu_app/students_screens/screens/enrolled_course/chapters.dart';
import 'package:flutter/material.dart';

// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, sort_child_properties_last

import 'package:edu_app/components/const.dart';

class enrolledcrspage extends StatefulWidget {
  @override
  State<enrolledcrspage> createState() => _enrolledcrsState();
}

class _enrolledcrsState extends State<enrolledcrspage> {
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
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Course Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sainik School',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.029,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'this is a description of the course',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'this is a description of the course',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.029,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timelapse,
                              size: 28,
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
                              size: 30,
                              color: txtColor,
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            Text(
                              ' 4.5  Star',
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
                              size: 30,
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
                              size: 25,
                              color: txtColor,
                            ),
                            // SizedBox(
                            //   width: screenWidth * .007s,
                            // ),
                            Text(
                              '  350 Reviews',
                              style: TextStyle(color: txtColor, fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.055,
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 0),
                          child: Row(
                            children: [
                              // Total price text

                              // Continue button
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChapterPageStudent(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Start Course',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: txtColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize:const  Size(280,
                                        50), // Increase the width of the button
                                  ),
                                ),
                              ),
                              const SizedBox(height: 80),
                            ],
                          ),
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
