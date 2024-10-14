import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/coursesbuy.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:edu_app/teacher_side/screens/Edit_course.dart';
import 'package:flutter/material.dart';

class CoursePageTeacher extends StatefulWidget {
  final String docidUser;
  const CoursePageTeacher({super.key, required this.docidUser});

  @override
  State<CoursePageTeacher> createState() => _CoursePageTeacherState();
}

class _CoursePageTeacherState extends State<CoursePageTeacher> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> courses = [];

  Future<void> fetchCourses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('course_content').get();
      List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'docId': doc.id,
          'img': 'assets/CoursePreview.png',
          'name': data.containsKey('courseName') ? data['courseName'] : 'Unknown Course',
          'description': data.containsKey('description') ? data['description'] : 'No description available',
        };
      }).toList();

      setState(() {
        courses = fetchedCourses;
        print("Courses fetched successfully: $courses");
      });
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  void _addCourse(String courseName) {
    setState(() {
      courses.add({'img': 'assets/CoursePreview.png', 'name': courseName});
    });
  }

  void _showAddCourseDialog() {
    String newCourseName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Course'),
          content: TextField(
            onChanged: (value) {
              newCourseName = value;
            },
            decoration: const InputDecoration(
              labelText: 'Course Name',
              hintText: 'Enter the name of the course',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newCourseName.isNotEmpty) {
                  _addCourse(newCourseName);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: NavTeacher(initialIndex: 1, docidUser: widget.docidUser),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: Column(
            children: courses.map((course) {
              return crstxtforTeacherData(
                course['img']!,
                course['name']!,
                context,
                course,
                screenWidth,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog();
        },
        backgroundColor: const Color(0xFF4A90E2),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

Widget crstxtforTeacherData(
  String img,
  String text,
  BuildContext context,
  Map<String, dynamic> courseData,
  double screenWidth,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenWidth * 0.05, screenWidth * 0.05, screenWidth * 0.04),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(screenWidth * 0.03, screenWidth * 0.03, screenWidth * 0.03, screenWidth * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img, scale: 12),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.025),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCourseDescriptionpage(courseData: courseData),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.06),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View Course',
                      style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
