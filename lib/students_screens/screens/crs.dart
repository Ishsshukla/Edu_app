import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/coursesbuy.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:edu_app/students_screens/screens/navbar.dart';
import 'package:flutter/material.dart';

class coursepage extends StatefulWidget {
  const coursepage({super.key});

  @override
  State<coursepage> createState() => _optionpageState();
}

class _optionpageState extends State<coursepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Nav(initialIndex: 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            coursetxt('assets/CoursePreview.png', 'Sainik School',
                'coursedescr', context),
            coursetxt('assets/CoursePreview.png', 'Military School',
                'coursedescr', context),
            coursetxt('assets/CoursePreview.png', 'RMS School', 'coursedescr',
                context),
            coursetxt('assets/CoursePreview.png', 'Sainik School',
                'coursedescr', context),
            coursetxt('assets/CoursePreview.png', 'Military School',
                'coursedescr', context),
          ],
        ),
      ),
    );
  }
}
