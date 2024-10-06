import 'package:flutter/material.dart';
import 'package:edu_app/components/coursesbuy.dart'; // Import your existing components

class CoursePageStudent extends StatefulWidget {
  const CoursePageStudent({Key? key}) : super(key: key);

  @override
  State<CoursePageStudent> createState() => _CoursePageStudentState();
}

class _CoursePageStudentState extends State<CoursePageStudent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for All Courses and My Courses
  List<Map<String, String>> allCourses = [
    {'img': 'assets/CoursePreview.png', 'name': 'Introduction to Algebra'},
    {'img': 'assets/CoursePreview.png', 'name': 'Geometry Basics'},
    {'img': 'assets/CoursePreview.png', 'name': 'Trigonometry'},
    {'img': 'assets/CoursePreview.png', 'name': 'Calculus'},
  ];

  List<Map<String, String>> myCourses = [
    {'img': 'assets/CoursePreview.png', 'name': 'Introduction to Algebra'},
    {'img': 'assets/CoursePreview.png', 'name': 'Trigonometry'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: allCourses.map((course) {
                  return crstxtforstudent(
                    course['img']!,
                    course['name']!,
                    'coursedescr', // Your course description route
                    context,
                  );
                }).toList(),
              ),
            ),
          ),
          // My Courses Tab
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: myCourses.map((course) {
                  return crstxtforstudent(
                    course['img']!,
                    course['name']!,
                    'coursedescr', // Your course description route
                    context,
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
