import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/content_chptr.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
import 'package:flutter/material.dart';

class ChapterPageStudent extends StatefulWidget {
  final String courseName;

  const ChapterPageStudent({super.key, required this.courseName});

  @override
  State<ChapterPageStudent> createState() => _ChapterPageStudentState();
}

class _ChapterPageStudentState extends State<ChapterPageStudent> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      String selectedCourseName = widget.courseName;

      QuerySnapshot snapshot = await _firestore
          .collection('course_content')
          .where('courseName', isEqualTo: selectedCourseName)
          .get();

      List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data);

        return {
          'courseName': data.containsKey('courseName')
              ? data['courseName']
              : 'Unknown Course',
          'img': 'assets/CoursePreview.png',
          'lessonName': data.containsKey('lessonName')
              ? data['lessonName']
              : 'Unknown Lesson',
        };
      }).toList();

      setState(() {
        chapters = fetchedCourses;
        print("Courses fetched successfully = $chapters");
      });
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chapters",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: chapters.isNotEmpty
                ? chapters.map<Widget>((chapter) {
                    return crstxtforstudentDataChapter(
                      chapter['img'] ?? 'assets/CoursePreview.png',
                      chapter['lessonName'] ?? 'Unnamed Chapter',
                      context,
                      chapter,
                    );
                  }).toList()
                : [
                    const Center(child: CircularProgressIndicator())
                  ],
          ),
        ),
      ),
    );
  }
}

Widget crstxtforstudentDataChapter(
  String img,
  String text,
  BuildContext context,
  Map<String, dynamic> courseData,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img, scale: 12),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewChapterStudent(courseData: courseData,),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Chapter',
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
