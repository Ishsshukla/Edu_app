

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/teacher_side/screens/contenteditcourse.dart';

class ChapterPageTeacher extends StatefulWidget {
  final String courseName;
  final String docIdUser;

  const ChapterPageTeacher({
    super.key,
    required this.courseName,
    required this.docIdUser,
  });

  @override
  State<ChapterPageTeacher> createState() => _ChapterPageTeacherState();
}

class _ChapterPageTeacherState extends State<ChapterPageTeacher> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];
  bool isLoading = false; // For showing the loader

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  
  Future<void> fetchChapters() async {
    setState(() {
      isLoading = true; // Start loader while fetching data
    });

    try {
      // Access the 'chapters' subcollection of the specific course document using the docId
      QuerySnapshot snapshot = await _firestore
          .collection('course_content')
          .doc(widget.docIdUser) // Fetch the course by docId
          .collection('chapters') // Access the 'chapters' subcollection
          .get();

      // Map the fetched chapters
      List<Map<String, dynamic>> fetchedChapters = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return {
          'courseId':widget.docIdUser,
          'docId': doc.id, // The document ID of the chapter
          // 'chapterName': data['chapterName'] ?? 'Unknown Chapter',
          // 'content': data['content'] ?? 'No content available',
          'lessonName':
              data['lessonName'] ?? 'Unknown Lesson', // If you store lessonName
        };
      }).toList();

      setState(() {
        chapters = fetchedChapters; // Set the fetched chapters in the state
        isLoading = false; // Stop loader after fetching data
      });
    } catch (e) {
      print("Error fetching chapters: $e");
      setState(() {
        isLoading = false; // Stop loader in case of error
      });
    }
  }

 

  Future<void> _addChapter(String chapterName) async {
    setState(() {
      isLoading = true; // Start loader while adding chapter
    });

    try {
      // Access the specific course document and add the chapter to its 'chapters' subcollection
      await _firestore
          .collection('course_content')
          .doc(widget.docIdUser) // Referencing the course by its document ID
          .collection('chapters') // Access the 'chapters' subcollection
          .add({
        'lessonName': chapterName, // Chapter name to be added
        'timestamp': FieldValue.serverTimestamp(), // Add timestamp for order
      });

      // Refetch the chapters after adding the new one
      await fetchChapters();

      // Show success message after adding the chapter
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chapter added successfully!')),
      );
    } catch (e) {
      print("Error adding chapter: $e");
      // Show error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add chapter.')),
      );
    }

    setState(() {
      isLoading = false; // Stop loader after adding
    });
  }

  // Show a dialog to add a new chapter
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
                  _addChapter(newChapterName); // Add the chapter to Firestore
                  Navigator.pop(context); // Close the dialog
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Loader when loading
          : SingleChildScrollView(
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
                      : [const Center(child: Text('No Chapters Available'))],
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

// Widget to display each chapter
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
                          builder: (context) =>
                              EditCourseContentTeacher(courseData: courseData),
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
