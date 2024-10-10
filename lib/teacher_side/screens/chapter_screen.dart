import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
import 'package:flutter/material.dart';

class ChapterPageTeacher extends StatefulWidget {
  const ChapterPageTeacher({super.key});

  @override
  State<ChapterPageTeacher> createState() => _ChapterPageTeacherState();
}

class _ChapterPageTeacherState extends State<ChapterPageTeacher> {
  // Dynamic list to store the chapters
  List<Map<String, String>> chapters = [
    {'img': 'assets/CoursePreview.png', 'name': 'Introduction to Algebra'},
    {'img': 'assets/CoursePreview.png', 'name': 'Geometry Basics'},
    {'img': 'assets/CoursePreview.png', 'name': 'Trigonometry'},
  ];

  // Function to add a new chapter
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
      backgroundColor: const Color(0xFFF5F5F5), // Light background to make cards pop
      // bottomNavigationBar: NavTeacher(initialIndex: 1), // Bottom Navigation
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20), // Padding at the top and bottom
          child: Column(
            children: chapters.map((chapter) {
              return chaptertxtforteacher(
                chapter['img']!,
                chapter['name']!,
                'editcoursecontent', // Replace this with your actual edit route if needed
                context,
                
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddChapterDialog(); // Show dialog to enter chapter name
        },
        backgroundColor: const Color(0xFF4A90E2), // Custom button color
        child: const Icon(Icons.add, color: Colors.white), // Plus icon with white color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Bottom right for FAB
    );
  }
}
