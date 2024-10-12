// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:file_picker/file_picker.dart'; // Import file_picker package
// import 'package:image_picker/image_picker.dart'; // For Images
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class EditCourseContentTeacher extends StatefulWidget {
//   final Map<String, dynamic> courseData;
//   const EditCourseContentTeacher({super.key, required this.courseData});

//   @override
//   State<EditCourseContentTeacher> createState() =>
//       _EditCourseContentTeacherState();
// }

// class _EditCourseContentTeacherState extends State<EditCourseContentTeacher> {
//   // Controllers to store the course name, lesson name, and YouTube link
//   final TextEditingController _courseNameController = TextEditingController();
//   final TextEditingController _lessonNameController = TextEditingController();
//   final TextEditingController _youtubeLinkController = TextEditingController();
//   final List<File> _pickedPdfFiles = []; // Updated to handle multiple PDFs
//   final List<File> _pickedImageFiles = [];

// //..................................
//  String courseName = '';
//   String lessonName = '';
//   String youtubeLink = '';
//   String notes = ''; // New variable for teacher's notes
//   List<String> pdfUrls = [];
//   List<String> imageUrls = [];

//    @override
//   void initState() {
//     super.initState();
//     fetchCourses();
//   }

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> chapters = [];

//   // Future<void> fetchCourses() async {
//   //   try {
//   //     String selectedCourseName = widget.courseData['courseName'];
//   //     String selectedLessonName = widget.courseData['lessonName'];

//   //     QuerySnapshot snapshot = await _firestore
//   //         .collection('course_content')
//   //         .where('courseName', isEqualTo: selectedCourseName)
//   //         .get();

//   //     List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
//   //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//   //       print(data);

//   //       return {
//   //         'courseName': data.containsKey('courseName')
//   //             ? data['courseName']
//   //             : 'Unknown Course',
//   //         'img': 'assets/CoursePreview.png',
//   //         'lessonName': data.containsKey('lessonName')
//   //             ? data['lessonName']
//   //             : 'Unknown Lesson',
//   //         // Other fields if needed
//   //       };
//   //     }).toList();

//   //     setState(() {
//   //       chapters = fetchedCourses;
//   //       print("Courses fetched successfully = $chapters");
//   //     });
//   //   } catch (e) {
//   //     print("Error fetching courses: $e");
//   //   }
//   // }
//   Future<void> fetchCourses() async {
//   try {
//     String selectedCourseName = widget.courseData['courseName'];
//     String selectedLessonName = widget.courseData['lessonName'];

//     // Perform a query with both courseName and lessonName
//     QuerySnapshot snapshot = await _firestore
//         .collection('course_content')
//         .where('courseName', isEqualTo: selectedCourseName)
//         .where('lessonName', isEqualTo: selectedLessonName)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       // Assuming you only expect one result
//       var data = snapshot.docs.first.data() as Map<String, dynamic>;
//       print(data);

//       // Extracting the relevant data
//       setState(() {
//         courseName = data.containsKey('courseName') ? data['courseName'] : 'Unknown Course';
//         lessonName = data.containsKey('lessonName') ? data['lessonName'] : 'Unknown Lesson';
//         youtubeLink = data.containsKey('youtubeLink') ? data['youtubeLink'] : 'No YouTube Link';
//         pdfUrls = data.containsKey('pdfUrls') ? List<String>.from(data['pdfUrls']) : [];
//         imageUrls = data.containsKey('imageUrls') ? List<String>.from(data['imageUrls']) : [];
//         notes = data.containsKey('notes') ? data['notes'] : 'No Notes';  // Assuming 'notes' is present
//       });

//       print("Fetched Course Data: $courseName, $lessonName, $youtubeLink, $pdfUrls, $imageUrls, $notes");
//     } else {
//       print("No matching course content found for $selectedCourseName and $selectedLessonName");
//     }
//   } catch (e) {
//     print("Error fetching courses: $e");
//   }
// }
//   // Function to open the YouTube link
//   Future<void> _launchYoutubeLink() async {
//     final url = _youtubeLinkController.text;
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid YouTube URL')),
//       );
//     }
//   }

//   // Function to pick PDF files
//   Future<void> _pickPdfFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'], // Only allow PDF files
//       allowMultiple: true, // Enable multiple file picking
//     );
//     if (result != null && result.files.isNotEmpty) {
//       setState(() {
//         _pickedPdfFiles.addAll(result.paths.map((path) => File(path!)));
//       });
//     }
//   }

//   // Function to pick images
//   Future<void> _pickImageFiles() async {
//     final pickedFiles = await ImagePicker().pickMultiImage();
//     setState(() {
//       _pickedImageFiles
//           .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
//     });
//   }

//   // Function to upload PDFs
//   Future<void> _uploadPdfFiles(List<String> pdfUrls) async {
//     for (var pdf in _pickedPdfFiles) {
//       String fileName = pdf.path.split('/').last;
//       Reference storageRef =
//           FirebaseStorage.instance.ref().child('pdfs/$fileName');
//       await storageRef.putFile(pdf);
//       String downloadUrl = await storageRef.getDownloadURL();
//       pdfUrls.add(downloadUrl);
//     }
//   }

//   // Function to upload Images
//   Future<void> _uploadImageFiles(List<String> imageUrls) async {
//     for (var image in _pickedImageFiles) {
//       String fileName = image.path.split('/').last;
//       Reference storageRef =
//           FirebaseStorage.instance.ref().child('images/$fileName');
//       await storageRef.putFile(image);
//       String downloadUrl = await storageRef.getDownloadURL();
//       imageUrls.add(downloadUrl);
//     }
//   }

//   // Function to upload metadata to Firestore
//   Future<void> _uploadCourseData(String courseName, String lessonName,
//       String youtubeLink, List<String> pdfUrls, List<String> imageUrls) async {
//     try {
//       await FirebaseFirestore.instance.collection('course_content').add({
//         'courseName': courseName,
//         'lessonName': lessonName,
//         'youtubeLink': youtubeLink,
//         'pdfUrls': pdfUrls,
//         'imageUrls': imageUrls,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print('Error uploading course data: $e');
//     }
//   }

//   // Function to save changes
//   Future<void> _saveChanges() async {
//     try {
//       List<String> pdfUrls = [];
//       List<String> imageUrls = [];

//       // Upload PDFs and images
//       await _uploadPdfFiles(pdfUrls);
//       await _uploadImageFiles(imageUrls);

//       // Capture course name and lesson name
//       String courseName = _courseNameController.text;
//       String lessonName = _lessonNameController.text;

//       // Upload metadata to Firestore
//       await _uploadCourseData(courseName, lessonName,
//           _youtubeLinkController.text, pdfUrls, imageUrls);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Changes saved successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error saving changes')),
//       );
//     }
//   }

//   // Delete selected PDF
//   void _deletePdf(int index) {
//     setState(() {
//       _pickedPdfFiles.removeAt(index);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('PDF file deleted')),
//     );
//   }

//   // Delete selected image
//   void _deleteImage(int index) {
//     setState(() {
//       _pickedImageFiles.removeAt(index);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Image file deleted')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Edit Chapter",
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
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Course Name Input
//               const Text('Chapter Name',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _courseNameController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Class/Course Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Lesson Name Input
//               const Text('Topic Name',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _lessonNameController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Lesson Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // YouTube Link Input
//               const Text('Class Link (YouTube)',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _youtubeLinkController,
//                 decoration: InputDecoration(
//                   hintText: 'Paste the YouTube Link Here',
//                   border: const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.play_circle_fill, color: Colors.red),
//                     onPressed: _launchYoutubeLink,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Upload PDFs and Images Section
//               const Text('Upload Notes',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: _pickPdfFiles,
//                     icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
//                     label: const Text(
//                       "Upload PDFs",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 243, 191, 33),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: _pickImageFiles,
//                     icon: const Icon(Icons.image, color: Colors.white),
//                     label: const Text(
//                       "Upload Images",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 226, 137,
//                           74), // Blue color similar to the one in the image
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Display Selected PDFs
//               if (_pickedPdfFiles.isNotEmpty) ...[
//                 const Text(
//                   "Selected PDFs:",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 5),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: _pickedPdfFiles.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: ListTile(
//                         leading: const Icon(Icons.picture_as_pdf),
//                         title:
//                             Text(_pickedPdfFiles[index].path.split('/').last),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _deletePdf(index),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//               const SizedBox(height: 20),

//               // Display Selected Images
//               if (_pickedImageFiles.isNotEmpty) ...[
//                 const Text(
//                   "Selected Images:",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 5),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: _pickedImageFiles.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: ListTile(
//                         leading: const Icon(Icons.image),
//                         title:
//                             Text(_pickedImageFiles[index].path.split('/').last),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _deleteImage(index),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(0), // Adjust padding as needed
//           child: ElevatedButton(
//             onPressed: _saveChanges, // Call save changes function
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(
//                   vertical: 5), // Padding inside the button
//               backgroundColor: const Color(
//                   0xFF4A90E2), // Blue color similar to the one in the image
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10), // Rounded corners
//               ),
//             ),
//             child: const Text(
//               'Save Changes', // Button text
//               style: TextStyle(fontSize: 23, color: Colors.white), // Text style
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker package
import 'package:image_picker/image_picker.dart'; // For Images
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCourseContentTeacher extends StatefulWidget {
  final Map<String, dynamic> courseData;
  const EditCourseContentTeacher({super.key, required this.courseData});

  @override
  State<EditCourseContentTeacher> createState() =>
      _EditCourseContentTeacherState();
}

class _EditCourseContentTeacherState extends State<EditCourseContentTeacher> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _lessonNameController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();
  final TextEditingController _notesController = TextEditingController(); // For teacher's notes
  final List<File> _pickedPdfFiles = [];
  final List<File> _pickedImageFiles = [];

  String courseName = '';
  String lessonName = '';
  String youtubeLink = '';
  String notes = ''; 
  List<String> pdfUrls = [];
  List<String> imageUrls = [];
  String? documentId; // To store the fetched document ID

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchCourses() async {
    try {
      String selectedCourseName = widget.courseData['courseName'];
      String selectedLessonName = widget.courseData['lessonName'];

      QuerySnapshot snapshot = await _firestore
          .collection('course_content')
          .where('courseName', isEqualTo: selectedCourseName)
          .where('lessonName', isEqualTo: selectedLessonName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        var data = doc.data() as Map<String, dynamic>;
        setState(() {
          courseName = data['courseName'] ?? 'Unknown Course';
          lessonName = data['lessonName'] ?? 'Unknown Lesson';
          youtubeLink = data['youtubeLink'] ?? 'No YouTube Link';
          pdfUrls = List<String>.from(data['pdfUrls'] ?? []);
          imageUrls = List<String>.from(data['imageUrls'] ?? []);
          notes = data['notes'] ?? 'No Notes';
          documentId = doc.id; // Store the document ID
        });

        // Initialize controllers with fetched data
        _courseNameController.text = courseName;
        _lessonNameController.text = lessonName;
        _youtubeLinkController.text = youtubeLink;
        _notesController.text = notes;
      } else {
        print("No matching course content found.");
      }
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

  Future<void> _launchYoutubeLink() async {
    final url = _youtubeLinkController.text;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid YouTube URL')),
      );
    }
  }

  Future<void> _pickPdfFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedPdfFiles.addAll(result.paths.map((path) => File(path!)));
      });
    }
  }

  Future<void> _pickImageFiles() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _pickedImageFiles.addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
    });
  }

  Future<void> _uploadPdfFiles(List<String> pdfUrls) async {
    for (var pdf in _pickedPdfFiles) {
      String fileName = pdf.path.split('/').last;
      Reference storageRef = FirebaseStorage.instance.ref().child('pdfs/$fileName');
      await storageRef.putFile(pdf);
      String downloadUrl = await storageRef.getDownloadURL();
      pdfUrls.add(downloadUrl);
    }
  }

  Future<void> _uploadImageFiles(List<String> imageUrls) async {
    for (var image in _pickedImageFiles) {
      String fileName = image.path.split('/').last;
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
      await storageRef.putFile(image);
      String downloadUrl = await storageRef.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
  }

  Future<void> _updateCourseData(String courseName, String lessonName,
      String youtubeLink, List<String> pdfUrls, List<String> imageUrls, String notes) async {
    if (documentId == null) {
      print("Error: No document ID available for update.");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('course_content').doc(documentId).update({
        'courseName': courseName,
        'lessonName': lessonName,
        'youtubeLink': youtubeLink,
        'pdfUrls': pdfUrls,
        'imageUrls': imageUrls,
        'notes': notes,  // Update notes in Firestore
        'timestamp': FieldValue.serverTimestamp(), // Optional, to track the last update time
      });
    } catch (e) {
      print('Error updating course data: $e');
    }
  }

  Future<void> _saveChanges() async {
    try {
      List<String> updatedPdfUrls = [...pdfUrls]; // Keep the old ones
      List<String> updatedImageUrls = [...imageUrls]; // Keep the old ones

      // Upload new PDFs and add their URLs to the list
      await _uploadPdfFiles(updatedPdfUrls);

      // Upload new images and add their URLs to the list
      await _uploadImageFiles(updatedImageUrls);

      // Update the course document in Firestore
      await _updateCourseData(
        _courseNameController.text,
        _lessonNameController.text,
        _youtubeLinkController.text,
        updatedPdfUrls,
        updatedImageUrls,
        _notesController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error saving changes')),
      );
    }
  }

  void _deletePdf(int index) {
    setState(() {
      pdfUrls.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF file deleted')),
    );
  }

  void _deleteImage(int index) {
    setState(() {
      imageUrls.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image file deleted')),
    );
  }

  void _launchImage(String imageUrl) async {
    if (await canLaunchUrl(Uri.parse(imageUrl))) {
      await launchUrl(Uri.parse(imageUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot open image URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Chapter",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Chapter Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _courseNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Class/Course Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              const Text('Topic Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _lessonNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Lesson Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              const Text('Class Link (YouTube)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _youtubeLinkController,
                decoration: const InputDecoration(
                  hintText: 'Enter YouTube Link',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _launchYoutubeLink,
                child: const Text('Open YouTube Link'),
              ),
              const SizedBox(height: 20),

              const Text('Teacher Notes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  hintText: 'Enter Notes Here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              const Text('Upload PDF Files',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickPdfFiles,
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Pick PDFs'),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _pickedPdfFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_pickedPdfFiles[index].path.split('/').last),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deletePdf(index),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              const Text('Upload Image Files',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickImageFiles,
                icon: const Icon(Icons.image),
                label: const Text('Pick Images'),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _pickedImageFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_pickedImageFiles[index].path.split('/').last),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteImage(index),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              const Text('Existing PDF Files',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: pdfUrls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('PDF ${index + 1}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          pdfUrls.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              const Text('Existing Image Files',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Image ${index + 1}'),
                    onTap: () => _launchImage(imageUrls[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          imageUrls.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Center(
              //   child: ElevatedButton(
              //     onPressed: _saveChanges,
              //     child: const Text('Save Changes'),
              //   ),
              // ),
      
            ],
          ),
        ),
      ),
               bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0), // Adjust padding as needed
          child: ElevatedButton(
            onPressed: _saveChanges, // Call save changes function
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: 5), // Padding inside the button
              backgroundColor: const Color(
                  0xFF4A90E2), // Blue color similar to the one in the image
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child: const Text(
              'Save Changes', // Button text
              style: TextStyle(fontSize: 23, color: Colors.white), // Text style
            ),
          ),
        ),
               )
    );
    
  }
}
