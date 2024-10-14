// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, sort_child_properties_last

import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/screens/review.dart';
import 'package:flutter/material.dart';

class CourseDescriptionpage extends StatefulWidget {
  final String docIdUser;
  // final Map<String, dynamic> courseData; // Data for the selected course

  const CourseDescriptionpage({super.key, required this.docIdUser});
  @override
  State<CourseDescriptionpage> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescriptionpage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //  String courseName = widget.courseData['name'] ?? 'Course Name Not Available';
    // String courseDescription = widget.courseData['description'] ?? 'Description not available'; // Modify as per your data structure
    // String courseImage = widget.courseData['img'] ?? 'assets/CoursePreview.png';
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("courseName"),
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
                          child: Text(
                            "courseDescription",
                          ),
                        ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     'this is a description of the course',
                        //   ),
                        // ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: txt('Information', context),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timelapse,
                              size: 40,
                              color: Color(0xFF4A90E2),
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            const Text(
                              '1h 35m',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            SizedBox(
                              width: screenWidth * .2,
                            ),
                            const Icon(
                              Icons.star,
                              size: 40,
                              color: Color(0xFF4A90E2),
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            const Text(
                              '4.5  Star',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.008,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.book,
                              size: 40,
                              color: Color(0xFF4A90E2),
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            const Text(
                              'Notes',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            SizedBox(
                              width: screenWidth * .239,
                            ),
                            const Icon(
                              Icons.message,
                              size: 39,
                              color: Color(0xFF4A90E2),
                            ),
                            SizedBox(
                              width: screenWidth * .0099,
                            ),
                            const Text(
                              '350 Reviews',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.07,
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
                                    builder: (context) => Reviewpage(docIdUser: widget.docIdUser,),
                                  ),
                                );
                              },
                              child: const Text(
                                ' Continue ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A90E2),
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
                            SizedBox(height: 70),
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
