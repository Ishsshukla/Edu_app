import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';

class CrsPagestudent extends StatefulWidget {
  const CrsPagestudent({super.key});

  @override
  State<CrsPagestudent> createState() => _ChapterPageTeacherState();
}

class _ChapterPageTeacherState extends State<CrsPagestudent> {
  // Dynamic list to store the chapters
  List<Map<String, String>> chapters = [
    {'img': 'assets/CoursePreview.png', 'name': 'Introduction to Algebra'},
    {'img': 'assets/CoursePreview.png', 'name': 'Geometry Basics'},
    {'img': 'assets/CoursePreview.png', 'name': 'Trigonometry'},
     {'img': 'assets/CoursePreview.png', 'name': 'Trigonometry'},
  ];

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
            children: chapters.map((chapter) {
              return crstxtforstudent(
                chapter['img']!,
                chapter['name']!,
                'coursedescr', // Replace this with your actual edit route if needed
                context,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
