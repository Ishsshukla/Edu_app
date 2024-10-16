import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/content_chptr.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
import 'package:flutter/material.dart';

class ChapterPageStudent extends StatefulWidget {
  final String courseId;

  const ChapterPageStudent({super.key, required this.courseId});

  @override
  State<ChapterPageStudent> createState() => _ChapterPageStudentState();
}

class _ChapterPageStudentState extends State<ChapterPageStudent> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }


  Future<void> fetchChapters() async {
    try {
      String courseDocId =
          widget.courseId; // Get the course document ID from the previous page

      // Fetch the 'chapters' subcollection of the specific course using courseDocId
      QuerySnapshot snapshot = await _firestore
          .collection('course_content')
          .doc(courseDocId)
          .collection('chapters') // Fetch from 'chapters' subcollection
          .get();

      List<Map<String, dynamic>> fetchedChapters = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data);

        return {
          'courseId': widget.courseId,
          'chapterId': doc.id, // Add chapter document ID for reference
          'lessonName': data.containsKey('lessonName')
              ? data['lessonName']
              : 'Unknown Lesson',
          // 'pdfUrls': data.containsKey('pdfUrls')
          //     ? List<String>.from(data['pdfUrls'])
          //     : [],
          // 'imageUrls': data.containsKey('imageUrls')
          //     ? List<String>.from(data['imageUrls'])
          //     : [],
          // 'notes': data.containsKey('notes') ? data['notes'] : 'No Notes',
        };
      }).toList();

      setState(() {
        chapters = fetchedChapters; // Set the fetched chapters
        print("Chapters fetched successfully: $chapters");
      });
    } catch (e) {
      print("Error fetching chapters: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: Column(
            children: chapters.isNotEmpty
                ? chapters.map<Widget>((chapter) {
                    return crstxtforstudentDataChapter(
                      chapter['img'] ?? 'assets/CoursePreview.png',
                      chapter['lessonName'] ?? 'Unnamed Chapter',
                      context,
                      chapter,
                      screenWidth,
                    );
                  }).toList()
                : [const Center(child: CircularProgressIndicator())],
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
  double screenWidth,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      screenWidth * 0.05,
      screenWidth * 0.05,
      screenWidth * 0.05,
      screenWidth * 0.03,
    ),
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
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.03,
          screenWidth * 0.03,
          screenWidth * 0.03,
          screenWidth * 0.02,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img, scale: screenWidth * 0.03),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewChapterStudent(courseData: courseData),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.03,
                        horizontal: screenWidth * 0.06,
                      ),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View Chapter',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white,
                      ),
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
