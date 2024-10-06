import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/coursesbuy.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:edu_app/students_screens/screens/navbar.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';

class CoursePageTeacher extends StatefulWidget {
  @override
  State<CoursePageTeacher> createState() => _OptionPageTeacherState();
}

class _OptionPageTeacherState extends State<CoursePageTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavTeacher(initialIndex: 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            coursetxtforteacher('assets/CoursePreview.png', 'Sainik School', 'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'Military School', 'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'RMS School', 'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'Sainik School', 'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'Military School', 'editcourse', context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define what happens when the button is pressed
          // For example, navigate to the Add Course screen
          Navigator.pushNamed(context, '/addCourse'); // Adjust the route name as needed
        },
        backgroundColor: Color(0xFF4A90E2), // Set the color using the provided hex code
        child: Icon(Icons.add), // Use the plus icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position the FAB at the bottom right
    );
  }
}
