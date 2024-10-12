
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/content_chptr.dart';
import 'package:edu_app/teacher_side/screens/contenteditcourse.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
import 'package:flutter/material.dart';

class ChapterPageTeacher extends StatefulWidget {
  // final Map<String, dynamic> courseData; // Data for the selected course
  final String courseName;
  final String docId;

  const ChapterPageTeacher({super.key, required this.courseName, required this.docId});

  @override
  State<ChapterPageTeacher> createState() => _ChapterPageTeacherState();
}

class _ChapterPageTeacherState extends State<ChapterPageTeacher> {
  // Dynamic list to store the chapters fetched from Firestore

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }
 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];
  // Fetch courses from Firestore

  Future<void> fetchCourses() async {
    try {
      // Assuming widget.courseData['courseName'] contains the course name passed from the previous page
      String selectedCourseName = widget.courseName;

      // Query the Firestore collection to get documents where 'courseName' equals the selectedCourseName
      QuerySnapshot snapshot = await _firestore
          .collection('course_content')
          .where('courseName', isEqualTo: selectedCourseName)
          .get();

      List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data);

        return {
          'docId': doc.id, // Store the document ID
          'courseName': data.containsKey('courseName')
              ? data['courseName']
              : 'Unknown Course',
          'img': 'assets/CoursePreview.png',
          'lessonName': data.containsKey('lessonName')
              ? data['lessonName']
              : 'Unknown Lesson',
          // Other fields if needed
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

  // Function to add a new chapter (in local state)
  void _addChapter(String chapterName) {
    setState(() {
      chapters.add({'img': 'assets/CoursePreview.png', 'name': chapterName});
    });
  }

  // Function to show a dialog for entering chapter name
  void _showAddChapterDialog() {
    String newChapterName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Chapter'),
          content: TextField(
            onChanged: (value) {
              newChapterName = value;
            },
            decoration: const InputDecoration(
              labelText: 'Chapter Name',
              hintText: 'Enter the name of the chapter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newChapterName.isNotEmpty) {
                  _addChapter(newChapterName);
                  Navigator.pop(context); // Close the dialog after saving
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // String courseName = widget.courseData['name'] ?? 'Course Name Not Available';
    // String courseDescription = widget.courseData['description'] ?? 'Description not available'; // Modify as per your data structure
    // String courseImage = widget.courseData['img'] ?? 'assets/CoursePreview.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chapters",
          style: TextStyle(color: Colors.black), // Change color if needed
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow
          onPressed: () {
            Navigator.of(context).pop(); // Back navigation
          },
        ),
        backgroundColor: Colors.white, // Change background color if needed
        elevation: 0, // Remove shadow if not needed
      ),
      backgroundColor:
          const Color(0xFFF5F5F5), // Light background to make cards pop
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20), // Padding at the top and bottom
          child: Column(
            children: chapters.isNotEmpty
                ? chapters.map<Widget>((chapter) {
                    return crstxtforTeacherDataChapter(
                      chapter['img'] ?? 'assets/CoursePreview.png',
                      chapter['lessonName'] ?? 'Unnamed Chapter',
                       // Replace this with your actual edit route if needed
                      context,
                      chapter,
                    );
                  }).toList()
                : [
                    const Center(child: CircularProgressIndicator())
                  ], // Add as a list of widgets
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddChapterDialog, // Add new chapter dialog
        child: const Icon(Icons.add),
      ),
    );
  }
}



Widget crstxtforTeacherDataChapter(
  String img,
  String text,
  BuildContext context,
  Map<String, dynamic> courseData, // Passing the course data to the widget
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15), // Consistent padding
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Increased border radius for a smoother look
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Softer shadow for a modern look
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // Adds more depth
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 7), // Padding inside the container for a clean layout
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
          children: [
            // Image Section
            Image.asset(img, scale: 12),
            const SizedBox(width: 15), // Space between image and text

            // Text and Button Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18, // Larger font for course title
                      color: Colors.black,
                      fontWeight: FontWeight.w500, // Medium weight for emphasis
                    ),
                  ),
                  const SizedBox(height: 10),
                   ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCourseContentTeacher( courseData: courseData), // Passing courseData
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: const Color(0xFF4A90E2), // Custom button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                    child: const Text(
                      'Edit Course',
                      style: TextStyle(fontSize: 16, color: Colors.white), // White text color
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
