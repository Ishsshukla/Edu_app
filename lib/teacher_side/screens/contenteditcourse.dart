// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:file_picker/file_picker.dart'; // Import file_picker package
// import 'package:image_picker/image_picker.dart'; // For Images
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../components/review_componemt.dart'; // For File operations

// class EditCourseContentTeacher extends StatefulWidget {
//   const EditCourseContentTeacher({Key? key}) : super(key: key);

//   @override
//   State<EditCourseContentTeacher> createState() =>
//       _EditCourseContentTeacherState();
// }

// class _EditCourseContentTeacherState extends State<EditCourseContentTeacher> {
//   // Controller to store the YouTube link
//   final TextEditingController _youtubeLinkController = TextEditingController();

//   // Variables to store picked file information
//   List<File> _pickedPdfFiles = []; // Updated to handle multiple PDFs
//   List<File> _pickedImageFiles = [];

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
//     if (pickedFiles != null) {
//       setState(() {
//         _pickedImageFiles
//             .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
//       });
//     }
//   }

//    // Function to upload PDFs
//   Future<void> _uploadPdfFiles(List<String> pdfUrls) async {
//     for (var pdf in _pickedPdfFiles) {
//       String fileName = pdf.path.split('/').last;
//       Reference storageRef = FirebaseStorage.instance.ref().child('pdfs/$fileName');
//       await storageRef.putFile(pdf);
//       String downloadUrl = await storageRef.getDownloadURL();
//       pdfUrls.add(downloadUrl);
//     }
//   }

//   // Function to upload Images
//   Future<void> _uploadImageFiles(List<String> imageUrls) async {
//     for (var image in _pickedImageFiles) {
//       String fileName = image.path.split('/').last;
//       Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
//       await storageRef.putFile(image);
//       String downloadUrl = await storageRef.getDownloadURL();
//       imageUrls.add(downloadUrl);
//     }
//   }

//   // Function to upload metadata to Firestore
//   Future<void> _uploadCourseData(String youtubeLink, List<String> pdfUrls, List<String> imageUrls) async {
//     try {
//       await FirebaseFirestore.instance.collection('courses').add({
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

//       // Upload metadata to Firestore
//       await _uploadCourseData(_youtubeLinkController.text, pdfUrls, imageUrls);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Changes saved successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error saving changes')),
//       );
//     }
//   }

//   // Function to save changes
//   // void _saveChanges() {
//   //   // Implement your save logic here, such as saving the selected files or updating data
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     const SnackBar(content: Text('Changes saved successfully!')),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Add an AppBar with the back arrow and title
//       appBar: AppBar(
//         title: const Text(
//           "Edit Course",
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
//           padding: const EdgeInsets.fromLTRB(20, 20, 20,
//               0), // Adjust top padding to 20 to avoid overlapping with the AppBar
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 180, 0),
//                 child: txt('Class/Course Name', context),
//               ),
//               editabletxtforteacher('Write Class/Course Name', context),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(right: 225),
//                 child: txt('Lesson Name', context),
//               ),
//               editabletxtforteacher('Write Lesson Name', context),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(right: 195),
//                 child: txt('Link of the Class', context),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: TextField(
//                   controller: _youtubeLinkController,
//                   decoration: InputDecoration(
//                     hintText: 'Paste the Link Of Class Here',
//                     suffixIcon: IconButton(
//                       icon:
//                           const Icon(Icons.play_circle_fill, color: Colors.red),
//                       onPressed: _launchYoutubeLink,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.only(right: 210),
//                 child: txt('Upload Notes', context),
//               ),
//               const SizedBox(height: 10),
//               // Button for picking PDFs
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: _pickPdfFiles, // Updated to handle multiple PDFs
//                     icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
//                     label: const Text("Upload PDFs"),
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
//                     label: const Text("Upload Images",
//                         style: TextStyle(color: Colors.black)),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 175, 76, 84),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Display the selected PDF files
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
//                     return Container(
//                       padding: const EdgeInsets.all(8.0),
//                       margin: const EdgeInsets.only(bottom: 10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.picture_as_pdf, color: Colors.red),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               _pickedPdfFiles[index].path.split('/').last,
//                               style: const TextStyle(
//                                   color: Colors.black, fontSize: 16),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               setState(() {
//                                 _pickedPdfFiles.removeAt(index);
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//               const SizedBox(height: 10),
//               // Display the selected image files
//               if (_pickedImageFiles.isNotEmpty) ...[
//                 const Text(
//                   "Selected Images:",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemCount: _pickedImageFiles.length,
//                   itemBuilder: (context, index) {
//                     return Stack(
//                       children: [
//                         Image.file(
//                           _pickedImageFiles[index],
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                         Positioned(
//                           right: 0,
//                           child: IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               setState(() {
//                                 _pickedImageFiles.removeAt(index);
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),

//       // Add a "Save Changes" button at the bottom
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ElevatedButton(
//           onPressed: _saveChanges, // Call save function
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 0),
//             backgroundColor: Color(0xFF4A90E2), // Button background color
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           child: const Text(
//             'Save Changes',
//             style: TextStyle(fontSize: 18, color: Colors.white),
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
  const EditCourseContentTeacher({Key? key}) : super(key: key);

  @override
  State<EditCourseContentTeacher> createState() =>
      _EditCourseContentTeacherState();
}

class _EditCourseContentTeacherState extends State<EditCourseContentTeacher> {
  // Controllers to store the course name, lesson name, and YouTube link
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _lessonNameController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();

  // Variables to store picked file information
  List<File> _pickedPdfFiles = []; // Updated to handle multiple PDFs
  List<File> _pickedImageFiles = [];

  // Function to open the YouTube link
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

  // Function to pick PDF files
  Future<void> _pickPdfFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files
      allowMultiple: true, // Enable multiple file picking
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedPdfFiles.addAll(result.paths.map((path) => File(path!)));
      });
    }
  }

  // Function to pick images
  Future<void> _pickImageFiles() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _pickedImageFiles
            .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
      });
    }
  }

  // Function to upload PDFs
  Future<void> _uploadPdfFiles(List<String> pdfUrls) async {
    for (var pdf in _pickedPdfFiles) {
      String fileName = pdf.path.split('/').last;
      Reference storageRef = FirebaseStorage.instance.ref().child('pdfs/$fileName');
      await storageRef.putFile(pdf);
      String downloadUrl = await storageRef.getDownloadURL();
      pdfUrls.add(downloadUrl);
    }
  }

  // Function to upload Images
  Future<void> _uploadImageFiles(List<String> imageUrls) async {
    for (var image in _pickedImageFiles) {
      String fileName = image.path.split('/').last;
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
      await storageRef.putFile(image);
      String downloadUrl = await storageRef.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
  }

  // Function to upload metadata to Firestore
  Future<void> _uploadCourseData(
      String courseName, String lessonName, String youtubeLink, List<String> pdfUrls, List<String> imageUrls) async {
    try {
      await FirebaseFirestore.instance.collection('course_content').add({
        'courseName': courseName,
        'lessonName': lessonName,
        'youtubeLink': youtubeLink,
        'pdfUrls': pdfUrls,
        'imageUrls': imageUrls,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error uploading course data: $e');
    }
  }

  // Function to save changes
  Future<void> _saveChanges() async {
    try {
      List<String> pdfUrls = [];
      List<String> imageUrls = [];

      // Upload PDFs and images
      await _uploadPdfFiles(pdfUrls);
      await _uploadImageFiles(imageUrls);

      // Capture course name and lesson name
      String courseName = _courseNameController.text;
      String lessonName = _lessonNameController.text;

      // Upload metadata to Firestore
      await _uploadCourseData(courseName, lessonName, _youtubeLinkController.text, pdfUrls, imageUrls);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error saving changes')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Course",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), // Adjust top padding to 20
          child: Column(
            children: [
              // Course Name Input
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 180, 0),
                child: Text('Class/Course Name', style: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: _courseNameController,
                decoration: InputDecoration(
                  hintText: 'Write Class/Course Name',
                ),
              ),
              const SizedBox(height: 20),

              // Lesson Name Input
              Padding(
                padding: const EdgeInsets.only(right: 225),
                child: Text('Lesson Name', style: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: _lessonNameController,
                decoration: InputDecoration(
                  hintText: 'Write Lesson Name',
                ),
              ),
              const SizedBox(height: 20),

              // YouTube Link Input
              Padding(
                padding: const EdgeInsets.only(right: 195),
                child: Text('Link of the Class', style: TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: _youtubeLinkController,
                  decoration: InputDecoration(
                    hintText: 'Paste the Link Of Class Here',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.play_circle_fill, color: Colors.red),
                      onPressed: _launchYoutubeLink,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Upload PDFs and Images
              Padding(
                padding: const EdgeInsets.only(right: 210),
                child: Text('Upload Notes', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickPdfFiles,
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: const Text("Upload PDFs"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 191, 33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickImageFiles,
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text("Upload Images"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 175, 76, 84),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Display Selected PDFs
              if (_pickedPdfFiles.isNotEmpty) ...[
                const Text(
                  "Selected PDFs:",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pickedPdfFiles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.picture_as_pdf, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _pickedPdfFiles[index].path.split('/').last,
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],

              // Display Selected Images
              if (_pickedImageFiles.isNotEmpty) ...[
                const Text(
                  "Selected Images:",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pickedImageFiles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.image, color: Colors.blue),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _pickedImageFiles[index].path.split('/').last,
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],

              const SizedBox(height: 30),

              // Save Changes Button
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text("Save Changes"),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
