import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/class_option.dart';
import 'package:edu_app/components/coursesbuy.dart';
import 'package:edu_app/components/ellipse.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/screens/navbar.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class editcoursecontentTeacher extends StatefulWidget {
  @override
  State<editcoursecontentTeacher> createState() => _optionpageTeacherState();
}

class _optionpageTeacherState extends State<editcoursecontentTeacher> {
  // Controller to store the YouTube link
  final TextEditingController _youtubeLinkController = TextEditingController();

  // Function to open the YouTube link
  Future<void> _launchYoutubeLink() async {
    final url = _youtubeLinkController.text;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error if the URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid YouTube URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavTeacher(initialIndex: 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            txt('Class/Course Name', context),
            editabletxtforteacher('Write Class/Course Name', context),
            txt('Lesson Name', context),
            editabletxtforteacher('Write Lesson Name', context),
            txt('Link of the Class', context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _youtubeLinkController, // Controller for YouTube link
                decoration: InputDecoration(
                  hintText: 'Paste YouTube Video Link',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.play_circle_fill),
                    onPressed: _launchYoutubeLink, // Open YouTube link on tap
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
