// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, sort_child_properties_last

import 'package:edu_app/components/review_componemt.dart';
import 'package:flutter/material.dart';

class CourseDescriptionpage extends StatefulWidget {
  @override
  State<CourseDescriptionpage> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescriptionpage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0, 8.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
              child: Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/CoursePreview.png',
                      scale: 5,
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [txt('Sainik School Course', context)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


