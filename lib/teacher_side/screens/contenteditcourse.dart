import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker package
import 'package:image_picker/image_picker.dart'; // For Images
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  
  
  bool _isLoading = false; // To track the loading state

  String courseName = '';
  String lessonName = '';
  String youtubeLink = '';
  String notes = ''; 
  List<String> pdfUrls = [];
  List<String> imageUrls = [];
  String? documentId; 

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
          documentId = doc.id;
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
  String url = _youtubeLinkController.text.trim(); // Trim any extra spaces

  if (url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a YouTube link')),
    );
    return;
  }

  // Ensure the URL is a valid YouTube link
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'https://$url'; // Add https if it's missing
  }

  // Check if the URL is a valid YouTube URL
  if (!url.contains('youtube.com') && !url.contains('youtu.be')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid YouTube link')),
    );
    return;
  }

  final Uri? uri = Uri.tryParse(url);
  if (uri != null) {
    // Launch the URL and set to open in an external browser
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch YouTube URL')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid URL format')),
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
    TaskSnapshot uploadTask = await storageRef.putFile(pdf);
    String downloadUrl = await storageRef.getDownloadURL();
    if (downloadUrl.isNotEmpty) {
      pdfUrls.add(downloadUrl); // Add URL to the list
      print('Uploaded PDF URL: $downloadUrl');
    } else {
      print('Failed to get download URL for $fileName');
    }
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

  Future<void> _uploadCourseData(String courseName, String lessonName,
      String youtubeLink, List<String> pdfUrls, List<String> imageUrls, String notes) async {
    try {
      await FirebaseFirestore.instance.collection('course_content').add({
        'courseName': courseName,
        'lessonName': lessonName,
        'youtubeLink': youtubeLink,
        'pdfUrls': pdfUrls,
        'imageUrls': imageUrls,
        'notes': notes,  // Save notes to Firestore
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error uploading course data: $e');
    }
  }

  // Future<void> _saveChanges() async {
  //    setState(() {
  //   _isLoading = true; // Start loading
  // });
  //   try {
  //     List<String> updatedPdfUrls = [...pdfUrls]; // Keep the old ones
  //     List<String> updatedImageUrls = [...imageUrls]; // Keep the old ones

  //     // Upload new PDFs and add their URLs to the list
  //     await _uploadPdfFiles(updatedPdfUrls);

  //     // Upload new images and add their URLs to the list
  //     await _uploadImageFiles(updatedImageUrls);

  //     // Update the course document in Firestore
  //     await _updateCourseData(
  //       _courseNameController.text,
  //       _lessonNameController.text,
  //       _youtubeLinkController.text,
  //       updatedPdfUrls,
  //       updatedImageUrls,
  //       _notesController.text,
  //     );

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Changes saved successfully!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Error saving changes')),
  //     );
  //   }
  //    finally {
  //   setState(() {
  //     _isLoading = false; // Stop loading after process completion
  //   });
  //    }
  // }

  Future<void> _saveChanges() async {
  setState(() {
    _isLoading = true; // Start loading
  });
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
  } finally {
    setState(() {
      _isLoading = false; // Stop loading after process completion
    });
  }
}

  void _deletePdf(int index) {
    setState(() {
      _pickedPdfFiles.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF file deleted')),
    );
  }

  void _deleteImage(int index) {
    setState(() {
      _pickedImageFiles.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image file deleted')),
    );
  }

Future<void> _launchPdf(String pdfUrl) async {
  if (pdfUrl.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open PDF, URL is empty')),
    );
    return;
  }

  try {
    // Encode the URL to handle any spaces or special characters
    String encodedUrl = Uri.encodeFull(pdfUrl.trim());
    
    // Parse the URL
    Uri? uri = Uri.tryParse(encodedUrl);

    if (uri != null && await canLaunchUrl(uri)) {
      // Open the URL in an external browser
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open PDF, invalid URL')),
      );
      print('Invalid PDF URL: $encodedUrl');
    }
  } catch (e) {
    print('Error opening PDF: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to open PDF')),
    );
  }
}


Future<void> _launchImage(String imageUrl) async {
  String trimmedUrl = imageUrl.trim(); // Trim extra spaces
  if (trimmedUrl.isNotEmpty) {
    // Ensure proper URL format
    if (!trimmedUrl.startsWith('http://') && !trimmedUrl.startsWith('https://')) {
      trimmedUrl = 'https://$trimmedUrl'; // Add https if missing
    }

    Uri? uri = Uri.tryParse(trimmedUrl);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Open in external browser
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open image, invalid URL')),
      );
      print('Invalid image URL: $trimmedUrl'); // Log invalid URL
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open image, URL is empty')),
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      hintText: 'Enter Topic Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text('YouTube Link',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                    Row(
                    children: [
                      Expanded(
                      child: TextField(
                        controller: _youtubeLinkController,
                        decoration: const InputDecoration(
                        hintText: 'Paste YouTube video link',
                        border: OutlineInputBorder(),
                        ),
                      ),
                      ),
                      IconButton(
                      icon: const Icon(Icons.play_circle_fill, color: const Color(0xFF4A90E2)),
                      onPressed: _launchYoutubeLink,
                      ),
                    ],
                    ),
                  const SizedBox(height: 10),
                   
                  const SizedBox(height: 20),

                  const Text('Upload PDFs',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 8),
                    ElevatedButton.icon(
                    onPressed: _pickPdfFiles,
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: const Text('Select PDF Files', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2), // Background color
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _pickedPdfFiles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_pickedPdfFiles[index].path.split('/').last),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete,color: Colors.red),
                          onPressed: () {
                            _deletePdf(index);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text('Upload Images',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                    ElevatedButton.icon(
                    onPressed: _pickImageFiles,
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text('Select Image Files', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2), // Background color
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _pickedImageFiles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_pickedImageFiles[index].path.split('/').last),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteImage(index);
                          },
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
                  title: GestureDetector(
                    onTap: () => _launchPdf(pdfUrls[index]), // Launch PDF on text tap
                    child: Text('PDF ${index + 1}'),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
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
                  title: GestureDetector(
                    onTap: () => _launchImage(imageUrls[index]), // Launch image on text tap
                    child: Text('Image ${index + 1}'),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                    setState(() {
                      imageUrls.removeAt(index);
                    });
                    },
                  ),
                  );
                },
                )

              // const SizedBox(height: 20),

                  // const Text('Teacher\'s Notes',
                  //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // const SizedBox(height: 8),
                  // TextField(
                  //   controller: _notesController,
                  //   maxLines: 3,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Enter teacher\'s notes',
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)), // Show loader with blue color
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0), // Adjust padding as needed
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveChanges, // Disable button when saving
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: 5), // Padding inside the button
              backgroundColor: const Color(0xFF4A90E2), // Blue color
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
