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
  List<Map<String, dynamic>> chapters = [
  ];
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
      // print("Courses fetched successfully=${chapters}");
    } 
    catch (e) {
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
      // bottomNavigationBar: NavTeacher(initialIndex: 1), // Bottom Navigation
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20), // Padding at the top and bottom
          child: Column(
            children: 
            chapters.map((chapter) {
              return crstxtforstudentData(
                chapter['img']!,
                chapter['name']!,
                context,
                chapter,
              
              );
            }).toList()
            // : const Center(child: CircularProgressIndicator()),
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
  Map<String, dynamic> courseData, // Passing the course data to the widget
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15), // Consistent padding
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 7), // Padding inside the container for a clean layout
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
          children: [
            // Image Section
            Image.asset(img, scale: 12),
            const SizedBox(width: 15), // Space between image and text

            // Text and Button Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18, // Larger font for course title
                      color: Colors.black,
                      fontWeight: FontWeight.w500, // Medium weight for emphasis
                    ),
                  ),
                  const SizedBox(height: 10),
                   ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => enrolledcrspage( courseData: courseData), // Passing courseData
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: const Color(0xFF4A90E2), // Custom button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                    child: const Text(
                      'View Course',
                      style: TextStyle(fontSize: 16, color: Colors.white), // White text color
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