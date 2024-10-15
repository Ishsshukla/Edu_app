import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/content_chptr.dart';
import 'package:edu_app/teacher_side/screens/contenteditcourse.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
import 'package:flutter/material.dart';

class ChapterPageTeacher extends StatefulWidget {
  final String courseName;
  final String docId;

  const ChapterPageTeacher({super.key, required this.courseName, required this.docId});

  @override
  State<ChapterPageTeacher> createState() => _ChapterPageTeacherState();
}

class _ChapterPageTeacherState extends State<ChapterPageTeacher> {
  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];

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
          'docId': doc.id,
          'courseName': data.containsKey('courseName') ? data['courseName'] : 'Unknown Course',
          'img': 'assets/CoursePreview.png',
          'lessonName': data.containsKey('lessonName') ? data['lessonName'] : 'Unknown Lesson',
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

  void _addChapter(String chapterName) {
    setState(() {
      chapters.add({'img': 'assets/CoursePreview.png', 'name': chapterName});
    });
  }

  void _showAddChapterDialog() {
    String newChapterName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Add New Chapter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newChapterName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Chapter Name',
                  hintText: 'Enter the name of the chapter',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (newChapterName.isNotEmpty) {
                  _addChapter(newChapterName);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
                ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                    return crstxtforTeacherDataChapter(
                      chapter['img'] ?? 'assets/CoursePreview.png',
                      chapter['lessonName'] ?? 'Unnamed Chapter',
                      context,
                      chapter,
                      screenWidth,
                    );
                  }).toList()
                : [
                    const Center(child: CircularProgressIndicator())
                  ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddChapterDialog,
        label: const Text(
          'Add Chapter',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

Widget crstxtforTeacherDataChapter(
  String img,
  String text,
  BuildContext context,
  Map<String, dynamic> courseData,
  double screenWidth,
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
            Image.asset(img, scale: screenWidth < 600 ? 12 : 8),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 16 : 18,
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
                          builder: (context) => EditCourseContentTeacher(courseData: courseData),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: EdgeInsets.symmetric(
                        vertical: screenWidth < 600 ? 10 : 12,
                        horizontal: screenWidth < 600 ? 20 : 24,
                      ),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Edit Chapter',
                      style: TextStyle(
                        fontSize: screenWidth < 600 ? 14 : 16,
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
