import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/students_screens/screens/crs_description.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/chapters.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/description_enrooled.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/enrollled_crs.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/components/coursesbuy.dart'; // Import your existing components

class CoursePageStudent extends StatefulWidget {
  const CoursePageStudent({super.key});

  @override
  State<CoursePageStudent> createState() => _CoursePageStudentState();
}

class _CoursePageStudentState extends State<CoursePageStudent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchCourses();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchCourses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('course_content').get();
      List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'img': 'assets/CoursePreview.png',
          'name': data.containsKey('courseName') ? data['courseName'] : 'Unknown Course',
          'description': data.containsKey('description') ? data['description'] : 'No description available',
        };
      }).toList();

      setState(() {
        chapters = fetchedCourses;
      });
    } catch (e) {
      // Handle error
    }
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
            Navigator.of(context).pop(); // Back navigation
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'All Courses'),
            Tab(text: 'My Courses'),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All Courses Tab
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Column(
                children: chapters.map((course) {
                  return crstxtforstudent(
                    course['img'] ?? 'assets/default.png', // Provide a default value if null
                    course['name'] ?? 'No Name', // Handle null course name
                    'coursedescr', // Your course description route
                    context,
                    screenWidth,
                    screenHeight,
                  );
                }).toList(),
              ),
            ),
          ),
          // My Courses Tab
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Column(
                children: chapters.map((chapter) {
                  return crstxtforstudentData(
                    chapter['img']!,
                    chapter['name']!,
                    context,
                    chapter,
                    screenWidth,
                    screenHeight,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget crstxtforstudent(
  String img,
  String text,
  String route,
  BuildContext context,
  double screenWidth,
  double screenHeight,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenHeight * 0.02, screenWidth * 0.05, screenHeight * 0.015),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
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
        padding: EdgeInsets.fromLTRB(screenWidth * 0.025, screenHeight * 0.01, screenWidth * 0.025, screenHeight * 0.007),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img, scale: screenWidth * 0.03),
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
                  SizedBox(height: screenHeight * 0.01),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDescriptionpage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.06),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
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

Widget crstxtforstudentData(
  String img,
  String text,
  BuildContext context,
  Map<String, dynamic> courseData,
  double screenWidth,
  double screenHeight,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenHeight * 0.02, screenWidth * 0.05, screenHeight * 0.015),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
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
        padding: EdgeInsets.fromLTRB(screenWidth * 0.025, screenHeight * 0.01, screenWidth * 0.025, screenHeight * 0.007),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img, scale: screenWidth * 0.03),
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
                  SizedBox(height: screenHeight * 0.01),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => enrolledcrspage(courseData: courseData),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.06),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
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
