import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker package
import 'package:image_picker/image_picker.dart'; // For Images
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:open_file/open_file.dart';

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
  final TextEditingController _notesController =
      TextEditingController(); // For teacher's notes
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
    fetchChapters();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> fetchChapters() async {
    try {
      String courseDocId = widget.courseData[
          'courseId']; // The course document ID from the previous page
      String chapterDocId = widget.courseData[
          'docId']; // The chapter document ID from the previous page

      // Access the 'chapters' subcollection inside the specific course document
      DocumentSnapshot chapterSnapshot = await _firestore
          .collection('course_content')
          .doc(courseDocId) // Referencing the course by its document ID
          .collection('chapters') // Access the 'chapters' subcollection
          .doc(chapterDocId) // Fetch the specific chapter by its document ID
          .get();

      if (chapterSnapshot.exists) {
        var data = chapterSnapshot.data() as Map<String, dynamic>;

        setState(() {
          courseName = widget.courseData['name'] ?? 'Unknown Course';
          lessonName = data['lessonName'] ?? 'Unknown Lesson';
          youtubeLink = data['youtubeLink'] ?? 'No YouTube Link';
          pdfUrls = List<String>.from(data['pdfUrls'] ?? []);
          imageUrls = List<String>.from(data['imageUrls'] ?? []);
          notes = data['notes'] ?? 'No Notes';
        });

        // Initialize controllers with fetched data
        _courseNameController.text = courseName;
        _lessonNameController.text = lessonName;
        _youtubeLinkController.text = youtubeLink;
        _notesController.text = notes;
      } else {
        print("No matching chapter found.");
      }
    } catch (e) {
      print("Error fetching chapters: $e");
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
      _pickedImageFiles
          .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
    });
  }

  Future<void> _uploadPdfFiles(List<String> pdfUrls) async {
    for (var pdf in _pickedPdfFiles) {
      String fileName = pdf.path.split('/').last;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('pdfs/$fileName');
      await storageRef.putFile(pdf);
      String downloadUrl = await storageRef.getDownloadURL();
      pdfUrls.add(downloadUrl);
    }
  }

  Future<void> _uploadImageFiles(List<String> imageUrls) async {
    for (var image in _pickedImageFiles) {
      String fileName = image.path.split('/').last;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      await storageRef.putFile(image);
      String downloadUrl = await storageRef.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
  }


  Future<void> _updateChapterData(
      String courseDocId,
      String chapterDocId,
      String courseName,
      String lessonName,
      String youtubeLink,
      List<String> pdfUrls,
      List<String> imageUrls,
      String notes) async {
    if (courseDocId == null || chapterDocId == null) {
      print("Error: No document ID available for update.");
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('course_content')
          .doc(courseDocId) // Referencing the specific course
          .collection('chapters') // Access the 'chapters' subcollection
          .doc(chapterDocId) // Referencing the specific chapter
          .update({
        'courseName': courseName,
        'lessonName': lessonName,
        'youtubeLink': youtubeLink,
        'pdfUrls': pdfUrls,
        'imageUrls': imageUrls,
        'notes': notes,
        'timestamp': FieldValue.serverTimestamp(), // Track last update time
      });
    } catch (e) {
      print('Error updating chapter data: $e');
    }
  }


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

      // Update the chapter document in the 'chapters' subcollection
      await _updateChapterData(
        widget.courseData[
            'courseId'], // Pass the courseDocId from the previous page
        widget.courseData[
            'docId'], // Pass the chapterDocId from the previous page
        _courseNameController.text, // Course name
        _lessonNameController.text, // Lesson name
        _youtubeLinkController.text, // YouTube link
        updatedPdfUrls, // Updated PDF URLs
        updatedImageUrls, // Updated image URLs
        _notesController.text, 
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved successfully!')),
      );
    } catch (e) {
      // Show error message
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

  void _launchImage(String imageUrl) async {
    if (await canLaunchUrl(Uri.parse(imageUrl))) {
      await launchUrl(Uri.parse(imageUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot open image URL')),
      );
    }
  }

  void _launchPdf(String pdfPath) async {
    final result = await OpenFile.open(pdfPath);
    if (result.message != 'null') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message)),
      );
    }
  }

  void removeImage(int index) {
    setState(() {
      imageUrls.removeAt(index);
    });
  }

  void removePdf(int index) {
    setState(() {
      pdfUrls.removeAt(index);
    });
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
                const Text('Course Name',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _courseNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Class/Course Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Chapter Name',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

                      // On tapping the entire tile, you can make the download function trigger
                      onTap: () async {
                        await launchUrl(Uri.file(_pickedPdfFiles[index]
                            .path)); // Download or open the PDF
                      },

                      // Adding both delete and download buttons to the right
                      trailing: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Keep the row minimal in size
                        children: [
                          // Delete Button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _deletePdf(index), // Call the delete function
                          ),

                          // Download Button
                          IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () async {
                              _launchPdf(_pickedPdfFiles[index].path);
                              // await launchUrl(Uri.file(_pickedPdfFiles[index]
                              //     .path)); // Open/download PDF
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text('Upload Image Files',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _pickImageFiles,
                  icon: const Icon(Icons.image),
                  label: const Text('Pick Images'),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of images in a row
                    childAspectRatio: 1.0, // To make the grid square
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _pickedImageFiles.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        // The image itself
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () async {
                              await launchUrl(Uri.file(_pickedImageFiles[index]
                                  .path)); // Open the image
                            },
                            child: Image.file(
                              _pickedImageFiles[
                                  index], // Display the picked image
                              fit: BoxFit
                                  .cover, // Ensure the image fits within the grid tile
                            ),
                          ),
                        ),
                        // Delete button in the top-right corner
                        Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _deleteImage(index), // Call the delete function
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                if (pdfUrls.isNotEmpty) ...[
                  const Text(
                    "Uploaded PDFs:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pdfUrls.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.picture_as_pdf),
                          title: Text('PDF File ${index + 1}'),

                          // Make the entire tile clickable for downloading
                          onTap: () async {
                            await launchUrl(Uri.parse(pdfUrls[index]));
                          },

                          // Adding a delete button to the right of the tile
                          trailing: Row(
                            mainAxisSize: MainAxisSize
                                .min, // Make the row as small as possible
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  removePdf(
                                      index); // Call the removePdf function
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () async {
                                  await launchUrl(Uri.parse(pdfUrls[index]));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
                if (imageUrls.isNotEmpty) ...[
                  const Text(
                    "Uploaded Images:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await launchUrl(Uri.parse(imageUrls[index]));
                            },
                            child: Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          // Delete Icon on top-right corner
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Call remove function here
                                removeImage(index);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ]
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
                style:
                    TextStyle(fontSize: 23, color: Colors.white), // Text style
              ),
            ),
          ),
        ));
  }
}
// ...........................................................................