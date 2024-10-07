import 'package:edu_app/components/const.dart';
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

  // Delete selected PDF
  void _deletePdf(int index) {
    setState(() {
      _pickedPdfFiles.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF file deleted')),
    );
  }

  // Delete selected image
  void _deleteImage(int index) {
    setState(() {
      _pickedImageFiles.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image file deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Chapter",
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Name Input
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

              // Lesson Name Input
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

              // YouTube Link Input
              const Text('Class Link (YouTube)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _youtubeLinkController,
                decoration: InputDecoration(
                  hintText: 'Paste the YouTube Link Here',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.play_circle_fill, color: Colors.red),
                    onPressed: _launchYoutubeLink,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Upload PDFs and Images Section
              const Text('Upload Notes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickPdfFiles,
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                   label: const Text(
                      "Upload PDFs",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
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
                    label: const Text(
                      "Upload Images",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 226, 137, 74), // Blue color similar to the one in the image
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
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.picture_as_pdf),
                        title: Text(_pickedPdfFiles[index].path.split('/').last),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deletePdf(index),
                        ),
                      ),
                    );
                  },
                ),
              ],
              const SizedBox(height: 20),

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
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.image),
                        title: Text(_pickedImageFiles[index].path.split('/').last),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteImage(index),
                        ),
                      ),
                    );
                  },
                ),
              ],
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
              padding: const EdgeInsets.symmetric(vertical: 5), // Padding inside the button
              backgroundColor: const Color(0xFF4A90E2), // Blue color similar to the one in the image
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
      ),
    );
  }
}
