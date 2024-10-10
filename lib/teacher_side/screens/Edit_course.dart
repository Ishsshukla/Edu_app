import 'package:edu_app/components/const.dart';
import 'package:edu_app/teacher_side/screens/chapter_screen.dart';
import 'package:edu_app/teacher_side/screens/contenteditcourse.dart';
import 'package:flutter/material.dart';

class EditCourseDescriptionpage extends StatefulWidget {
  const EditCourseDescriptionpage({super.key});

  @override
  State<EditCourseDescriptionpage> createState() =>
      _EditCourseDescriptionpageState();
}

class _EditCourseDescriptionpageState extends State<EditCourseDescriptionpage> {
  final FocusNode _courseInfoFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  void _editCourse() {
    // Navigate to the next page for editing
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  const ChapterPageTeacher(),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the focus nodes to prevent memory leaks
    _courseInfoFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,  // This ensures the layout resizes when the keyboard shows up
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Unfocus all FocusNodes when tapping outside of the text fields
            _courseInfoFocusNode.unfocus();
            _descriptionFocusNode.unfocus();
          },
          child: SingleChildScrollView(  // This allows the screen to scroll when the keyboard appears
            child: Column(
              children: [
                // Image Section
                SizedBox(
                  width: screenWidth,
                  child: Image.asset(
                    'assets/CoursePreview.png',
                    fit: BoxFit.cover,
                    height: screenHeight * 0.4, // Adjusted height
                  ),
                ),

                // Container for Course Info and Description with Transform
                Transform.translate(
                  offset: Offset(0, -screenHeight * 0.04), // Keeps the original transform
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28.0, 40, 28, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Course Info',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            focusNode: _courseInfoFocusNode,
                            decoration: InputDecoration(
                              hintText: 'Write here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.all(10), // Adjusted content padding
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Course Description
                          const Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            focusNode: _descriptionFocusNode,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: 'Write the course description here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.all(10), // Adjusted content padding
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Information Section
                          const Text(
                            'Information',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          // Row for time and rating
                          const Row(
                            children: [
                              Icon(
                                Icons.timelapse,
                                size: 30,
                                color: Color(0xFF4A90E2),
                              ),
                              SizedBox(width: 8),
                              Text('1h 35m',
                                  style: TextStyle(fontSize: 16)),
                              Spacer(),
                              Icon(
                                Icons.star,
                                size: 30,
                                color: Color(0xFF4A90E2),
                              ),
                              SizedBox(width: 8),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 42, 0),
                                child: Text(
                                  '4.5 Star',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Row for notes and reviews
                          const Row(
                            children: [
                              Icon(
                                Icons.book,
                                size: 30,
                                color: Color(0xFF4A90E2),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Notes',
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Icon(
                                Icons.message,
                                size: 30,
                                color: Color(0xFF4A90E2),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '350 Reviews',
                                style: TextStyle(fontSize: 16),
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
      
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            onPressed: _editCourse,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0), // Increased vertical padding
            ),
            child: const Text(
              'Edit Course',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
