import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/coursesbuy.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:flutter/material.dart';

class coursepage extends StatefulWidget {
  @override
  State<coursepage> createState() => _optionpageState();
}

class _optionpageState extends State<coursepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            coursetxt('assets/CoursePreview.png', 'Sainik School', context),
            coursetxt('assets/CoursePreview.png', 'Military School', context),
            coursetxt('assets/CoursePreview.png', 'RMS School', context),
            coursetxt('assets/CoursePreview.png', 'Sainik School', context),
            coursetxt('assets/CoursePreview.png', 'Military School', context),
          ],
        ),
      ),
    );
  }
}
