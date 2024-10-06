import 'package:edu_app/teacher_side/screens/contenteditcourse.dart';
import 'package:flutter/material.dart';

// Assume that you have an EditCourseDetailsPage defined
// import 'edit_course_details_page.dart';

class EditCourseDescriptionpage extends StatefulWidget {
  @override
  State<EditCourseDescriptionpage> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<EditCourseDescriptionpage> {
  void _editCourse() {
    // Navigate to the next page for editing
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditCourseContentTeacher(), // Ensure this page is defined
      ),
    );
  }

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
                        0.07), // Moves it up by 7% of the screen height
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
                          child: Text('Course Info'),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'write here',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Description'),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  'write here the description of the course',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Information'),
                        ),
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timelapse,
                              size: 40,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            Container(
                              width: screenWidth * 0.2,
                              child: TextField(
                                controller:
                                    TextEditingController(text: '1h 35m'),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
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
                              color: Colors.blue.shade600,
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            Text(
                              '4.5 Star',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
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
                              color: Colors.blue.shade600,
                            ),
                            SizedBox(
                              width: screenWidth * .018,
                            ),
                            Text(
                              'Notes',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            SizedBox(
                              width: screenWidth * .239,
                            ),
                            Icon(
                              Icons.message,
                              size: 40,
                              color: Colors.blue.shade600,
                            ),
                            Text(
                              '350 Reviews',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
        child: ElevatedButton(
          onPressed: _editCourse, // Call edit function
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Color(0xFF4A90E2), // Use the color from your image
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Edit Course',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
