import 'package:edu_app/components/coursesbuy.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';

class CoursePageTeacher extends StatefulWidget {
  const CoursePageTeacher({super.key});

  @override
  State<CoursePageTeacher> createState() => _CoursePageTeacherState();
}

class _CoursePageTeacherState extends State<CoursePageTeacher> {
  // Dynamic list to store the courses
  List<Map<String, String>> courses = [
    {'img': 'assets/CoursePreview.png', 'name': 'Sainik School'},
    {'img': 'assets/CoursePreview.png', 'name': 'Military School'},
    {'img': 'assets/CoursePreview.png', 'name': 'RMS School'},
  ];

  // Function to add a new course
  void _addCourse(String courseName) {
    setState(() {
      courses.add({'img': 'assets/CoursePreview.png', 'name': courseName});
    });
  }

  // Function to show a dialog for entering course name
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
                Navigator.pop(context); // Close the dialog without saving
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newCourseName.isNotEmpty) {
                  _addCourse(newCourseName);
                  Navigator.pop(context); // Close the dialog after saving
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
      bottomNavigationBar: const NavTeacher(initialIndex: 1), // Bottom Navigation
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20), // Padding at the top and bottom
          child: Column(
            children: courses.map((course) {
              return coursetxtforteacher(
                course['img']!,
                course['name']!,
                'editcourse', // Replace this with your actual edit route if needed
                context,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog(); // Show dialog to enter course name
        },
        backgroundColor: const Color(0xFF4A90E2), // Custom button color
        child: const Icon(Icons.add, color: Colors.white), // Plus icon with white color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Bottom right for FAB
    );
  }
}
