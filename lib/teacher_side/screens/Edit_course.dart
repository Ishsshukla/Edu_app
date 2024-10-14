import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/const.dart';
import 'package:edu_app/teacher_side/screens/chapter_screen.dart';
import 'package:edu_app/teacher_side/screens/contenteditcourse.dart';
import 'package:flutter/material.dart';

const Color blueColor = Color(0xFF4A90E2);

class EditCourseDescriptionpage extends StatefulWidget {
  final Map<String, dynamic> courseData; // Data for the selected course

  const EditCourseDescriptionpage({super.key, required this.courseData});

  @override
  State<EditCourseDescriptionpage> createState() =>
      _EditCourseDescriptionpageState();
}

class _EditCourseDescriptionpageState extends State<EditCourseDescriptionpage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FocusNode _courseInfoFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  late TextEditingController _descriptionController;
  late TextEditingController _courseInfoController;
  final String courseName = 'Course Name Not Available';
  bool _isEditable = false; // Initially, the field is not editable

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.courseData['description']);
    _courseInfoController =
        TextEditingController(text: widget.courseData['name']);
  }

  // Function to toggle between editable and non-editable mode
  void _toggleEditSave() async {
    if (_isEditable) {
      // Save the changes when toggling to non-editable mode
      await _firestore
          .collection('course_content')
          .doc(widget.courseData['docId'])
          .update({
        'description': _descriptionController.text,
        'courseName': _courseInfoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Description updated successfully!')));
    }

    // Toggle the editable state
    setState(() {
      _isEditable = !_isEditable;
    });
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
    String docId = widget.courseData['docId']; // Store the document ID
    String courseName =
        widget.courseData['name'] ?? 'Course Name Not Available';
    String courseDescription = widget.courseData['description'] ??
        'Description not available'; // Modify as per your data structure
    String courseImage = widget.courseData['img'] ?? 'assets/CoursePreview.png';
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // This ensures the layout resizes when the keyboard shows up
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Unfocus all FocusNodes when tapping outside of the text fields
            _courseInfoFocusNode.unfocus();
            _descriptionFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            // This allows the screen to scroll when the keyboard appears
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
                  offset: Offset(
                      0, -screenHeight * 0.04), // Keeps the original transform
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.07, screenHeight * 0.05, screenWidth * 0.07, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Course Info',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.topRight,
                                child: ElevatedButton.icon(
                                  onPressed: _toggleEditSave,
                                  icon: Icon(
                                      _isEditable ? Icons.save : Icons.edit),
                                  label: Text(_isEditable ? 'Save' : 'Edit'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _courseInfoController,
                            maxLines: 1,
                            enabled:
                                _isEditable, // Control whether the text field is editable or not
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              label: Text(
                                'Course Name',
                                style: TextStyle(color: Colors.black),
                              ),
                              hintText: 'Write here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.all(screenWidth * 0.025), // Adjusted content padding
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 2,
                            enabled: _isEditable,
                            style: TextStyle(
                                color: Colors
                                    .black), // Control whether the text field is editable or not
                            decoration: InputDecoration(
                              label: Text(
                                'Course Description',
                                style: TextStyle(color: Colors.black),
                              ),
                              hintText: 'Write the course description here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.all(screenWidth * 0.025),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Information Section
                          const Text(
                            'Information',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                            SizedBox(height: screenHeight * 0.015),

                          // Row for time and rating
                            Row(
                            children: [
                              Icon(
                              Icons.timelapse,
                              size: screenWidth * 0.08, // Adjusted size
                              color: blueColor,
                              ),
                              SizedBox(width: screenWidth * 0.02), // Adjusted spacing
                              Text(
                              '1h 35m',
                              style: TextStyle(fontSize: screenWidth * 0.04), // Adjusted font size
                              ),
                              Spacer(),
                              Icon(
                              Icons.star,
                              size: screenWidth * 0.08, // Adjusted size
                              color: blueColor,
                              ),
                              SizedBox(width: screenWidth * 0.02), // Adjusted spacing
                              Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.1, 0), // Adjusted padding
                              child: Text(
                                '4.5 Star',
                                style: TextStyle(fontSize: screenWidth * 0.04), // Adjusted font size
                              ),
                              ),
                            ],
                            ),
                            const SizedBox(height: 16),

                            // Row for notes and reviews
                            Row(
                            children: [
                              Icon(
                              Icons.book,
                              size: screenWidth * 0.08, // Adjusted size
                              color: blueColor,
                              ),
                              SizedBox(width: screenWidth * 0.02), // Adjusted spacing
                              Text(
                              'Notes',
                              style: TextStyle(fontSize: screenWidth * 0.04), // Adjusted font size
                              ),
                              Spacer(),
                              Icon(
                              Icons.message,
                              size: screenWidth * 0.08, // Adjusted size
                              color: blueColor,
                              ),
                              SizedBox(width: screenWidth * 0.02), // Adjusted spacing
                              Text(
                              '350 Reviews',
                              style: TextStyle(fontSize: screenWidth * 0.04), // Adjusted font size
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
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterPageTeacher(
                        courseName: courseName, docId: docId),
                  ),
                );
              },
              child: const Text(
                'Edit Course',
                style: TextStyle(
                    color: Colors.white, fontSize: 26), // Increased font size
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A90E2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(screenWidth * 0.9, screenHeight * 0.08), // Adjusted button size
              ),
            ),
          ),
        ),
      ),
    );
  }
}
