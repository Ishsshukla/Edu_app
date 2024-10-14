import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
import 'package:edu_app/students_screens/screens/crs_description.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/enrollled_crs.dart';
// import 'package:edu_app/students_screens/screens/enrolled_course/enrollled_crs.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrsPagestudent extends StatefulWidget {
  const CrsPagestudent({super.key});

  @override
  State<CrsPagestudent> createState() => _ChapterPageTeacherState();
}

class _ChapterPageTeacherState extends State<CrsPagestudent> {
  // Dynamic list to store the chapters
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];

  // Fetch courses from Firestore
  Future<void> fetchCourses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('course_content').get();
      List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data);
        return {
          'img': 'assets/CoursePreview.png',
          'name': data.containsKey('courseName') ? data['courseName'] : 'Unknown Course',
          'description': data.containsKey('description') ? data['description'] : 'No description available',
        };
      }).toList();

      setState(() {
        chapters = fetchedCourses;
        print("Courses fetched successfully=${chapters}");
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses",
          style: TextStyle(color: Colors.black), // Change color if needed
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow
          onPressed: () {
            Navigator.of(context).pop(); // Back navigation
          },
        ),
        backgroundColor: Colors.white, // Change background color if needed
        elevation: 0, // Remove shadow if not needed
      ),
      backgroundColor: const Color(0xFFF5F5F5), // Light background to make cards pop
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05), // Responsive padding
          child: Column(
            children: chapters.map((chapter) {
              return crstxtforstudentData(
                chapter['img']!,
                chapter['name']!,
                context,
                chapter,
                screenWidth,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

Widget crstxtforstudentData(
  String img,
  String text,
  BuildContext context,
  Map<String, dynamic> courseData,
  double screenWidth, // Pass screen width for responsive design
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenWidth * 0.05, screenWidth * 0.05, screenWidth * 0.03), // Responsive padding
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Increased border radius for a smoother look
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Softer shadow for a modern look
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // Adds more depth
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(screenWidth * 0.03, screenWidth * 0.03, screenWidth * 0.03, screenWidth * 0.02), // Responsive padding inside the container
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
          children: [
            // Image Section
            Image.asset(img, scale: screenWidth * 0.03),
            SizedBox(width: screenWidth * 0.04), // Responsive space between image and text

            // Text and Button Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // Responsive font size
                      color: Colors.black,
                      fontWeight: FontWeight.w500, // Medium weight for emphasis
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.03), // Responsive space between text and button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => enrolledcrspage(courseData: courseData), // Passing courseData
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.06), // Responsive padding
                      backgroundColor: const Color(0xFF4A90E2), // Custom button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                    child: Text(
                      'View Course',
                      style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white), // Responsive text size
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
