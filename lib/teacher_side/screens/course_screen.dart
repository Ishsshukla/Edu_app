import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/coursesbuy.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:edu_app/students_screens/screens/navbar.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';

class coursepageTeacher extends StatefulWidget {
  @override
  State<coursepageTeacher> createState() => _optionpageTeacherState();
}

class _optionpageTeacherState extends State<coursepageTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavTeacher(initialIndex: 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            coursetxtforteacher('assets/CoursePreview.png', 'Sainik School',
                'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'Military School',
                'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'RMS School',
                'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'Sainik School',
                'editcourse', context),
            coursetxtforteacher('assets/CoursePreview.png', 'Military School',
                'editcourse', context),
          ],
        ),
      ),
    );
  }
}
