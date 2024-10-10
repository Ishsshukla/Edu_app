// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter
// import 'package:edu_app/teacher_side/navbar.dart';
// import 'package:flutter/material.dart';

// class ChapterPageStudent extends StatefulWidget {
//    final Map<String, dynamic> courseData; // Data for the selected course

//   const ChapterPageStudent({super.key, required this.courseData});
//   // const ChapterPageStudent({super.key});

//   @override
//   State<ChapterPageStudent> createState() => _ChapterPageStudentState();
// }

// class _ChapterPageStudentState extends State<ChapterPageStudent> {
//   // Dynamic list to store the chapters
//   List<Map<String, dynamic>> chapters = [
//     // {'img': 'assets/CoursePreview.png', 'name': 'Introduction to Algebra'},
//     // {'img': 'assets/CoursePreview.png', 'name': 'Geometry Basics'},
//     // {'img': 'assets/CoursePreview.png', 'name': 'Trigonometry'},

//   ];
//   @override
//   void initState() {
//     super.initState();
//     fetchChapters(); // Fetch chapters when the page loads
//   }

//    // Function to fetch chapters from Firestore based on course
//   Future<void> fetchChapters() async {
//     String courseName = widget.courseData['name']; // Assuming courseName is passed

//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('chapters') // Assuming your chapters are stored in 'chapters' collection
//         .where('courseName', isEqualTo: courseName)
//         .get();

//     setState(() {
//       chapters = querySnapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//     });
//   }

//   // Function to add a new chapter
//   void _addChapter(String chapterName) {
//     setState(() {
//       chapters.add({'img': 'assets/CoursePreview.png', 'name': chapterName});
//     });
//   }

//   // Function to show a dialog for entering chapter name
//   void _showAddChapterDialog() {
//     String newChapterName = '';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add New Chapter'),
//           content: TextField(
//             onChanged: (value) {
//               newChapterName = value;
//             },
//             decoration: const InputDecoration(
//               labelText: 'Chapter Name',
//               hintText: 'Enter the name of the chapter',
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog without saving
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (newChapterName.isNotEmpty) {
//                   _addChapter(newChapterName);
//                   Navigator.pop(context); // Close the dialog after saving
//                 }
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//      String courseName = widget.courseData['name'] ?? 'Course Name Not Available';
//     String courseDescription = widget.courseData['description'] ?? 'Description not available'; // Modify as per your data structure
//     String courseImage = widget.courseData['img'] ?? 'assets/CoursePreview.png';
//     String lessonName = widget.courseData['lessonName'] ?? 'Lesson Name Not Available';
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Chapters",
//           style: TextStyle(color: Colors.black), // Change color if needed
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow
//           onPressed: () {
//             Navigator.of(context).pop(); // Back navigation
//           },
//         ),
//         backgroundColor: Colors.white, // Change background color if needed
//         elevation: 0, // Remove shadow if not needed
//       ),
//       backgroundColor: const Color(0xFFF5F5F5), // Light background to make cards pop
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20), // Padding at the top and bottom
//           child: Column(
//             children: chapters.map((chapter) {
//               return chaptertxtforstudent(
//                 chapter['img']!,
//                 chapter['name']!,
//                 'editcoursecontent', // Replace this with your actual edit route if needed
//                 context,

//               );
//             }).toList(),
//           ),
//         ),

//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/students_screens/screens/enrolled_course/content_chptr.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/components/coursesbuy.dart'; // Update import if needed for chapter

class ChapterPageStudent extends StatefulWidget {
  // final Map<String, dynamic> courseData; // Data for the selected course
  final String courseName;

  const ChapterPageStudent({super.key, required this.courseName});

  @override
  State<ChapterPageStudent> createState() => _ChapterPageStudentState();
}

class _ChapterPageStudentState extends State<ChapterPageStudent> {
  // Dynamic list to store the chapters fetched from Firestore

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   fetchChapters();
  // }

  // Dynamic list to store the chapters
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];
  // Fetch courses from Firestore
  // Future<void> fetchCourses() async {
  //   try {
  //     QuerySnapshot snapshot = await _firestore.collection('course_content').get();
  //        List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       print(data);
  //       return {
  //         'img': 'assets/CoursePreview.png',
  //         'lessoneName': data.containsKey('courseName') ? data['courseName'] : 'Unknown Course',
  //         // 'description': data.containsKey('description') ? data['description'] : 'No description available',
  //       };
  //     }).toList();

  //     setState(() {
  //       chapters = fetchedCourses;
  //       print("Courses fetched successfully=${chapters}");
  //     });
  //   }
  //   catch (e) {
  //     print("Error fetching courses: $e");
  //   }
  // }

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

  // Future<void> fetchChapters() async {
  //   String courseName = widget.courseData['name']; // Assuming courseName is passed
  //   print("courseName = ${courseName}");
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('lessonName') // Assuming your chapters are stored in 'chapters' collection
  //       .where('courseName', isEqualTo: courseName)
  //       .get();
  //   print("querySnapshot = ${querySnapshot}");
  //   setState(() {
  //     chapters = querySnapshot.docs
  //         .map((doc) => doc.data() as Map<String, dynamic>)
  //         .toList();
  //   });
  // }

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
                    return crstxtforstudentDataChapter(
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



Widget crstxtforstudentDataChapter(
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
                          builder: (context) => ViewChapterStudent( courseData: courseData), // Passing courseData
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
                      'View Course',
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
